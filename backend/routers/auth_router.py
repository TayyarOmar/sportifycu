from fastapi import APIRouter, HTTPException, status, BackgroundTasks, Body
from pydantic import EmailStr # BaseModel removed as SignupResponse moved to schemas.UserResponse
from typing import Optional
from datetime import timedelta 

from .. import crud, schemas, auth
from ..services import email_service
from ..config import settings

router = APIRouter(
    prefix="/api/v1/auth",
    tags=["Authentication"],
)

# SignupResponse is now schemas.UserResponse, no local SignupResponse needed

# --- Endpoints ---

@router.post("/signup", response_model=schemas.UserResponse, status_code=status.HTTP_201_CREATED)
async def signup(user_data: schemas.UserCreate):
    """
    Handles new user registration.

    This endpoint receives user creation data, validates if the email is already in use,
    and then creates a new user in the database. A 2FA secret key is automatically
    generated for the user but is disabled by default.

    Args:
        user_data: A `UserCreate` schema containing the new user's details like
                   username, email, and password.

    Raises:
        HTTPException(400): If the email provided is already registered.
        HTTPException(500): If the user account creation fails in the database.

    Returns:
        A `UserResponse` schema of the newly created user, including their ID,
        username, email, and other non-sensitive information.
    """
    db_user = crud.get_user_by_email(email=user_data.email)
    if db_user:
        print(f"Signup failed: Email already registered for {user_data.email}")
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Email already registered",
        )
    
    created_user = crud.create_user_db(user_data=user_data)
    if not created_user:
        print(f"Signup failed: Could not create user account for {user_data.email}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Could not create user account.",
        )

    # 2FA key is generated and set to is_2fa_enabled=False in crud.create_user_db
    # The created_user object (type User from models.py) will have these fields.
    # No need to update again or generate provisioning URI here.
    # Frontend can use created_user.two_fa_key to offer authenticator app setup if desired.

    return created_user # Return the full UserResponse (Pydantic will convert User model to UserResponse)

@router.post("/login", response_model=schemas.MessageResponse)
async def login_for_2fa_email_code(
    form_data: schemas.TwoFALoginRequest, 
    background_tasks: BackgroundTasks
):
    """
    Initiates the login process by verifying credentials and sending a 2FA code via email.

    This first step of login validates the user's email and password. If they are correct,
    it generates a temporary 6-digit code, stores it, and sends it to the user's
    registered email address as a background task. This endpoint does not return a JWT token.

    Args:
        form_data: A request body containing the user's email and password.
        background_tasks: FastAPI's background task runner to send the email without
                          blocking the response.

    Raises:
        HTTPException(401): If the provided email or password is incorrect.

    Returns:
        A `MessageResponse` indicating that a 2FA code has been sent to the user's email.
    """
    user = crud.get_user_by_email(email=form_data.email)
    if not user or not auth.verify_password(form_data.password, user.hashed_password):
        print(f"Login failed: Incorrect email or password for {form_data.email}")
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Incorrect email or password",
            headers={"WWW-Authenticate": "Bearer"},
        )

    # Generate a 6-digit code for email verification
    verification_code = auth.create_email_verification_code(email=user.email, code_type="2fa_login_code")
    
    print(f"Login successful for {form_data.email}. 2FA code sent to email.")
    background_tasks.add_task(
        email_service.send_2fa_login_email, 
        email_to=user.email, 
        code=verification_code # Send code instead of token
    )
    
    return schemas.MessageResponse(
        message="2FA verification required. A 6-digit code has been sent to your email."
    )

@router.post("/verify-2fa-code", response_model=schemas.Token) # Renamed endpoint, accepts code in body
async def verify_2fa_login_code(payload: schemas.VerifyCodeRequest = Body(...)):
    """
    Verifies the 2FA code and issues a JWT access token upon successful validation.

    This second step of login takes the 6-digit code sent to the user's email.
    It validates the code against the stored value. If valid, it generates a
    JWT access token for the user, completing the login process.

    Args:
        payload: A request body containing the user's email and the 6-digit code.

    Raises:
        HTTPException(400): If the provided 2FA code is invalid or has expired.
        HTTPException(404): If the user cannot be found after code verification.

    Returns:
        A `Token` schema containing the JWT `access_token` and `token_type`.
    """
    is_valid_code = auth.verify_stored_code(email=payload.email, code=payload.code, expected_type="2fa_login_code")
    if not is_valid_code:
        print(f"2FA code verification failed for {payload.email}.")
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Invalid or expired 2FA login code.",
        )
    
    print(f"2FA code successfully verified for {payload.email}.")
    user = crud.get_user_by_email(email=payload.email)
    if not user:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="User not found after code verification.",
        )

    access_token_expires = timedelta(minutes=settings.ACCESS_TOKEN_EXPIRE_MINUTES)
    access_token = auth.create_access_token(
        data={"sub": user.email}, expires_delta=access_token_expires
    )
    return schemas.Token(access_token=access_token, token_type="bearer")


@router.post("/request-password-reset", response_model=schemas.MessageResponse)
async def request_password_reset(
    email_data: schemas.EmailSchema, 
    background_tasks: BackgroundTasks
):
    user = crud.get_user_by_email(email=email_data.email)
    if not user:
        # For security, don't reveal if user exists. Generic message is better in prod.
        # However, for dev simplicity, we can keep 404 for now.
        # To make it opaque, always return the same success message.
        # print(f"Password reset requested for non-existent user: {email_data.email}") # For logging
        # return schemas.MessageResponse(message="If your email is registered, you will receive a password reset code.")
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="User with this email not found.",
        )

    # Generate and send 6-digit code for password reset
    reset_code = auth.create_email_verification_code(email=user.email, code_type="password_reset_code")
    background_tasks.add_task(
        email_service.send_password_reset_email,
        email_to=user.email,
        code=reset_code # Send code
    )
    return schemas.MessageResponse(message="Password reset code sent to your email if it is registered.")


@router.post("/confirm-password-reset", response_model=schemas.MessageResponse)
async def confirm_password_reset_with_code(
    payload: schemas.PasswordResetConfirmWithCodeRequest = Body(...)
):
    is_valid_code = auth.verify_stored_code(email=payload.email, code=payload.code, expected_type="password_reset_code")
    if not is_valid_code:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Invalid or expired password reset code.",
        )
    
    user = crud.get_user_by_email(email=payload.email)
    if not user: # Should be caught by code verification if email isn't in store, but good check.
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND, 
            detail="User not found for password reset."
        )

    hashed_password = auth.get_password_hash(payload.new_password)
    # Use the more specific crud.update_password_db
    updated_user = crud.update_password_db(user_id=user.user_id, new_hashed_password=hashed_password)
    
    if not updated_user:
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Could not update password."
        )
    
    # Optionally, clear the code from the store after successful reset
    if payload.email in auth.temp_code_store and auth.temp_code_store[payload.email]["type"] == "password_reset_code":
        del auth.temp_code_store[payload.email]

    return schemas.MessageResponse(message="Password has been reset successfully.") 
from fastapi import APIRouter, HTTPException, status, BackgroundTasks, Body
from pydantic import EmailStr, BaseModel # BaseModel for local schemas
from typing import Optional
from datetime import timedelta 

from .. import crud, schemas, auth
from ..services import email_service
from ..config import settings

router = APIRouter(
    prefix="/api/v1/auth",
    tags=["Authentication"],
)

# --- Local Schemas Specific to this Router ---
# PasswordResetConfirmPayload is replaced by PasswordResetConfirmWithCodeRequest from schemas.py
# class PasswordResetConfirmPayload(BaseModel):
#     new_password: str

class SignupResponse(BaseModel):
    user_id: str
    email: EmailStr
    name: str
    message: str
    otp_provisioning_uri: Optional[str] = None


# --- Endpoints ---

@router.post("/signup", response_model=SignupResponse, status_code=status.HTTP_201_CREATED)
async def signup(user_data: schemas.UserCreate):
    db_user = crud.get_user_by_email(email=user_data.email)
    if db_user:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Email already registered",
        )
    
    created_user = crud.create_user_db(user_data=user_data)
    if not created_user:
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Could not create user account.",
        )

    two_fa_key = auth.generate_2fa_secret_key()
    user_update_data = {"two_fa_key": two_fa_key, "is_2fa_enabled": True} # Enable app-based 2FA by default
    
    updated_user = crud.update_user_db(user_id=created_user.user_id, user_update_data=user_update_data)
    if not updated_user or not updated_user.two_fa_key:
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Could not set up 2FA for the user."
        )

    provisioning_uri = auth.get_2fa_provisioning_uri(
        email=updated_user.email, 
        secret_key=updated_user.two_fa_key,
        issuer_name="SportifyApp"
    )

    return SignupResponse(
        user_id=updated_user.user_id,
        email=updated_user.email,
        name=updated_user.name,
        message="User created. Scan QR for TOTP 2FA. Email code login also available.", # Updated message
        otp_provisioning_uri=provisioning_uri
    )

@router.post("/login", response_model=schemas.MessageResponse) # Changed response model
async def login_for_2fa_email_code(
    form_data: schemas.TwoFALoginRequest, 
    background_tasks: BackgroundTasks
):
    user = crud.get_user_by_email(email=form_data.email)
    if not user or not auth.verify_password(form_data.password, user.hashed_password):
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Incorrect email or password",
            headers={"WWW-Authenticate": "Bearer"},
        )

    # Generate a 6-digit code for email verification
    verification_code = auth.create_email_verification_code(email=user.email, code_type="2fa_login_code")
    
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
    is_valid_code = auth.verify_stored_code(email=payload.email, code=payload.code, expected_type="2fa_login_code")
    if not is_valid_code:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Invalid or expired 2FA login code.",
        )
    
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
    updated_user = crud.update_user_db(user_id=user.user_id, user_update_data={"hashed_password": hashed_password})
    
    if not updated_user:
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Could not update password."
        )
    
    # Optionally, clear the code from the store after successful reset
    if payload.email in auth.temp_code_store and auth.temp_code_store[payload.email]["type"] == "password_reset_code":
        del auth.temp_code_store[payload.email]

    return schemas.MessageResponse(message="Password has been reset successfully.") 
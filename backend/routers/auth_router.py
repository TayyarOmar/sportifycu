from fastapi import APIRouter, Depends, HTTPException, status, BackgroundTasks, Body, Query
from pydantic import EmailStr, BaseModel # BaseModel for local schemas
from typing import Optional

from .. import crud, schemas, auth, models
from ..services import email_service
from ..config import settings

router = APIRouter(
    prefix="/api/v1/auth",
    tags=["Authentication"],
)

# --- Local Schemas Specific to this Router ---
class PasswordResetConfirmPayload(BaseModel):
    new_password: str

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
    
    # Create user without 2FA first
    created_user = crud.create_user_db(user_data=user_data)
    if not created_user:
        # This case should ideally be caught by the email check, but as a fallback
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Could not create user account.",
        )

    # Generate and set 2FA key
    two_fa_key = auth.generate_2fa_secret_key()
    user_update_data = {"two_fa_key": two_fa_key, "is_2fa_enabled": True}
    
    updated_user = crud.update_user_db(user_id=created_user.user_id, user_update_data=user_update_data)
    if not updated_user or not updated_user.two_fa_key:
        # Attempt to delete the partially created user or log error
        # For now, raise an error indicating 2FA setup failure
        # crud.delete_user_db(created_user.user_id) # If a delete function exists
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
        message="User created successfully. Please set up 2FA with the provided URI.",
        otp_provisioning_uri=provisioning_uri
    )

@router.post("/login", response_model=schemas.TwoFALoginResponse)
async def login_for_2fa_email(
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

    if not user.is_2fa_enabled or not user.two_fa_key:
        # This case should ideally not happen if signup enforces 2FA
        # Or, it could be a flow for users who haven't completed 2FA setup
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="2FA is not enabled or configured for this user. Please complete setup or contact support.",
        )

    # Generate a temporary token for email verification
    verification_token = auth.create_verification_token(email=user.email, token_type="2fa_login_verification")
    
    # Send email in the background
    background_tasks.add_task(
        email_service.send_2fa_login_email, 
        email_to=user.email, 
        token=verification_token
    )
    
    return schemas.TwoFALoginResponse(
        message="2FA verification required. An email has been sent with a login link."
    )

@router.get("/verify-2fa-login", response_model=schemas.Token)
async def verify_2fa_login_token(token: str = Query(...)):
    email = auth.verify_verification_token(token, expected_type="2fa_login_verification")
    if not email:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Invalid or expired 2FA login token.",
        )
    
    user = crud.get_user_by_email(email=email)
    if not user:
        # Should not happen if token was valid and for a real user
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="User not found after token verification.",
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
        # Return a generic message to avoid disclosing whether an email is registered
        # However, for simplicity in this phase, we can be direct.
        # For production, consider not revealing if user exists.
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="User with this email not found.",
        )

    verification_token = auth.create_verification_token(email=user.email, token_type="password_reset")
    background_tasks.add_task(
        email_service.send_password_reset_email,
        email_to=user.email,
        token=verification_token
    )
    return schemas.MessageResponse(message="Password reset email sent if user exists.")


@router.post("/confirm-password-reset", response_model=schemas.MessageResponse)
async def confirm_password_reset(
    token: str = Query(...),
    payload: PasswordResetConfirmPayload = Body(...)
):
    email = auth.verify_verification_token(token, expected_type="password_reset")
    if not email:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Invalid or expired password reset token.",
        )
    
    user = crud.get_user_by_email(email=email)
    if not user:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND, # Should not happen if token was valid for an email
            detail="User not found for password reset."
        )

    hashed_password = auth.get_password_hash(payload.new_password)
    updated_user = crud.update_user_db(user_id=user.user_id, user_update_data={"hashed_password": hashed_password})
    
    if not updated_user:
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Could not update password."
        )
    return schemas.MessageResponse(message="Password has been reset successfully.")

# Need to import timedelta for access_token_expires
from datetime import timedelta 
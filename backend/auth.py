from datetime import datetime, timedelta, timezone
from typing import Optional, Dict
import random # For generating 6-digit codes

from jose import JWTError, jwt
from passlib.context import CryptContext
import pyotp

from .config import settings
from .schemas import TokenData

# Password Hashing
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

# In-memory store for 2FA codes and password reset codes
# Structure: {"email@example.com": {"code": "123456", "expires_at": datetime_object, "type": "2fa_login" / "password_reset"}}
temp_code_store: Dict[str, Dict[str, any]] = {}
CODE_EXPIRY_MINUTES = 10 # Codes expire after 10 minutes

def verify_password(plain_password: str, hashed_password: str) -> bool:
    return pwd_context.verify(plain_password, hashed_password)

def get_password_hash(password: str) -> str:
    return pwd_context.hash(password)

# JWT Token Handling
def create_access_token(data: dict, expires_delta: Optional[timedelta] = None) -> str:
    to_encode = data.copy()
    if expires_delta:
        expire = datetime.now(timezone.utc) + expires_delta
    else:
        expire = datetime.now(timezone.utc) + timedelta(minutes=settings.ACCESS_TOKEN_EXPIRE_MINUTES)
    to_encode.update({"exp": expire})
    encoded_jwt = jwt.encode(to_encode, settings.SECRET_KEY, algorithm=settings.ALGORITHM)
    return encoded_jwt

def decode_access_token(token: str) -> Optional[TokenData]:
    try:
        payload = jwt.decode(token, settings.SECRET_KEY, algorithms=[settings.ALGORITHM])
        email: Optional[str] = payload.get("sub")
        if email is None:
            return None
        return TokenData(email=email)
    except JWTError:
        return None

# Two-Factor Authentication (2FA) using TOTP (for authenticator apps)
def generate_2fa_secret_key() -> str:
    return pyotp.random_base32()

def get_2fa_provisioning_uri(email: str, secret_key: str, issuer_name: str = "SportifyApp") -> str:
    return pyotp.totp.TOTP(secret_key).provisioning_uri(name=email, issuer_name=issuer_name)

def verify_2fa_code(secret_key: str, code: str) -> bool:
    totp = pyotp.TOTP(secret_key)
    return totp.verify(code)

# --- Email-based 6-digit code verification ---

def generate_6_digit_code() -> str:
    """Generates a random 6-digit code."""
    return str(random.randint(100000, 999999))

def store_verification_code(email: str, code: str, code_type: str):
    """Stores the 6-digit code in the temporary store with an expiration time."""
    expires_at = datetime.now(timezone.utc) + timedelta(minutes=CODE_EXPIRY_MINUTES)
    temp_code_store[email] = {"code": code, "expires_at": expires_at, "type": code_type}
    # print(f"Code stored for {email}: {code}, type: {code_type}, expires: {expires_at}") # For debugging

def verify_stored_code(email: str, code: str, expected_type: str) -> bool:
    """Verifies the 6-digit code from the store and checks its expiration and type."""
    stored_info = temp_code_store.get(email)
    if not stored_info:
        # print(f"No code found for {email}") # For debugging
        return False
    
    if stored_info["code"] == code and \
       stored_info["type"] == expected_type and \
       stored_info["expires_at"] > datetime.now(timezone.utc):
        # print(f"Code verified for {email}") # For debugging
        # Optionally, remove the code after successful verification
        # del temp_code_store[email]
        return True
    # print(f"Code verification failed for {email}. Stored: {stored_info['code']}, Expected: {code}, Type Stored: {stored_info['type']}, Expected Type: {expected_type}, Expired: {stored_info['expires_at'] <= datetime.now(timezone.utc)}") # For debugging
    return False

# Functions to replace JWT-based email verification tokens
# These will now use the 6-digit code mechanism

def create_email_verification_code(email: str, code_type: str) -> str:
    """Generates, stores, and returns a 6-digit code for email verification."""
    code = generate_6_digit_code()
    store_verification_code(email, code, code_type)
    return code

# The verify_verification_token (JWT based) is no longer needed for email codes.
# We will use verify_stored_code directly in the router.
# The old verify_verification_token might still be used if JWT tokens are used for other purposes.
# For now, let's comment it out to avoid confusion if it's solely for email links.

# Temporary token for email verification (e.g., for 2FA login link or password reset)
# This is different from the main access token

# Duration for temporary tokens (e.g., 15 minutes)
# TEMP_TOKEN_EXPIRE_MINUTES = 15

# def create_verification_token(email: str, token_type: str = "generic_verification") -> str:
#     expires = timedelta(minutes=TEMP_TOKEN_EXPIRE_MINUTES)
#     expire = datetime.now(timezone.utc) + expires
#     to_encode = {
#         "exp": expire,
#         "sub": email,
#         "type": token_type # e.g., '2fa_login_verification', 'password_reset'
#     }
#     encoded_jwt = jwt.encode(to_encode, settings.SECRET_KEY, algorithm=settings.ALGORITHM)
#     return encoded_jwt

# def verify_verification_token(token: str, expected_type: Optional[str] = None) -> Optional[str]: # Returns email if valid
#     try:
#         payload = jwt.decode(token, settings.SECRET_KEY, algorithms=[settings.ALGORITHM])
#         email: Optional[str] = payload.get("sub")
#         token_type: Optional[str] = payload.get("type")
        
#         if email is None:
#             return None
#         if expected_type and token_type != expected_type:
#             return None # Token is for a different purpose
            
#         return email
#     except JWTError:
#         return None 
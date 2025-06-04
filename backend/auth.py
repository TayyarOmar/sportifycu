from datetime import datetime, timedelta, timezone
from typing import Optional, Tuple

from jose import JWTError, jwt
from passlib.context import CryptContext
import pyotp

from .config import settings
from .schemas import TokenData
from .models import User # To fetch user for 2FA key etc.

# Password Hashing
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

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

# Two-Factor Authentication (2FA) using TOTP
def generate_2fa_secret_key() -> str:
    return pyotp.random_base32()

def get_2fa_provisioning_uri(email: str, secret_key: str, issuer_name: str = "SportifyApp") -> str:
    return pyotp.totp.TOTP(secret_key).provisioning_uri(name=email, issuer_name=issuer_name)

def verify_2fa_code(secret_key: str, code: str) -> bool:
    totp = pyotp.TOTP(secret_key)
    return totp.verify(code)

# Temporary token for email verification (e.g., for 2FA login link or password reset)
# This is different from the main access token

# Duration for temporary tokens (e.g., 15 minutes)
TEMP_TOKEN_EXPIRE_MINUTES = 15

def create_verification_token(email: str, token_type: str = "generic_verification") -> str:
    expires = timedelta(minutes=TEMP_TOKEN_EXPIRE_MINUTES)
    expire = datetime.now(timezone.utc) + expires
    to_encode = {
        "exp": expire,
        "sub": email,
        "type": token_type # e.g., '2fa_login_verification', 'password_reset'
    }
    encoded_jwt = jwt.encode(to_encode, settings.SECRET_KEY, algorithm=settings.ALGORITHM)
    return encoded_jwt

def verify_verification_token(token: str, expected_type: Optional[str] = None) -> Optional[str]: # Returns email if valid
    try:
        payload = jwt.decode(token, settings.SECRET_KEY, algorithms=[settings.ALGORITHM])
        email: Optional[str] = payload.get("sub")
        token_type: Optional[str] = payload.get("type")
        
        if email is None:
            return None
        if expected_type and token_type != expected_type:
            return None # Token is for a different purpose
            
        return email
    except JWTError:
        return None 
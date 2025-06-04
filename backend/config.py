from pydantic_settings import BaseSettings
from pydantic import EmailStr

class Settings(BaseSettings):
    SECRET_KEY: str = "your_strong_secret_key_for_jwt"  # Should be overridden by .env
    ALGORITHM: str = "HS256"
    ACCESS_TOKEN_EXPIRE_MINUTES: int = 30
    DATABASE_URL: str = "sportify_db.json"
    GOOGLE_API_KEY: str = "your_google_maps_api_key"

    # Email settings for Gmail
    MAIL_USERNAME: str = "sportifyapp2025@gmail.com" # Your full Gmail address
    MAIL_PASSWORD: str = "ntybuzyjsmfsvgmj" # <<< IMPORTANT: Use an App Password, not your regular password!
    MAIL_FROM: EmailStr = "sportifyapp2025@gmail.com" # Your full Gmail address
    MAIL_PORT: int = 587 # For STARTTLS
    MAIL_SERVER: str = "smtp.gmail.com"
    MAIL_STARTTLS: bool = True # Use STARTTLS
    MAIL_SSL_TLS: bool = False # Not strictly necessary if using STARTTLS, but ensure it's False for 587

    class Config:
        env_file = ".env"
        env_file_encoding = 'utf-8'

settings = Settings() 
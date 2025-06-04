from pydantic_settings import BaseSettings
from pydantic import EmailStr

class Settings(BaseSettings):
    SECRET_KEY: str = "your_strong_secret_key_for_jwt"  # Should be overridden by .env
    ALGORITHM: str = "HS256"
    ACCESS_TOKEN_EXPIRE_MINUTES: int = 30
    DATABASE_URL: str = "sportify_db.json"
    GOOGLE_API_KEY: str = "your_google_maps_api_key"

    # Email settings
    MAIL_USERNAME: str = "your_email_username"
    MAIL_PASSWORD: str = "your_email_password"
    MAIL_FROM: EmailStr = "your_sending_email@example.com"
    MAIL_PORT: int = 587
    MAIL_SERVER: str = "smtp.example.com"
    MAIL_STARTTLS: bool = True
    MAIL_SSL_TLS: bool = False


    class Config:
        env_file = ".env"
        env_file_encoding = 'utf-8'

settings = Settings() 
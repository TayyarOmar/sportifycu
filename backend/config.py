from pydantic_settings import BaseSettings
from pydantic import EmailStr

class Settings(BaseSettings):
    SECRET_KEY: str
    ALGORITHM: str
    ACCESS_TOKEN_EXPIRE_MINUTES: int
    DATABASE_URL: str
    GOOGLE_API_KEY: str

    # DeepSeek (OpenAI-compatible) API key for AI Coach feature
    DEEPSEEK_API_KEY: str

    # Email settings for Gmail
    MAIL_USERNAME: str
    MAIL_PASSWORD: str
    MAIL_FROM: EmailStr
    MAIL_PORT: int
    MAIL_SERVER: str
    MAIL_STARTTLS: bool
    MAIL_SSL_TLS: bool

    class Config:
        env_file = ".env"
        env_file_encoding = 'utf-8'

settings = Settings() 
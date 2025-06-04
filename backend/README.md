# Sportify Backend

This is the Python backend for the Sportify fitness application, built with FastAPI and TinyDB.

## Setup Instructions

1.  **Ensure `uv` is installed.**
    If not, you can install it via pip:
    ```bash
    pip install uv
    ```

2.  **Create a virtual environment (recommended):**
    ```bash
    python -m venv .venv
    source .venv/bin/activate  # On Windows: .venv\Scripts\activate
    ```
    Or using `uv`:
    ```bash
    uv venv
    source .venv/bin/activate # On Windows: .venv\Scripts\activate
    ```


3.  **Install dependencies using `uv`:**
    Navigate to the `backend` directory where this README is located.
    ```bash
    uv pip install fastapi uvicorn[standard] "pydantic[email]" pydantic-settings tinydb "python-jose[cryptography]" "passlib[bcrypt]" pyotp python-multipart google-api-python-client google-auth-httplib2 google-auth-oauthlib emails uuid
    ```
    *(Note: `uuid` is part of the standard library but explicitly listed for clarity if any specific version were ever needed via direct dependencies; `uv` handles standard library components correctly without explicit install.)*


4.  **Configure Environment Variables:**
    Create a `.env` file in the `backend` directory and add the necessary configuration (this will be read by `config.py`):
    ```env
    SECRET_KEY=your_strong_secret_key_for_jwt
    ALGORITHM=HS256
    ACCESS_TOKEN_EXPIRE_MINUTES=30
    DATABASE_URL=./sportify_db.json
    GOOGLE_API_KEY=your_google_maps_api_key # For GCloud integration
    
    # Email configuration (example for a generic SMTP, can be adapted)
    MAIL_USERNAME=your_email_username
    MAIL_PASSWORD=your_email_password
    MAIL_FROM=your_sending_email@example.com
    MAIL_PORT=587
    MAIL_SERVER=smtp.example.com
    MAIL_STARTTLS=True
    MAIL_SSL_TLS=False 
    ```

5.  **Run the application:**
    From the `backend` directory:
    ```bash
    uvicorn main:app --reload
    ```
    The application will typically be available at `http://127.0.0.1:8000`.

## Project Structure

```
backend/
├── .env                  # Local environment configurations (create this file)
├── main.py               # FastAPI application entry point
├── config.py             # Application configuration settings
├── models.py             # Pydantic data models (database entities)
├── schemas.py            # Pydantic schemas (API request/response validation)
├── database.py           # TinyDB setup and database instance
├── crud.py               # CRUD operations for database interaction
├── auth.py               # Authentication, password hashing, JWT, 2FA logic
├── dependencies.py       # FastAPI dependencies (e.g., get current user)
├── utils.py              # Utility functions
├── routers/              # API route definitions
│   ├── auth_router.py
│   ├── users_router.py
│   ├── gyms_router.py
│   ├── activity_teams_router.py
│   └── leaderboard_router.py
├── services/             # External service integrations
│   ├── email_service.py
│   └── gcloud_service.py
└── README.md             # This file
``` 
# Sportify Backend

This is the Python backend for the Sportify fitness application, built with FastAPI and TinyDB.

## Setup Instructions

1. **Ensure `uv` is installed.**
    If not, you can install it via pip:

    ```bash
    pip install uv
    ```

2. **Create a virtual environment using `uv` (recommended):**

    ```bash
    uv venv
    source .venv/bin/activate # On Windows: .venv\Scripts\activate
    ```

3. **Install dependencies using `uv`:**
    Navigate to the project root directory and use:

    ```bash
    uv add fastapi uvicorn "pydantic[email]" pydantic-settings tinydb "python-jose[cryptography]" "passlib[bcrypt]" pyotp python-multipart google-api-python-client google-auth-httplib2 google-auth-oauthlib fastapi-mail httpx "fuzzywuzzy[speedup]" python-Levenshtein pytest pytest-asyncio
    ```

4. **Configure Environment Variables:**
    Create a `.env` file in the `backend` directory and add the necessary configuration (this will be read by `config.py`):

    ```env
    SECRET_KEY=your_strong_secret_key_for_jwt
    ALGORITHM=HS256
    ACCESS_TOKEN_EXPIRE_MINUTES=30
    DATABASE_URL=./sportify_db.json
    GOOGLE_API_KEY=your_google_maps_api_key # For Google Places API integration
    
    # Email configuration (Gmail example)
    MAIL_USERNAME=your_gmail@gmail.com
    MAIL_PASSWORD=your_app_password # Use Gmail App Password, not regular password
    MAIL_FROM=your_gmail@gmail.com
    MAIL_PORT=587
    MAIL_SERVER=smtp.gmail.com
    MAIL_STARTTLS=True
    MAIL_SSL_TLS=False 
    ```

5. **Run the application:**
    From the project root directory:

    ```bash
    uv run uvicorn backend.main:app --reload
    ```

    The application will be available at `http://127.0.0.1:8000`.

6. **Run tests:**

    ```bash
    uv run pytest backend/tests/test_api.py -v
    ```

## API Endpoints

### Authentication

- `POST /api/v1/auth/signup` - User registration (returns 2FA QR code provisioning URI)
- `POST /api/v1/auth/login` - User login (sends 2FA verification email)
- `GET /api/v1/auth/verify-2fa-login` - Verify 2FA login token (requires token parameter)
- `POST /api/v1/auth/request-password-reset` - Request password reset (sends reset email)
- `POST /api/v1/auth/confirm-password-reset` - Confirm password reset (requires token parameter)

### User Management

*All user endpoints require authentication (Bearer token)*

- `GET /api/v1/users/me` - Get current user profile
- `PUT /api/v1/users/me/profile` - Update user profile (name, gender, age, fitness_goals)
- `GET /api/v1/users/me/activity-tracking` - Get activity tracking summary with calculated score
- `POST /api/v1/users/me/activity-log` - Add general activity log (any activity type)
- `POST /api/v1/users/me/activity-log/running` - Log/update running activity for a date (km)
- `POST /api/v1/users/me/activity-log/steps` - Log/update steps activity for a date (count)
- `POST /api/v1/users/me/activity-log/gym-time` - Log/update gym time activity for a date (minutes)
- `POST /api/v1/users/me/favourites/{gym_id}` - Add gym to favourites
- `DELETE /api/v1/users/me/favourites/{gym_id}` - Remove gym from favourites
- `PUT /api/v1/users/me/notification-settings` - Update notification settings (enabled/disabled)
- `GET /api/v1/users/me/bookings` - Get user's activity team bookings
- `GET /api/v1/users/me/achievements` - Get user's achievements

### Gyms

- `GET /api/v1/gyms/` - Get all gyms
- `GET /api/v1/gyms/around-you` - Find nearby gyms using Google Places API (requires latitude & longitude parameters)

### Activity Teams

- `GET /api/v1/activity-teams/` - Get all active activity teams (public access)
- `POST /api/v1/activity-teams/` - Create new activity team (requires authentication, supports file upload for photo)
- `PUT /api/v1/activity-teams/{team_id}` - Update activity team (owner only)
- `DELETE /api/v1/activity-teams/{team_id}` - Delete activity team (owner only)
- `POST /api/v1/activity-teams/{team_id}/bookings` - Book into activity team (requires authentication)

### Leaderboards

- `GET /api/v1/leaderboards/top-scores` - Get top users by activity score (supports optional limit parameter)

## Activity Logging System

The system supports three main activity types with date-based logging:

- **Running**: Measured in kilometers (km)
- **Steps**: Measured in steps count
- **Gym Time**: Measured in minutes

### Key Features

- **One entry per activity type per date**: If you log the same activity type on the same date, it overwrites the previous entry
- **Automatic score calculation**: The system calculates a fitness score based on all three activities
- **Date-based tracking**: Each activity is tied to a specific date (without time)

### Example Usage

```json
POST /api/v1/users/me/activity-log/running
{
  "date": "2024-01-15",
  "value": 5.2
}

POST /api/v1/users/me/activity-log/steps
{
  "date": "2024-01-15", 
  "value": 12000
}

POST /api/v1/users/me/activity-log/gym-time
{
  "date": "2024-01-15",
  "value": 90
}
```

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
├── tests/                # Test suite
│   ├── conftest.py
│   ├── test_api.py
│   └── README.md
├── database_data/        # Development data scripts
│   ├── add_user.py
│   ├── add_gym.py
│   ├── add_group_activity_team.py
│   └── README.md
└── README.md             # This file
```

# SportiFy - Discover Your Favorite Sport

SportiFy is a comprehensive mobile application designed to connect fitness enthusiasts with gyms, group activities, and a community of like-minded individuals. It's a one-stop-shop for booking fitness classes, joining sports teams, tracking personal activity, and competing on a leaderboard.

This project contains both the frontend Flutter application and the backend FastAPI server.

## Table of Contents

- [Features](#features)
- [Tech Stack](#tech-stack)
- [Project Structure](#project-structure)
- [Prerequisites](#prerequisites)
- [Setup & Installation](#setup--installation)
  - [Backend (FastAPI)](#backend-fastapi)
  - [Frontend (Flutter)](#frontend-flutter)
- [Running the Application](#running-the-application)
- [API Endpoints Overview](#api-endpoints-overview)
- [Contributing](#contributing)
- [License](#license)

## Features

### Frontend (Flutter App)

- **Authentication**: Secure user signup, login with 2FA email verification, and password reset.
- **Personalized Profiles**: Users can set their gender, age, and fitness goals.
- **Gym Discovery**: Explore gyms on a map, view details, services, and subscription plans.
- **Favorite Gyms**: Bookmark and easily access favorite facilities.
- **Group Activities**: Create and join teams for various sports like Tennis, Football, and Basketball.
- **Booking System**: Book a spot in group activities.
- **Activity Tracking**: Log daily steps, gym time, and running distance.
- **Leaderboard**: Compete with other users based on a calculated activity score.
- **User Profile**: View and edit personal information, see bookings, and achievements.
- **Dark/Light Mode**: Switch between themes for user comfort.

### Backend (FastAPI Server)

- **User Management**: Full CRUD operations for users.
- **Secure Auth**: JWT-based authentication, password hashing, and 2FA logic.
- **Gym Management**: Endpoints for listing all gyms and finding nearby gyms using Google Places API (with fuzzy matching to local DB).
- **Group Activity Management**: Full CRUD for creating, updating, and deleting activity teams.
- **Booking Engine**: Logic for users to book teams and for teams to track enrolled players.
- **Activity Logging**: Endpoints to log various types of user activities and update them daily.
- **Leaderboard Engine**: Calculates user scores and provides a ranked list.
- **Email Service**: Sends emails for 2FA codes and password resets.
- **JSON Database**: Uses TinyDB for lightweight, file-based data storage.

## Tech Stack

- **Frontend**:
  - Flutter 3.x
  - Dart
  - Provider (for state management)
  - `http` (for API communication)
  - `google_maps_flutter`, `geolocator` (for location services)
  - `image_picker` (for uploading images)
- **Backend**:
  - Python 3.11+
  - FastAPI (for the web server)
  - Uvicorn (as the ASGI server)
  - TinyDB (as the JSON database)
  - `python-jose` & `passlib` (for security)
  - Pydantic (for data validation)
- **Development**:
  - `uv` (for Python package and environment management)

## Project Structure

```
.
├── android/            # Flutter Android project
├── backend/            # FastAPI backend source code
│   ├── routers/        # API route definitions
│   ├── services/       # Business logic (email, GCloud)
│   ├── tests/          # Backend tests
│   ├── requirements.txt # Python dependencies
│   └── main.py         # Main application entry point
├── assets/             # Images and other static assets for Flutter
├── ios/                # Flutter iOS project
├── lib/                # Flutter application source code
│   ├── api/            # Dart classes to communicate with the backend
│   ├── models/         # Dart data models
│   ├── presentation/   # Widgets and Screens (UI)
│   ├── providers/      # State management providers
│   ├── utils/          # Utility classes and constants
│   └── main.dart       # Main Flutter application entry point
├── sportify_db.json    # The JSON database file
└── README.md           # This file
```

## Prerequisites

Before you begin, ensure you have the following installed on your system:

- **Flutter SDK**: [Installation Guide](https://flutter.dev/docs/get-started/install)
- **Python**: Version 3.11 or newer.
- **uv**: A fast Python package installer and resolver. [Installation Guide](https://github.com/astral-sh/uv#installation)

## Setup & Installation

Clone the repository to your local machine:
```bash
git clone <repository-url>
cd <repository-folder>
```

### Backend (FastAPI)

1.  **Navigate to the backend directory**:
    ```bash
    cd backend
    ```

2.  **Sync the environment and install dependencies**:
    `uv sync` will automatically create a virtual environment in `.venv` if one doesn't exist and install the dependencies specified in `pyproject.toml`.
    ```bash
    uv sync
    ```

3.  **Activate the virtual environment**:
    After syncing, you'll need to activate the environment to run commands within it.
    ```bash
    source .venv/bin/activate  # On Windows, use `.venv\Scripts\activate`
    ```

4.  **Set up Environment Variables**:
    The backend requires certain API keys and settings. Create a file named `.env` in the `backend` directory by copying the example.

    ```bash
    # In the backend/ directory
    cp .env.example .env
    ```

    Now, open the `.env` file and fill in the required values:

    ```env
    # backend/.env
    
    # A strong, random string used for signing JWTs.
    SECRET_KEY="your_strong_secret_key_for_jwt"
    
    # Your Google Maps API key for the "Places API"
    GOOGLE_API_KEY="your_google_maps_api_key"
    
    # Email settings for sending 2FA codes and password resets
    # IMPORTANT: For Gmail, use an "App Password", not your regular account password.
    # See: https://support.google.com/accounts/answer/185833
    MAIL_USERNAME="your-email@gmail.com"
    MAIL_PASSWORD="your_gmail_app_password"
    MAIL_FROM="your-email@gmail.com"
    ```

    > **Note**: If you run the app without a valid `GOOGLE_API_KEY`, the "Gyms Around You" feature will return mock data as a fallback.

### Frontend (Flutter)

1.  **Navigate to the project root directory** (if you are in the `backend` directory, go back one level).
    ```bash
    cd ..
    ```

2.  **Get Flutter dependencies**:
    ```bash
    flutter pub get
    ```

## Running the Application

You need to run both the backend server and the frontend application simultaneously.

1.  **Run the Backend Server**:
    Open a terminal, navigate to the `backend` directory, activate the virtual environment (if it's not already active from the setup step), and run:
    ```bash
    # In /backend
    source .venv/bin/activate
    uvicorn backend.main:app --reload
    ```
    The server will start, typically on `http://127.0.0.1:8000`.

2.  **Run the Frontend Application**:
    Open a separate terminal, ensure you are in the project's root directory. Connect a device or start an emulator, and then run:
    ```bash
    # In project root
    flutter run
    ```
    The app will build and install on your selected device. It is configured to connect to the backend server at `http://10.0.2.2:8000` on Android and `http://localhost:8000` on other platforms.

## API Endpoints Overview

The backend provides a RESTful API with the following main routers:

-   `/api/v1/auth`: User authentication (signup, login, 2FA, password reset).
-   `/api/v1/users`: User profile management (get/update profile, log activities, manage favorites).
-   `/api/v1/gyms`: Gym information (get all, find nearby).
-   `/api/v1/activity-teams`: Group activities (create, view, update, delete, book).
-   `/api/v1/leaderboards`: Access to the user leaderboard.

For detailed information on each endpoint, refer to the FastAPI auto-generated documentation available at `http://127.0.0.1:8000/docs` when the backend server is running.

## Contributing

Contributions are welcome! If you have suggestions for improving the app, please feel free to open an issue or submit a pull request.

1.  Fork the repository.
2.  Create a new branch (`git checkout -b feature/YourFeature`).
3.  Commit your changes (`git commit -m 'Add some feature'`).
4.  Push to the branch (`git push origin feature/YourFeature`).
5.  Open a Pull Request.

## License

This project is licensed under the MIT License. See the `LICENSE` file for more details. (Note: A `LICENSE` file should be added if one is intended). 
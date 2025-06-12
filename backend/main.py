from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from fastapi.staticfiles import StaticFiles # Import StaticFiles
import os # For path joining

from .routers import auth_router, users_router, gyms_router, activity_teams_router, leaderboard_router, ai_coach_router

# Potentially, define app metadata
app_metadata = {
    "title": "Sportify App API",
    "description": "Backend API for the Sportify fitness application.",
    "version": "0.1.0",
    # Add other metadata like contact, license_info if desired
}

app = FastAPI(**app_metadata)

# CORS (Cross-Origin Resource Sharing) Middleware
# Allow all origins for development. For production, restrict this to your frontend domain(s).
origins = [
    # "http://localhost",          # Common local development origin
    # "http://localhost:3000",     # React default dev port
    # "http://localhost:8080",     # Vue default dev port
    # "http://localhost:4200",     # Angular default dev port
    # # Add your Flutter app's web origin if applicable, or mobile specific considerations might apply
    "*",
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"], # or ["*"] for allowing all origins (less secure for production)
    allow_credentials=True,
    allow_methods=["*"], # Allows all methods (GET, POST, PUT, DELETE, etc.)
    allow_headers=["*"], # Allows all headers
)

# Mount static files directory
# This will serve files from backend/static under the /static URL path
# Ensure the 'static' directory exists at the root of the 'backend' package.
# The UPLOAD_DIR for photos is backend/static/uploads/team_photos
# So a photo URL like /static/uploads/team_photos/image.png will work.

# Construct an absolute path to the static directory relative to this main.py file
# This assumes main.py is in the 'backend' directory.
static_dir = os.path.join(os.path.dirname(os.path.abspath(__file__)), "static")

# Ensure the static directory itself exists before trying to mount it
if not os.path.exists(static_dir):
    os.makedirs(static_dir)
    print(f"Created static directory at: {static_dir}")
    # We also need the subdirectories for uploads if they weren't created by terminal commands
    os.makedirs(os.path.join(static_dir, "uploads", "team_photos"), exist_ok=True)

app.mount("/static", StaticFiles(directory=static_dir), name="static")

# Include Routers
app.include_router(auth_router.router)
app.include_router(users_router.router)
app.include_router(gyms_router.router)
app.include_router(activity_teams_router.router)
app.include_router(leaderboard_router.router)
app.include_router(ai_coach_router.router)

@app.get("/", tags=["Root"])
async def read_root():
    return {"message": f"Welcome to the {app_metadata.get('title', 'Sportify App API')}! Navigate to /docs for API documentation."}

# Example of shutdown event (e.g., to close DB connection if it were necessary)
# @app.on_event("shutdown")
# def shutdown_event():
#     db.close() # TinyDB typically handles file closure well, but explicit close is an option. 
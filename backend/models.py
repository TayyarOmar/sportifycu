from pydantic import BaseModel, EmailStr, HttpUrl, Field
from typing import List, Optional
from datetime import datetime, date
import uuid

# Helper function for generating default UUIDs
def default_uuid():
    return str(uuid.uuid4())

class ActivityLog(BaseModel):
    date: date
    activity_type: str # e.g., "running", "steps", "gym_time"
    value: float
    unit: str # e.g., "km", "steps", "minutes"
    # score_contribution: Optional[float] # Score calculation might be dynamic

class Subscription(BaseModel):
    name: str
    length: str  # e.g., "1 month", "1 year"
    price: float

class User(BaseModel):
    user_id: str = Field(default_factory=default_uuid)
    name: str
    email: EmailStr
    hashed_password: str # Store hashed passwords, not plain text
    gender: Optional[str] = None
    age: Optional[int] = None
    fitness_goals: Optional[List[str]] = Field(default_factory=list)
    two_fa_key: Optional[str] = None # Secret key for TOTP
    is_2fa_enabled: bool = False
    tracked_activities: List[ActivityLog] = Field(default_factory=list)
    favourites: List[str] = Field(default_factory=list)  # List of gym_ids
    achievements: List[str] = Field(default_factory=list) # List of achievement names or IDs
    notification_setting: bool = True
    bookings: List[str] = Field(default_factory=list)  # List of team_ids user is booked into
    # email_verified: bool = False # Could be useful for 2FA/reset flows
    # last_login: Optional[datetime] = None

class Gym(BaseModel):
    gym_id: str = Field(default_factory=default_uuid)
    name: str
    location: str  # Text description of location
    location_url: Optional[HttpUrl] = None # e.g., Google Maps URL
    token_per_visit: Optional[float] = None
    genders_accepted: Optional[List[str]] = Field(default_factory=list) # e.g., ["Male", "Female", "Unisex"]
    subscriptions: List[Subscription] = Field(default_factory=list)
    services: List[str] = Field(default_factory=list)
    # geo_coordinates: Optional[Tuple[float, float]] = None # (latitude, longitude) for GCloud

class GroupActivityTeam(BaseModel):
    team_id: str = Field(default_factory=default_uuid)
    lister_id: str  # User ID of the creator
    name: str
    description: str
    category: str # e.g., "Yoga", "Running Club", "HIIT"
    location: str # Text description
    date_and_time: datetime
    age_range: Optional[str] = None # e.g., "18-25", "Any"
    contact_information: str
    players_needed: int
    current_players_count: int = 0
    players_enrolled: List[str] = Field(default_factory=list) # List of user_ids
    status: str = "active"  # e.g., "active", "filled", "cancelled"
    photo_base64: Optional[str] = None # Base64 encoded photo data
    # photo_url: Optional[HttpUrl] = None # URL to the photo, if uploaded to a service

# For TinyDB, we might not need explicit "Table" models if we use Pydantic for validation
# and structure within the list of documents each table holds. 
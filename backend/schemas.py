from pydantic import BaseModel, EmailStr, HttpUrl, Field
from typing import List, Optional, Dict, Any
from datetime import datetime, date
from .models import ActivityLog, Subscription # Import base structures from models

# ======== User Schemas ========
class UserCreate(BaseModel):
    name: str
    email: EmailStr
    password: str
    gender: Optional[str] = None
    age: Optional[int] = None

class UserUpdate(BaseModel):
    name: Optional[str] = None
    email: Optional[EmailStr] = None
    gender: Optional[str] = None
    age: Optional[int] = None
    fitness_goals: Optional[List[str]] = None
    # Password update should be a separate endpoint/process

class UserResponse(BaseModel):
    user_id: str
    name: str
    email: EmailStr
    gender: Optional[str] = None
    age: Optional[int] = None
    fitness_goals: Optional[List[str]] = []
    is_2fa_enabled: bool
    tracked_activities: List[ActivityLog] = []
    favourites: List[str] = [] # List of gym_ids
    achievements: List[str] = []
    notification_setting: bool
    bookings: List[str] = [] # List of team_ids

    class Config:
        from_attributes = True # for Pydantic V2, or orm_mode = True for V1

class UserProfileEdit(BaseModel):
    name: Optional[str] = None
    gender: Optional[str] = None
    age: Optional[int] = None
    fitness_goals: Optional[List[str]] = None

# ======== Token Schemas ========
class Token(BaseModel):
    access_token: str
    token_type: str

class TokenData(BaseModel):
    email: Optional[str] = None

class TwoFALoginRequest(BaseModel):
    email: EmailStr
    password: str

class TwoFALoginResponse(BaseModel):
    message: str # e.g., "2FA required, email sent"
    # Optionally, a temporary token if needed before 2FA verification

class EmailSchema(BaseModel):
    email: EmailStr

# ======== Gym Schemas ========
class GymCreate(BaseModel):
    name: str
    location: str
    location_url: Optional[HttpUrl] = None
    token_per_visit: Optional[float] = None
    genders_accepted: Optional[List[str]] = []
    subscriptions: Optional[List[Subscription]] = []
    services: Optional[List[str]] = []

class GymResponse(GymCreate):
    gym_id: str

    class Config:
        from_attributes = True

class GymNearbyResponse(GymResponse):
    distance: Optional[float] = None # in km or miles
    # Any other GCloud specific info if needed

# ======== Group Activity Team Schemas ========
class GroupActivityTeamCreate(BaseModel):
    name: str
    description: str
    category: str
    location: str
    date_and_time: datetime
    age_range: Optional[str] = None
    contact_information: str
    players_needed: int
    # photo: str # Will be handled as UploadFile in endpoint, then converted to URL or stored
    # lister_id will be taken from current authenticated user
    # status will be set to 'active' by default

class GroupActivityTeamUpdate(BaseModel):
    name: Optional[str] = None
    description: Optional[str] = None
    category: Optional[str] = None
    location: Optional[str] = None
    date_and_time: Optional[datetime] = None
    age_range: Optional[str] = None
    contact_information: Optional[str] = None
    players_needed: Optional[int] = None
    status: Optional[str] = None # e.g., "active", "filled", "cancelled"
    # photo_url: Optional[HttpUrl] = None

class GroupActivityTeamResponse(GroupActivityTeamCreate):
    team_id: str
    lister_id: str
    current_players_count: int
    players_enrolled: List[str] = []
    status: str
    photo_url: Optional[HttpUrl] = None

    class Config:
        from_attributes = True

# ======== Activity Tracking Schemas ========
class ActivityTrackingResponse(BaseModel):
    # Based on user: "running, steps, gym time, score which is calculated from the 3"
    # This could be a summary or a list of recent activities.
    # Let's assume it's a summary for a specific period or overall.
    running_total_km: float = 0.0
    steps_total: int = 0
    gym_time_total_minutes: int = 0
    calculated_score: float = 0.0 # Logic for this score needs to be defined
    # Or it could be a direct reflection of user.tracked_activities:
    # detailed_logs: List[ActivityLog] = []

# ======== Booking Schemas ========
class BookingCreateResponse(BaseModel):
    user_id: str
    team_id: str
    booking_time: datetime
    status: str = "confirmed"

class BookingResponse(BaseModel):
    team_id: str
    team_name: str # Denormalized for convenience
    activity_date_time: datetime
    location: str
    # Add other relevant fields from GroupActivityTeam

class AchievementResponse(BaseModel):
    name: str
    description: Optional[str] = None
    achieved_on: Optional[date] = None

# ======== General Schemas ========
class MessageResponse(BaseModel):
    message: str 
from pydantic import BaseModel, EmailStr, HttpUrl, Field
from typing import List, Optional
from datetime import datetime, date
import uuid
from sqlalchemy import Boolean, Column, Integer, String, Enum as SQLAlchemyEnum, ForeignKey
from sqlalchemy.orm import relationship
from .database import Base
import enum

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

class UserRole(enum.Enum):
    ADMIN = "admin"
    USER = "user"
    GUEST = "guest"

class User(Base):
    __tablename__ = "users"

    user_id = Column(Integer, primary_key=True, index=True)
    username = Column(String, unique=True, index=True)
    email = Column(String, unique=True, index=True)
    hashed_password = Column(String)
    is_active = Column(Boolean, default=True)
    role = Column(SQLAlchemyEnum(UserRole), default=UserRole.USER)
    
    is_2fa_enabled = Column(Boolean, default=False)
    two_fa_key = Column(String, nullable=True) # Holds the secret key for TOTP
    
    # User's profile information
    full_name = Column(String, nullable=True)
    gender = Column(String, nullable=True)
    date_of_birth = Column(String, nullable=True)
    phone_number = Column(String, nullable=True)
    profile_picture_url = Column(String, nullable=True)
    
    # Personalization
    fitness_goal = Column(String, nullable=True)
    
    # App-specific settings
    notification_setting = Column(Boolean, default=True)
    
    teams = relationship("Team", back_populates="owner")

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

class Team(Base):
    __tablename__ = "teams"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, index=True)
    sport = Column(String)
    description = Column(String)
    location = Column(String)
    date_time = Column(String)
    age_range = Column(String)
    contact_info = Column(String)
    players_needed = Column(String)
    image_url = Column(String, nullable=True)
    
    owner_id = Column(Integer, ForeignKey("users.user_id"))
    owner = relationship("User", back_populates="teams")

class FavoriteFacility(Base):
    __tablename__ = "favorite_facilities"
    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.user_id"))
    gym_id = Column(String)

    user = relationship("User")

# For TinyDB, we might not need explicit "Table" models if we use Pydantic for validation
# and structure within the list of documents each table holds. 
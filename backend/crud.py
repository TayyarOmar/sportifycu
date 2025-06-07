from typing import List, Optional, Dict, Any
from tinydb import Query
from .database import UserTable, GymTable, GroupActivityTeamTable
from .models import User, Gym, GroupActivityTeam, ActivityLog
from .schemas import UserCreate # For type hinting where appropriate
from .auth import get_password_hash, generate_2fa_secret_key as generate_totp_secret_key # Updated import
from datetime import datetime, date
import uuid

# ===== User CRUD Operations =====
def create_user_db(user_data: UserCreate) -> User:
    # Check if user already exists by email
    if UserTable.get(Query().email == user_data.email):
        return None # Or raise an exception: HTTPException(status_code=400, detail="Email already registered")
    
    hashed_password = get_password_hash(user_data.password)
    user_id = str(uuid.uuid4())
    two_fa_secret = generate_totp_secret_key() # Generate 2FA secret
    
    # Initialize other fields as per User model defaults where applicable
    new_user = User(
        user_id=user_id,
        name=user_data.name,
        email=user_data.email,
        hashed_password=hashed_password,
        gender=user_data.gender,
        age=user_data.age,
        fitness_goals=user_data.fitness_goals if user_data.fitness_goals else [],
        two_fa_key=two_fa_secret, # Store the generated 2FA key
        is_2fa_enabled=False, # Initially disabled, user can enable it later
        # Default empty lists/values are handled by Pydantic model itself
        # two_fa_key will be set during 2FA setup if user opts-in
    )
    UserTable.insert(new_user.model_dump())
    return new_user

def get_user_by_email(email: str) -> Optional[User]:
    user_doc = UserTable.get(Query().email == email)
    if user_doc:
        # Convert ISO date strings back to date objects for tracked_activities
        if 'tracked_activities' in user_doc:
            for activity in user_doc['tracked_activities']:
                if isinstance(activity.get('date'), str):
                    try:
                        activity['date'] = date.fromisoformat(activity['date'])
                    except ValueError:
                        # Handle cases where date might not be in ISO format or is invalid
                        activity['date'] = None # Or some default/error handling
        return User(**user_doc)
    return None

def get_user_by_id(user_id: str) -> Optional[User]:
    user_doc = UserTable.get(Query().user_id == user_id)
    if user_doc:
        # Convert ISO date strings back to date objects for tracked_activities
        if 'tracked_activities' in user_doc:
            for activity in user_doc['tracked_activities']:
                if isinstance(activity.get('date'), str):
                    try:
                        activity['date'] = date.fromisoformat(activity['date'])
                    except ValueError:
                        activity['date'] = None 
        return User(**user_doc)
    return None

def update_user_db(user_id: str, user_update_data: Dict[str, Any]) -> Optional[User]:
    # Filter out None values from update_data to avoid overwriting with None
    update_data_cleaned = {k: v for k, v in user_update_data.items() if v is not None}
    if not update_data_cleaned:
        # If nothing to update after cleaning, fetch and return current user
        return get_user_by_id(user_id)
        
    updated_ids = UserTable.update(update_data_cleaned, Query().user_id == user_id)
    if len(updated_ids) > 0:
        return get_user_by_id(user_id)
    return None

def add_activity_log_db(user_id: str, activity_log: ActivityLog) -> Optional[User]:
    user = get_user_by_id(user_id)
    if not user:
        return None
    user.tracked_activities.append(activity_log)
    UserTable.update({'tracked_activities': [act.model_dump() for act in user.tracked_activities]}, Query().user_id == user_id)
    return user

def update_daily_activity_log_db(user_id: str, activity_type: str, activity_date: date, value: float, unit: str) -> Optional[User]:
    """Update or create activity log for specific activity type on specific date."""
    user = get_user_by_id(user_id)
    if not user:
        return None
    
    # Find existing activity log for this date and activity type
    existing_index = None
    for i, activity in enumerate(user.tracked_activities):
        if activity.date == activity_date and activity.activity_type == activity_type:
            existing_index = i
            break
    
    # Create new activity log
    new_activity = ActivityLog(
        date=activity_date,
        activity_type=activity_type,
        value=value,
        unit=unit
    )
    
    # Replace existing or append new
    if existing_index is not None:
        user.tracked_activities[existing_index] = new_activity
    else:
        user.tracked_activities.append(new_activity)
    
    # Update database
    UserTable.update({'tracked_activities': [act.model_dump() for act in user.tracked_activities]}, Query().user_id == user_id)
    return user

def update_password_db(user_id: str, new_hashed_password: str) -> Optional[User]:
    updated_ids = UserTable.update({'hashed_password': new_hashed_password}, Query().user_id == user_id)
    if len(updated_ids) > 0:
        return get_user_by_id(user_id)
    return None

def set_2fa_details_db(user_id: str, secret_key: Optional[str], is_enabled: bool) -> Optional[User]:
    update_data = {'is_2fa_enabled': is_enabled}
    if secret_key is not None: # Allow setting a new key or clearing it if None explicitly for disabling
        update_data['two_fa_key'] = secret_key
    
    updated_ids = UserTable.update(update_data, Query().user_id == user_id)
    if len(updated_ids) > 0:
        return get_user_by_id(user_id)
    return None

def add_favourite_gym_db(user_id: str, gym_id: str) -> Optional[User]:
    user = get_user_by_id(user_id)
    if not user:
        return None
    if gym_id not in user.favourites:
        user.favourites.append(gym_id)
        UserTable.update({'favourites': user.favourites}, Query().user_id == user_id)
    return user # Return user whether gym was added or already existed

def remove_favourite_gym_db(user_id: str, gym_id: str) -> Optional[User]:
    user = get_user_by_id(user_id)
    if not user:
        return None
    if gym_id in user.favourites:
        user.favourites.remove(gym_id)
        UserTable.update({'favourites': user.favourites}, Query().user_id == user_id)
    return user # Return user whether gym was removed or not found

def update_notification_setting_db(user_id: str, enabled: bool) -> Optional[User]:
    updated_ids = UserTable.update({'notification_setting': enabled}, Query().user_id == user_id)
    if len(updated_ids) > 0:
        return get_user_by_id(user_id)
    return None

# ===== Gym CRUD Operations =====
def create_gym_db(gym_data: Gym) -> Gym:
    # gym_id is auto-generated by model default factory
    if GymTable.get(Query().name == gym_data.name): # Basic check, might need more robust duplicate checks
        return None # Or raise exception
    GymTable.insert(gym_data.model_dump())
    return gym_data

def get_gym_by_id(gym_id: str) -> Optional[Gym]:
    gym_doc = GymTable.get(Query().gym_id == gym_id)
    if gym_doc:
        return Gym(**gym_doc)
    return None

def get_all_gyms_db() -> List[Gym]:
    return [Gym(**gym_doc) for gym_doc in GymTable.all()]

# Update Gym (example)
def update_gym_db(gym_id: str, gym_update_data: Dict[str, Any]) -> Optional[Gym]:
    update_data_cleaned = {k: v for k, v in gym_update_data.items() if v is not None}
    if not update_data_cleaned:
        return get_gym_by_id(gym_id)

    updated_ids = GymTable.update(update_data_cleaned, Query().gym_id == gym_id)
    if len(updated_ids) > 0:
        return get_gym_by_id(gym_id)
    return None

# ===== Group Activity Team CRUD Operations =====
def create_group_activity_team_db(team_data: GroupActivityTeam) -> GroupActivityTeam:
    # team_id is auto-generated by model default factory
    GroupActivityTeamTable.insert(team_data.model_dump())
    return team_data

def get_group_activity_team_by_id(team_id: str) -> Optional[GroupActivityTeam]:
    team_doc = GroupActivityTeamTable.get(Query().team_id == team_id)
    if team_doc:
        # Convert ISO datetime string back to datetime object
        if isinstance(team_doc.get('date_and_time'), str):
            try:
                team_doc['date_and_time'] = datetime.fromisoformat(team_doc['date_and_time'])
            except ValueError:
                team_doc['date_and_time'] = None # Or handle error
        return GroupActivityTeam(**team_doc)
    return None

def get_active_group_activity_teams_db() -> List[GroupActivityTeam]:
    teams = []
    for team_doc in GroupActivityTeamTable.search(Query().status == 'active'):
        if isinstance(team_doc.get('date_and_time'), str):
            try:
                team_doc['date_and_time'] = datetime.fromisoformat(team_doc['date_and_time'])
            except ValueError:
                team_doc['date_and_time'] = None # Skip or handle error
                continue # Skip if date is invalid for an active team context
        teams.append(GroupActivityTeam(**team_doc))
    return teams

def get_all_group_activity_teams_db() -> List[GroupActivityTeam]:
    teams = []
    for team_doc in GroupActivityTeamTable.all():
        if isinstance(team_doc.get('date_and_time'), str):
            try:
                team_doc['date_and_time'] = datetime.fromisoformat(team_doc['date_and_time'])
            except ValueError:
                team_doc['date_and_time'] = None
        teams.append(GroupActivityTeam(**team_doc))
    return teams

def update_group_activity_team_db(team_id: str, team_update_data: Dict[str, Any]) -> Optional[GroupActivityTeam]:
    update_data_cleaned = {k: v for k, v in team_update_data.items() if v is not None}
    if not update_data_cleaned:
        return get_group_activity_team_by_id(team_id)

    updated_ids = GroupActivityTeamTable.update(update_data_cleaned, Query().team_id == team_id)
    if len(updated_ids) > 0:
        return get_group_activity_team_by_id(team_id)
    return None

def delete_group_activity_team_db(team_id: str, lister_id: str) -> bool:
    team = get_group_activity_team_by_id(team_id)
    if not team or team.lister_id != lister_id:
        return False # Or raise Forbidden/Not Found
    
    deleted_ids = GroupActivityTeamTable.remove(Query().team_id == team_id)
    return len(deleted_ids) > 0

# Booking related CRUD (simplified, might need its own table or more complex logic)
# For now, bookings are lists of team_ids in User and lists of user_ids in GroupActivityTeam

def add_booking_to_user_and_team(user_id: str, team_id: str) -> bool:
    user = get_user_by_id(user_id)
    team = get_group_activity_team_by_id(team_id)

    if not user or not team:
        return False # User or Team not found

    if team.status != "active" or team.current_players_count >= team.players_needed:
        return False # Team not available for booking

    if team_id in user.bookings or user_id in team.players_enrolled:
        return False # Already booked

    # Update User
    user.bookings.append(team_id)
    UserTable.update({'bookings': user.bookings}, Query().user_id == user_id)

    # Update Team
    team.players_enrolled.append(user_id)
    team.current_players_count += 1
    if team.current_players_count >= team.players_needed:
        team.status = "filled"
    
    GroupActivityTeamTable.update(
        {
            'players_enrolled': team.players_enrolled, 
            'current_players_count': team.current_players_count,
            'status': team.status
        },
        Query().team_id == team_id
    )
    return True

def get_user_bookings_details(user_id: str) -> List[GroupActivityTeam]:
    user = get_user_by_id(user_id)
    if not user:
        return []
    booked_teams = []
    for team_id in user.bookings:
        team = get_group_activity_team_by_id(team_id)
        if team:
            booked_teams.append(team)
    return booked_teams


def get_top_users_by_score(limit: int = 10) -> List[Dict[str, Any]]:
    """
    Retrieves users and calculates their scores to find top users.
    Requires calculate_activity_score from utils.
    NOTE: This can be inefficient for large datasets as it loads all users.
    Consider denormalizing scores or using a more advanced query system if performance is critical.
    """
    from .utils import calculate_activity_score # Local import to avoid circular dependency issues at module load
    
    all_users_docs = UserTable.all()
    users_with_scores = []
    for user_doc in all_users_docs:
        # Robust User object creation with date handling
        if 'tracked_activities' in user_doc:
            for activity in user_doc['tracked_activities']:
                if isinstance(activity.get('date'), str):
                    try:
                        activity['date'] = date.fromisoformat(activity['date'])
                    except ValueError:
                        activity['date'] = None 
        
        user = User(**user_doc)
        score = calculate_activity_score(user.tracked_activities)
        users_with_scores.append({"user_id": user.user_id, "name": user.name, "email": user.email, "score": score})
    
    # Sort by score descending
    sorted_users = sorted(users_with_scores, key=lambda x: x["score"], reverse=True)
    return sorted_users[:limit]

def get_user_achievements_db(user_id: str) -> Optional[List[str]]:
    user = get_user_by_id(user_id)
    if user:
        return user.achievements
    return None

# --- Team CRUD Operations ---

def get_team(db: Session, team_id: int):
    """Fetches a single team by its ID."""
    return db.query(models.Team).filter(models.Team.id == team_id).first()

def get_teams_by_user(db: Session, user_id: int, skip: int = 0, limit: int = 100):
    """Fetches all teams created by a specific user."""
    return db.query(models.Team).filter(models.Team.owner_id == user_id).offset(skip).limit(limit).all()

def get_all_teams(db: Session, skip: int = 0, limit: int = 100):
    """Fetches all teams from the database."""
    return db.query(models.Team).offset(skip).limit(limit).all()

def create_team(db: Session, team: schemas.TeamCreate, user_id: int):
    """Creates a new team in the database."""
    db_team = models.Team(**team.model_dump(), owner_id=user_id)
    db.add(db_team)
    db.commit()
    db.refresh(db_team)
    return db_team

def update_team(db: Session, team_id: int, team_update: schemas.TeamUpdate):
    """Updates an existing team's information."""
    db_team = get_team(db, team_id)
    if db_team:
        update_data = team_update.model_dump(exclude_unset=True)
        for key, value in update_data.items():
            setattr(db_team, key, value)
        db.commit()
        db.refresh(db_team)
    return db_team

def delete_team(db: Session, team_id: int):
    """Deletes a team from the database."""
    db_team = get_team(db, team_id)
    if db_team:
        db.delete(db_team)
        db.commit()
    return db_team 
from fastapi import APIRouter, Depends, HTTPException, status
from typing import List
from pydantic import BaseModel # Added for NotificationSettingsPayload

from .. import crud, schemas, models # auth might be needed for password change if part of profile
from ..dependencies import get_current_active_user
from ..utils import calculate_activity_score # For activity tracking response

router = APIRouter(
    prefix="/api/v1/users",
    tags=["Users"],
    dependencies=[Depends(get_current_active_user)] # Protect all routes in this router
)

# --- User Profile Endpoints ---
@router.get("/me", response_model=schemas.UserResponse)
async def read_users_me(current_user: models.User = Depends(get_current_active_user)):
    """Get current logged-in user's profile."""
    return current_user

@router.put("/me/profile", response_model=schemas.UserResponse)
async def update_user_profile(
    profile_data: schemas.UserProfileEdit,
    current_user: models.User = Depends(get_current_active_user)
):
    """Update current user's profile (name, gender, age, fitness_goals)."""
    update_data = profile_data.model_dump(exclude_unset=True)
    if not update_data:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="No data provided for update.")
    
    updated_user = crud.update_user_db(user_id=current_user.user_id, user_update_data=update_data)
    if not updated_user:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="User not found or update failed.")
    return updated_user

# --- Activity Tracking --- 
@router.get("/me/activity-tracking", response_model=schemas.ActivityTrackingResponse)
async def get_activity_tracking(current_user: models.User = Depends(get_current_active_user)):
    """Get aggregated activity tracking data for the current user."""
    # This will aggregate from current_user.tracked_activities
    running_total_km = sum(act.value for act in current_user.tracked_activities if act.activity_type == "running" and act.unit == "km")
    steps_total = sum(int(act.value) for act in current_user.tracked_activities if act.activity_type == "steps" and act.unit == "steps")
    gym_time_total_minutes = sum(int(act.value) for act in current_user.tracked_activities if act.activity_type == "gym_time" and act.unit == "minutes")
    
    calculated_score = calculate_activity_score(current_user.tracked_activities)
    
    return schemas.ActivityTrackingResponse(
        running_total_km=running_total_km,
        steps_total=steps_total,
        gym_time_total_minutes=gym_time_total_minutes,
        calculated_score=calculated_score
        # detailed_logs=current_user.tracked_activities # Optionally include raw logs
    )

@router.post("/me/activity-log", response_model=models.ActivityLog)
async def add_activity_log_for_user(
    activity_log: models.ActivityLog, # Use the model directly as it defines structure
    current_user: models.User = Depends(get_current_active_user)
):
    """Add a new activity log for the current user."""
    # Ensure date is set if not provided, or use today. Pydantic model requires it.
    # activity_log.date is already required by the model.

    updated_user = crud.add_activity_log_db(user_id=current_user.user_id, activity_log=activity_log)
    if not updated_user:
        raise HTTPException(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, detail="Could not add activity log.")
    # Return the last added activity log, which is the one just passed
    return activity_log 

@router.post("/me/activity-log/running", response_model=schemas.ActivityLogResponse)
async def log_running_activity(
    running_data: schemas.RunningLogRequest,
    current_user: models.User = Depends(get_current_active_user)
):
    """Log or update running activity for a specific date."""
    updated_user = crud.update_daily_activity_log_db(
        user_id=current_user.user_id,
        activity_type="running",
        activity_date=running_data.date,
        value=running_data.value,
        unit="km"
    )
    if not updated_user:
        raise HTTPException(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, detail="Could not log running activity.")
    
    return schemas.ActivityLogResponse(
        date=running_data.date,
        activity_type="running",
        value=running_data.value,
        unit="km"
    )

@router.post("/me/activity-log/steps", response_model=schemas.ActivityLogResponse)
async def log_steps_activity(
    steps_data: schemas.StepsLogRequest,
    current_user: models.User = Depends(get_current_active_user)
):
    """Log or update steps activity for a specific date."""
    updated_user = crud.update_daily_activity_log_db(
        user_id=current_user.user_id,
        activity_type="steps",
        activity_date=steps_data.date,
        value=float(steps_data.value),
        unit="steps"
    )
    if not updated_user:
        raise HTTPException(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, detail="Could not log steps activity.")
    
    return schemas.ActivityLogResponse(
        date=steps_data.date,
        activity_type="steps",
        value=float(steps_data.value),
        unit="steps"
    )

@router.post("/me/activity-log/gym-time", response_model=schemas.ActivityLogResponse)
async def log_gym_time_activity(
    gym_time_data: schemas.GymTimeLogRequest,
    current_user: models.User = Depends(get_current_active_user)
):
    """Log or update gym time activity for a specific date."""
    updated_user = crud.update_daily_activity_log_db(
        user_id=current_user.user_id,
        activity_type="gym_time",
        activity_date=gym_time_data.date,
        value=float(gym_time_data.value),
        unit="minutes"
    )
    if not updated_user:
        raise HTTPException(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, detail="Could not log gym time activity.")
    
    return schemas.ActivityLogResponse(
        date=gym_time_data.date,
        activity_type="gym_time",
        value=float(gym_time_data.value),
        unit="minutes"
    )

# --- Favourites --- 
@router.post("/me/favourites/{gym_id}", response_model=schemas.UserResponse)
async def set_favourite_gym(
    gym_id: str,
    current_user: models.User = Depends(get_current_active_user)
):
    """Add a gym to the current user's favourites list."""
    # Check if gym exists (optional, but good practice)
    gym = crud.get_gym_by_id(gym_id)
    if not gym:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail=f"Gym with id {gym_id} not found.")

    if gym_id not in current_user.favourites:
        current_user.favourites.append(gym_id)
        updated_user = crud.update_user_db(user_id=current_user.user_id, user_update_data={"favourites": current_user.favourites})
        if not updated_user:
            raise HTTPException(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, detail="Could not update favourites.")
        return updated_user
    return current_user # Already a favourite

@router.delete("/me/favourites/{gym_id}", response_model=schemas.UserResponse)
async def remove_favourite_gym(
    gym_id: str,
    current_user: models.User = Depends(get_current_active_user)
):
    """Remove a gym from the current user's favourites list."""
    if gym_id in current_user.favourites:
        current_user.favourites.remove(gym_id)
        updated_user = crud.update_user_db(user_id=current_user.user_id, user_update_data={"favourites": current_user.favourites})
        if not updated_user:
            raise HTTPException(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, detail="Could not update favourites.")
        return updated_user
    # If gym_id not in favourites, no action needed or raise 404
    raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail=f"Gym with id {gym_id} not in favourites.")

# --- Notification Settings --- 
class NotificationSettingsPayload(BaseModel):
    enabled: bool

@router.put("/me/notification-settings", response_model=schemas.UserResponse)
async def set_notification_settings(
    payload: NotificationSettingsPayload,
    current_user: models.User = Depends(get_current_active_user)
):
    """Set the notification preference for the current user."""
    updated_user = crud.update_user_db(user_id=current_user.user_id, user_update_data={"notification_setting": payload.enabled})
    if not updated_user:
        raise HTTPException(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, detail="Could not update notification settings.")
    return updated_user

# --- Bookings --- 
@router.get("/me/bookings", response_model=List[schemas.BookingResponse])
async def get_user_bookings(current_user: models.User = Depends(get_current_active_user)):
    """Get a list of group activity teams the current user is booked into."""
    booked_teams_models = crud.get_user_bookings_details(user_id=current_user.user_id)
    # Convert GroupActivityTeam models to BookingResponse schemas
    response_bookings = []
    for team in booked_teams_models:
        response_bookings.append(schemas.BookingResponse(
            team_id=team.team_id,
            team_name=team.name,
            activity_date_time=team.date_and_time,
            location=team.location
            # Add other relevant fields from GroupActivityTeam if needed in BookingResponse
        ))
    return response_bookings

# --- Achievements --- 
@router.get("/me/achievements", response_model=List[schemas.AchievementResponse]) # Assuming AchievementResponse might be richer later
async def get_user_achievements(current_user: models.User = Depends(get_current_active_user)):
    """Get a list of achievements for the current user."""
    # The user.achievements is a List[str] (achievement names or IDs)
    # For now, wrap them in a basic AchievementResponse structure.
    # This could be expanded if achievements have more details stored elsewhere.
    achievements_list = [] 
    raw_achievements = crud.get_user_achievements_db(user_id=current_user.user_id)
    if raw_achievements:
        for achievement_name in raw_achievements:
            achievements_list.append(schemas.AchievementResponse(name=achievement_name))
    return achievements_list 
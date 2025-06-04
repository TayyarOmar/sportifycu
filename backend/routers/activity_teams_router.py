from fastapi import APIRouter, Depends, HTTPException, status, UploadFile, File, Form
from typing import List, Optional
import shutil
import uuid
import os

from .. import crud, schemas, models
from ..dependencies import get_current_active_user

router = APIRouter(
    prefix="/api/v1/activity-teams",
    tags=["Group Activity Teams"],
    dependencies=[Depends(get_current_active_user)] # Most routes here require auth
)

# Define the upload directory path
UPLOAD_DIR = "backend/static/uploads/team_photos"
# Ensure the UPLOAD_DIR exists (though we created it via terminal, good to have here too)
# os.makedirs(UPLOAD_DIR, exist_ok=True) # This would be an issue if backend/static doesn't exist first

# Helper for photo: Saves photo to local static dir and returns relative URL.
async def save_team_photo(photo: UploadFile) -> Optional[str]:
    if photo and photo.filename:
        # Create a unique filename to prevent collisions and handle non-standard filenames
        _, extension = os.path.splitext(photo.filename)
        unique_filename = f"{uuid.uuid4()}{extension}"
        file_path = os.path.join(UPLOAD_DIR, unique_filename)
        
        try:
            with open(file_path, "wb") as buffer:
                shutil.copyfileobj(photo.file, buffer)
            # Return a relative URL that can be served by StaticFiles
            return f"/static/uploads/team_photos/{unique_filename}"
        except Exception as e:
            print(f"Error saving photo: {e}")
            # Optionally raise an HTTPException or handle error appropriately
            return None
        finally:
            photo.file.close() # Ensure the file is closed
    return None

@router.post("/", response_model=schemas.GroupActivityTeamResponse, status_code=status.HTTP_201_CREATED)
async def create_activity_team(
    name: str = Form(...),
    description: str = Form(...),
    category: str = Form(...),
    location: str = Form(...),
    date_and_time: str = Form(...), # Will be parsed to datetime by Pydantic in schema
    players_needed: int = Form(...),
    age_range: Optional[str] = Form(None),
    contact_information: str = Form(...),
    photo: Optional[UploadFile] = File(None),
    current_user: models.User = Depends(get_current_active_user)
):
    """Create a new group activity team. Photo is optional."""
    
    # Convert date_and_time string to datetime. Pydantic does this if schema field is datetime.
    # For GroupActivityTeamCreate schema, date_and_time is datetime.
    # Here, we are taking individual Form fields then constructing the schema.
    try:
        team_create_data = schemas.GroupActivityTeamCreate(
            name=name, 
            description=description, 
            category=category, 
            location=location,
            date_and_time=date_and_time, # Pydantic will parse ISO string to datetime
            players_needed=players_needed,
            age_range=age_range,
            contact_information=contact_information
        )
    except Exception as e: # Catch Pydantic validation error for date_and_time etc.
        raise HTTPException(status_code=status.HTTP_422_UNPROCESSABLE_ENTITY, detail=f"Invalid form data: {e}")

    photo_url_str = None
    if photo:
        photo_url_str = await save_team_photo(photo)
        if not photo_url_str: # Handle save failure
            print("Warning: Photo upload was provided but failed to save.")
            # Decide if this should be a critical error or just a warning

    team_model_data = models.GroupActivityTeam(
        **team_create_data.model_dump(),
        lister_id=current_user.user_id,
        status="active", # Default status
        current_players_count=0,
        players_enrolled=[],
        photo_url=photo_url_str
    )
    
    created_team = crud.create_group_activity_team_db(team_data=team_model_data)
    if not created_team:
        raise HTTPException(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, detail="Could not create activity team.")
    return created_team

@router.put("/{team_id}", response_model=schemas.GroupActivityTeamResponse)
async def edit_activity_team(
    team_id: str,
    team_update_data: schemas.GroupActivityTeamUpdate,
    current_user: models.User = Depends(get_current_active_user)
):
    """Edit an existing group activity team. Only the lister can edit."""
    team = crud.get_group_activity_team_by_id(team_id)
    if not team:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Activity team not found.")
    if team.lister_id != current_user.user_id:
        raise HTTPException(status_code=status.HTTP_403_FORBIDDEN, detail="Not authorized to edit this activity team.")

    update_data_dict = team_update_data.model_dump(exclude_unset=True)
    if not update_data_dict:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="No update data provided.")

    updated_team = crud.update_group_activity_team_db(team_id=team_id, team_update_data=update_data_dict)
    if not updated_team:
        raise HTTPException(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, detail="Could not update activity team.")
    return updated_team

@router.delete("/{team_id}", status_code=status.HTTP_204_NO_CONTENT)
async def delete_activity_team(
    team_id: str,
    current_user: models.User = Depends(get_current_active_user)
):
    """Delete an activity team. Only the lister can delete."""
    team = crud.get_group_activity_team_by_id(team_id)
    if not team: # To ensure idempotency, or check if team exists before calling delete_db
        # If delete_group_activity_team_db returns False for not found, this check is good.
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Activity team not found.")

    # crud.delete_group_activity_team_db already checks lister_id
    if not crud.delete_group_activity_team_db(team_id=team_id, lister_id=current_user.user_id):
        # This could be due to not found (already handled) or not authorized
        # crud.delete_group_activity_team_db should ideally distinguish or we assume if found, it was auth problem
        if team.lister_id != current_user.user_id: # Re-check for specific error message
            raise HTTPException(status_code=status.HTTP_403_FORBIDDEN, detail="Not authorized to delete this team.")
        # If it reached here and failed, could be a general DB error or already deleted by another request.
        # For simplicity, if not deleted and was found and was lister, then some other error.
        # However, delete_group_activity_team_db handles this logic. So if it fails, it means not lister or not found.
        # The initial check for team existence and the lister_id check within delete_group_activity_team_db covers these.
        # So if it returns False, it means it didn't delete, likely due to auth or it was already gone.
        # Re-fetch to confirm for better error, or trust the crud layer.
        # The crud function returns False if not team OR team.lister_id != lister_id
        # So the 404 above handles if team not found first.
        # If found, and still fails, it means lister_id was wrong.
        raise HTTPException(status_code=status.HTTP_403_FORBIDDEN, detail="Not authorized to delete this team or team not found.")
    return # FastAPI handles 204 No Content response automatically

@router.get("/", response_model=List[schemas.GroupActivityTeamResponse])
async def get_all_active_activity_teams(): # No auth needed for listing active teams as per prompt (?)
    """Get a list of all active group activity teams."""
    # If this needs to be protected: current_user: models.User = Depends(get_current_active_user)
    teams = crud.get_active_group_activity_teams_db()
    return teams

@router.post("/{team_id}/bookings", response_model=schemas.MessageResponse) # Or a BookingConfirmation schema
async def add_booking_for_team(
    team_id: str,
    current_user: models.User = Depends(get_current_active_user)
):
    """Enroll the current user into an activity team (create a booking)."""
    team = crud.get_group_activity_team_by_id(team_id)
    if not team:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Activity team not found.")
    
    if team.lister_id == current_user.user_id:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="Lister cannot book their own activity team.")

    if team.status != "active":
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail=f"Team is not active. Current status: {team.status}")
    
    if team.current_players_count >= team.players_needed:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="Team is already full.")
        
    if team_id in current_user.bookings:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="User already booked for this team.")

    success = crud.add_booking_to_user_and_team(user_id=current_user.user_id, team_id=team_id)
    if not success:
        # This could be due to race conditions or other issues not caught by above checks
        # Re-fetch team to give more specific error if possible
        # For now, a generic error if add_booking_to_user_and_team fails for unexpected reason.
        refetched_team = crud.get_group_activity_team_by_id(team_id)
        if not refetched_team or refetched_team.status != "active" or refetched_team.current_players_count >= refetched_team.players_needed:
             raise HTTPException(status_code=status.HTTP_409_CONFLICT, detail="Team status changed or filled before booking completed.")
        raise HTTPException(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, detail="Could not create booking.")
    
    return schemas.MessageResponse(message=f"Successfully booked for team: {team.name}") 
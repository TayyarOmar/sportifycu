from fastapi import APIRouter, Depends, HTTPException, status, Query
from typing import List, Dict, Any

from .. import crud, schemas, models # models might not be directly needed here
from ..dependencies import get_current_active_user # To protect if needed, or for context

router = APIRouter(
    prefix="/api/v1/leaderboards",
    tags=["Leaderboards"],
    # dependencies=[Depends(get_current_active_user)] # Leaderboards are often public
)

# Define a response schema for leaderboard entries if not already in global schemas
# schemas.py does not have a direct leaderboard user schema, 
# crud.get_top_users_by_score returns List[Dict[str, Any]] with user_id, name, email, score
class LeaderboardUser(schemas.BaseModel): # Use schemas.BaseModel if available or pydantic.BaseModel
    user_id: str
    name: str
    email: schemas.EmailStr # Assuming EmailStr is available via schemas
    score: float

    class Config:
        from_attributes = True # If data comes from ORM-like objects (not directly here)

@router.get("/top-scores", response_model=List[LeaderboardUser])
async def get_top_users_by_score(
    limit: int = Query(10, gt=0, le=100, description="Number of top users to retrieve")
    # current_user: models.User = Depends(get_current_active_user) # If access needs auth
):
    """Retrieve the top users based on their calculated activity score."""
    
    # crud.get_top_users_by_score already exists and returns a list of dicts
    # with keys: "user_id", "name", "email", "score"
    top_users_data = crud.get_top_users_by_score(limit=limit)
    
    # Convert list of dicts to list of LeaderboardUser Pydantic models for response validation
    # This ensures the response adheres to the defined schema.
    leaderboard_entries = []
    for user_data in top_users_data:
        try:
            leaderboard_entries.append(LeaderboardUser(**user_data))
        except Exception as e: # Catch Pydantic validation errors if dict structure is unexpected
            # Log this error, as it indicates a mismatch between CRUD output and schema
            print(f"Error parsing leaderboard user data: {user_data}, error: {e}")
            # Optionally, skip this entry or raise a 500 error
            continue 
            
    return leaderboard_entries 
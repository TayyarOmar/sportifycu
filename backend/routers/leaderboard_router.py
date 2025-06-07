from fastapi import APIRouter, Query
from typing import List

from .. import crud, schemas # models might not be directly needed here

router = APIRouter(
    prefix="/api/v1/leaderboards",
    tags=["Leaderboards"],
    # dependencies=[Depends(get_current_active_user)] # Leaderboards are often public
)

# LeaderboardUser model is removed, using schemas.LeaderboardEntry and schemas.LeaderboardResponse instead

@router.get("/top-scores", response_model=schemas.LeaderboardResponse) # Updated response_model
async def get_top_users_by_score_leaderboard(
    limit: int = Query(10, gt=0, le=100, description="Number of top users to retrieve")
    # current_user: models.User = Depends(get_current_active_user) # If access needs auth
):
    """Retrieve the top users based on their calculated activity score."""
    
    top_users_data = crud.get_top_users_by_score(limit=limit)
    
    leaderboard_entries: List[schemas.LeaderboardEntry] = []
    for user_data in top_users_data:
        try:
            # Ensure all fields required by LeaderboardEntry are present in user_data
            # crud.get_top_users_by_score provides user_id, name, score (email is also there but not in LeaderboardEntry)
            entry = schemas.LeaderboardEntry(
                user_id=user_data.get("user_id"), 
                name=user_data.get("name"), 
                score=user_data.get("score")
            )
            leaderboard_entries.append(entry)
        except Exception as e: 
            print(f"Error parsing leaderboard user data: {user_data}, error: {e}")
            continue 
            
    return schemas.LeaderboardResponse(top_users=leaderboard_entries) 
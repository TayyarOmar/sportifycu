from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from typing import List

from .. import crud, schemas, auth
from ..database import get_db

router = APIRouter(
    prefix="/api/v1/teams",
    tags=["Teams"],
    dependencies=[Depends(auth.get_current_active_user)],
)

@router.post("/", response_model=schemas.Team, status_code=status.HTTP_201_CREATED)
def create_team_for_user(
    team: schemas.TeamCreate, 
    db: Session = Depends(get_db), 
    current_user: schemas.User = Depends(auth.get_current_active_user)
):
    """
    Create a new team for the currently authenticated user.
    """
    return crud.create_team(db=db, team=team, user_id=current_user.user_id)

@router.get("/", response_model=List[schemas.Team])
def read_teams(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    """
    Retrieve all teams.
    """
    teams = crud.get_all_teams(db, skip=skip, limit=limit)
    return teams

@router.get("/{team_id}", response_model=schemas.Team)
def read_team(team_id: int, db: Session = Depends(get_db)):
    """
    Retrieve a specific team by its ID.
    """
    db_team = crud.get_team(db, team_id=team_id)
    if db_team is None:
        raise HTTPException(status_code=404, detail="Team not found")
    return db_team

@router.put("/{team_id}", response_model=schemas.Team)
def update_user_team(
    team_id: int, 
    team_update: schemas.TeamUpdate, 
    db: Session = Depends(get_db), 
    current_user: schemas.User = Depends(auth.get_current_active_user)
):
    """
    Update a team that belongs to the current user.
    """
    db_team = crud.get_team(db, team_id=team_id)
    if db_team is None:
        raise HTTPException(status_code=404, detail="Team not found")
    if db_team.owner_id != current_user.user_id:
        raise HTTPException(status_code=403, detail="Not authorized to update this team")
    return crud.update_team(db=db, team_id=team_id, team_update=team_update)

@router.delete("/{team_id}", status_code=status.HTTP_204_NO_CONTENT)
def delete_user_team(
    team_id: int, 
    db: Session = Depends(get_db), 
    current_user: schemas.User = Depends(auth.get_current_active_user)
):
    """
    Delete a team that belongs to the current user.
    """
    db_team = crud.get_team(db, team_id=team_id)
    if db_team is None:
        # Still return a 204 so we don't leak information about which teams exist
        return
    if db_team.owner_id != current_user.user_id:
        raise HTTPException(status_code=403, detail="Not authorized to delete this team")
    
    crud.delete_team(db=db, team_id=team_id)
    return 
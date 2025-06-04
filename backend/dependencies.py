from fastapi import Depends, HTTPException, status
from fastapi.security import OAuth2PasswordBearer
from jose import JWTError, jwt
from pydantic import ValidationError
from . import crud, auth, schemas, models
from .config import settings

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="/api/v1/auth/login") # Adjusted tokenUrl to match potential router prefix

async def get_current_user(token: str = Depends(oauth2_scheme)) -> models.User:
    credentials_exception = HTTPException(
        status_code=status.HTTP_401_UNAUTHORIZED,
        detail="Could not validate credentials",
        headers={"WWW-Authenticate": "Bearer"},
    )
    try:
        payload = jwt.decode(token, settings.SECRET_KEY, algorithms=[settings.ALGORITHM])
        email: str = payload.get("sub")
        if email is None:
            raise credentials_exception
        token_data = schemas.TokenData(email=email)
    except (JWTError, ValidationError):
        raise credentials_exception
    
    user = crud.get_user_by_email(email=token_data.email)
    if user is None:
        raise credentials_exception
    return user

async def get_current_active_user(current_user: models.User = Depends(get_current_user)) -> models.User:
    # if current_user.disabled: # If you add a disabled flag to the user model
    #     raise HTTPException(status_code=400, detail="Inactive user")
    return current_user

# Dependency to verify if a user is the lister of a group activity team (example)
# async def verify_team_lister(team_id: str, current_user: models.User = Depends(get_current_active_user)):
#     team = crud.get_group_activity_team_by_id(team_id)
#     if not team:
#         raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Team not found")
#     if team.lister_id != current_user.user_id:
#         raise HTTPException(status_code=status.HTTP_403_FORBIDDEN, detail="Not authorized to modify this team")
#     return team 
from fastapi import APIRouter, HTTPException, status, Query
from typing import List, Optional

from .. import crud, schemas
from ..services import gcloud_service # For finding nearby gyms

router = APIRouter(
    prefix="/api/v1/gyms",
    tags=["Gyms"],
    # No global dependency here, as /list might be open, /around-you might also be if user loc is passed
    # Individual routes can be protected if necessary.
)

@router.get("/", response_model=List[schemas.GymResponse])
async def get_all_gyms(
    # current_user: models.User = Depends(get_current_active_user) # If this needs to be protected
):
    """Retrieve a list of all gyms and their details."""
    gyms = crud.get_all_gyms_db()
    return gyms

@router.get("/around-you", response_model=List[schemas.GymNearbyResponse])
async def find_gyms_around_you(
    latitude: float = Query(..., description="User's current latitude"),
    longitude: float = Query(..., description="User's current longitude"),
    radius_meters: Optional[int] = Query(5000, description="Search radius in meters")
    # current_user: models.User = Depends(get_current_active_user) # If this needs to be protected
):
    """
    Find gyms near the user's provided latitude and longitude using GCloud (mocked).
    Returns a list of gyms with their details and distance.
    """
    if not (-90 <= latitude <= 90 and -180 <= longitude <= 180):
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Invalid latitude or longitude values."
        )
    
    # The gcloud_service.find_nearby_gyms is a placeholder returning mock data
    # that already matches the GymResponse structure plus distance.
    # The GymNearbyResponse schema expects this format.
    nearby_gym_data_list = await gcloud_service.find_nearby_gyms(
        latitude=latitude, 
        longitude=longitude, 
        radius_meters=radius_meters
    )
    
    # Convert the list of dicts from the service to a list of GymNearbyResponse objects
    # This is important if the service returns raw dicts that need validation/parsing by Pydantic.
    # If find_nearby_gyms already returns objects matching GymNearbyResponse (or parsable dicts), this is simpler.
    
    # The mock service currently returns data structured like GymNearbyResponse.
    # If it returned Gym objects and distance separately, we'd combine them here.
    # For now, assume the structure is compatible.
    
    response_gyms = []
    for gym_data in nearby_gym_data_list:
        # Assuming gym_data is a dict that can initialize GymNearbyResponse
        # This includes fields from GymCreate, gym_id, and distance.
        response_gyms.append(schemas.GymNearbyResponse(**gym_data))
        
    return response_gyms

# Example of a protected route to create a gym (if admins/specific users can add gyms)
# This was not explicitly requested but shows how protection would be added.
# @router.post("/", response_model=schemas.GymResponse, status_code=status.HTTP_201_CREATED)
# async def create_new_gym(
#     gym_create_data: schemas.GymCreate,
#     current_user: models.User = Depends(get_current_active_user) # Protects this route
# ):
#     # Add logic to check if user has permission to create gyms if necessary
#     # if not current_user.is_admin: # Example
#     #     raise HTTPException(status_code=status.HTTP_403_FORBIDDEN, detail="Not authorized to create gyms")
    
#     gym_model = models.Gym(**gym_create_data.model_dump())
#     # gym_id will be auto-generated by the model default factory
    
#     created_gym = crud.create_gym_db(gym_data=gym_model)
#     if created_gym is None:
#         raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="Gym with this name might already exist or invalid data.")
#     return created_gym 
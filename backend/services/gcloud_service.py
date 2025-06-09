from typing import List, Optional
from math import radians, sin, cos, sqrt, atan2
import httpx # Import httpx for asynchronous HTTP requests
from fuzzywuzzy import fuzz # For fuzzy string matching

from ..config import settings # Corrected relative import
from ..schemas import GymNearbyResponse, Subscription # For structuring the output
from .. import crud # Import crud to access database operations

def get_mock_gyms() -> List[GymNearbyResponse]:
    """Returns a list of mock gyms for testing/fallback."""
    return [
        GymNearbyResponse(
            gym_id="gym_mock_123", name="Fitness First (Mock)", location="123 Main St, Anytown (Mock)",
            location_url="https://maps.google.com/?q=Fitness+First+Mock", token_per_visit=15.0,
            genders_accepted=["Unisex"],
            subscriptions=[Subscription(name="Monthly", length="1 month", price=50.0)],
            services=["Weights", "Cardio", "Classes"], distance=1.2
        ),
        GymNearbyResponse(
            gym_id="gym_mock_456", name="Strength Hub (Mock)", location="456 Oak Ave, Anytown (Mock)",
            location_url="https://maps.google.com/?q=Strength+Hub+Mock", token_per_visit=None,
            genders_accepted=["Male", "Female"],
            subscriptions=[Subscription(name="Annual", length="1 year", price=450.0)],
            services=["Powerlifting", "Strongman Equipment"], distance=3.5
        )
    ]

def calculate_distance_haversine(lat1: float, lon1: float, lat2: float, lon2: float) -> float:
    """
    Calculate the great circle distance between two points
    on the earth (specified in decimal degrees) using Haversine formula.
    Returns distance in kilometers.
    """
    R = 6371  # Radius of earth in kilometers.
    
    lat1_rad = radians(lat1)
    lon1_rad = radians(lon1)
    lat2_rad = radians(lat2)
    lon2_rad = radians(lon2)
    
    dlon = lon2_rad - lon1_rad
    dlat = lat2_rad - lat1_rad
    
    a = sin(dlat / 2)**2 + cos(lat1_rad) * cos(lat2_rad) * sin(dlon / 2)**2
    c = 2 * atan2(sqrt(a), sqrt(1 - a))
    
    distance = R * c
    return round(distance, 2)

async def find_nearby_gyms(latitude: float, longitude: float, radius_meters: int = 5000) -> List[GymNearbyResponse]:
    """
    Connects to Google Places API to find gyms, with a fallback to mock data.
    """
    if not settings.GOOGLE_API_KEY or settings.GOOGLE_API_KEY == "your_google_maps_api_key":
        print("GCloud service: Using MOCK DATA because GOOGLE_API_KEY is not set.")
        mock_list = get_mock_gyms()
        return [gym for gym in mock_list if gym.distance and gym.distance <= (radius_meters / 1000)]

    # Actual Google Places API call
    BASE_URL = "https://maps.googleapis.com/maps/api/place/nearbysearch/json"
    params = {
        "location": f"{latitude},{longitude}",
        "radius": radius_meters,
        "type": "gym",
        "key": settings.GOOGLE_API_KEY,
    }

    processed_gyms: List[GymNearbyResponse] = []
    db_gyms = crud.get_all_gyms_db()
    FUZZY_MATCH_THRESHOLD = 70

    try:
        async with httpx.AsyncClient() as client:
            response = await client.get(BASE_URL, params=params, timeout=10.0)
            response.raise_for_status()
            data = response.json()

            if data.get("status") == "OK":
                for place in data.get("results", []):
                    place_name = place.get("name", "N/A")
                    place_address = place.get("vicinity", "Address not available")
                    
                    geometry = place.get("geometry", {}).get("location", {})
                    place_lat = geometry.get("lat")
                    place_lng = geometry.get("lng")

                    if place_lat is None or place_lng is None:
                        continue

                    dist_km = calculate_distance_haversine(latitude, longitude, place_lat, place_lng)

                    matched_db_gym = None
                    best_score = -1
                    for db_gym in db_gyms:
                        score = fuzz.ratio(place_name.lower(), db_gym.name.lower())
                        if score > best_score and score >= FUZZY_MATCH_THRESHOLD:
                            best_score = score
                            matched_db_gym = db_gym
                    
                    if matched_db_gym:
                        gym_response = GymNearbyResponse(
                            gym_id=matched_db_gym.gym_id,
                            name=matched_db_gym.name,
                            location=matched_db_gym.location,
                            location_url=matched_db_gym.location_url,
                            token_per_visit=matched_db_gym.token_per_visit,
                            genders_accepted=matched_db_gym.genders_accepted,
                            subscriptions=matched_db_gym.subscriptions,
                            services=matched_db_gym.services,
                            distance=dist_km
                        )
                    else:
                        gym_response = GymNearbyResponse(
                            gym_id=place.get("place_id", ""), 
                            name=place_name,
                            location=place_address,
                            location_url=f"https://maps.google.com/?q={place_name},{place_address}", 
                            token_per_visit=None,
                            genders_accepted=[],
                            subscriptions=[],
                            services=[],
                            distance=dist_km
                        )
                    processed_gyms.append(gym_response)

            # If after processing there are no gyms, or if the status was not OK, return mock data as a fallback.
            if not processed_gyms:
                 print(f"Google Places API did not return usable results (status: {data.get('status')}). Falling back to mock data.")
                 return get_mock_gyms()

    except Exception as e:
        print(f"An unexpected error occurred during Google Places API call: {e}. Falling back to mock data.")
        return get_mock_gyms()
    
    return processed_gyms

# Note on Google Places API:
# The 'google-api-python-client' is more suited for APIs like Drive, Calendar, etc.
# For Google Places API, especially the newer versions (Places API prefered over Places API (deprecated)),
# direct HTTP requests using libraries like `httpx` (async) or `requests` (sync) are common.
# The previous implementation with `build("places", ...)` was incorrect for this use case.
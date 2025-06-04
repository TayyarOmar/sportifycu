from typing import List
from math import radians, sin, cos, sqrt, atan2
import httpx # Import httpx for asynchronous HTTP requests
from fuzzywuzzy import fuzz # For fuzzy string matching

from ..config import settings # Corrected relative import
from ..schemas import GymNearbyResponse # For structuring the output
from .. import crud # Import crud to access database operations

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
    Connects to Google Places API (Nearby Search) to find nearby gyms.
    Returns a list of gyms with their details, including distance.
    
    Note: This uses the classic Google Places API (Nearby Search) via direct HTTPX calls.
          For richer details or the newer Places API (New), additional API calls (e.g., Place Details)
          or a different client library/approach might be needed.
    """
    if not settings.GOOGLE_API_KEY or settings.GOOGLE_API_KEY == "your_google_maps_api_key":
        print("GCloud service: find_nearby_gyms using MOCK DATA for lat={latitude}, lon={longitude}.")
        print("Ensure GOOGLE_API_KEY is set in .env to use actual Google Places API.")
        # Return mock data structured as GymNearbyResponse
        mock_gym_list = [
            GymNearbyResponse(
                gym_id="gym_mock_123", name="Fitness First (Mock)", location="123 Main St, Anytown (Mock)",
                location_url="https://maps.google.com/?q=Fitness+First+Mock", token_per_visit=15.0,
                genders_accepted=["Unisex"],
                subscriptions=[{"name": "Monthly", "length": "1 month", "price": 50.0}],
                services=["Weights", "Cardio", "Classes"], distance=1.2
            ),
            GymNearbyResponse(
                gym_id="gym_mock_456", name="Strength Hub (Mock)", location="456 Oak Ave, Anytown (Mock)",
                location_url="https://maps.google.com/?q=Strength+Hub+Mock", token_per_visit=None,
                genders_accepted=["Male", "Female"],
                subscriptions=[{"name": "Annual", "length": "1 year", "price": 450.0}],
                services=["Powerlifting", "Strongman Equipment"], distance=3.5
            )
        ]
        # Filter mock data by distance conceptually (max 10km)
        return [gym for gym in mock_gym_list if gym.distance and gym.distance <= 10] # 10km limit for mock data

    # Actual Google Places API (Nearby Search) call using httpx
    BASE_URL = "https://maps.googleapis.com/maps/api/place/nearbysearch/json"
    params = {
        "location": f"{latitude},{longitude}",
        "radius": 10000, # Max radius for Nearby Search is 50,000 meters, but 10km is requested
        "type": "gym", # Use 'gym' or 'fitness_center'
        "key": settings.GOOGLE_API_KEY,
    }

    processed_gyms: List[GymNearbyResponse] = []
    db_gyms = crud.get_all_gyms_db() # Get all gyms from our database
    FUZZY_MATCH_THRESHOLD = 70 # Adjust as needed

    try:
        async with httpx.AsyncClient() as client:
            response = await client.get(BASE_URL, params=params, timeout=10.0)
            response.raise_for_status() # Raise an exception for HTTP errors (4xx or 5xx)
            data = response.json()

            if data.get("status") == "OK":
                for place in data.get("results", []):
                    place_name = place.get("name", "N/A")
                    place_address = place.get("vicinity", "Address not available")
                    
                    geometry = place.get("geometry", {}).get("location", {})
                    place_lat = geometry.get("lat")
                    place_lng = geometry.get("lng")

                    if place_lat is None or place_lng is None:
                        continue # Skip if no valid coordinates

                    dist_km = calculate_distance_haversine(latitude, longitude, place_lat, place_lng)

                    # Attempt to find a matching gym in our database using fuzzy matching
                    matched_db_gym = None
                    best_score = -1
                    for db_gym in db_gyms:
                        score = fuzz.ratio(place_name.lower(), db_gym.name.lower())
                        if score > best_score and score >= FUZZY_MATCH_THRESHOLD:
                            best_score = score
                            matched_db_gym = db_gym
                    
                    if matched_db_gym:
                        # Use data from our database for the gym, but keep Google's distance
                        gym_response = GymNearbyResponse(
                            gym_id=matched_db_gym.gym_id,
                            name=matched_db_gym.name,
                            location=matched_db_gym.location,
                            location_url=matched_db_gym.location_url,
                            token_per_visit=matched_db_gym.token_per_visit,
                            genders_accepted=matched_db_gym.genders_accepted,
                            subscriptions=matched_db_gym.subscriptions,
                            services=matched_db_gym.services,
                            distance=dist_km # Keep distance from Google API
                        )
                    else:
                        # Use data from Google Places API (no match in our DB)
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
            elif data.get("status") == "ZERO_RESULTS":
                print(f"Google Places API: No gyms found near ({latitude}, {longitude}).")
            else:
                print(f"Google Places API Error: {data.get("status")}. Message: {data.get("error_message", "No error message provided.")}")

    except httpx.RequestError as e:
        print(f"HTTPX request error during Google Places API call: {e}")
    except httpx.HTTPStatusError as e:
        print(f"HTTP error {e.response.status_code} response during Google Places API call: {e.response.text}")
    except Exception as e:
        print(f"An unexpected error occurred during Google Places API call: {e}")
    
    return processed_gyms

# Note on Google Places API:
# The 'google-api-python-client' is more suited for APIs like Drive, Calendar, etc.
# For Google Places API, especially the newer versions (Places API prefered over Places API (deprecated)),
# direct HTTP requests using libraries like `httpx` (async) or `requests` (sync) are common.
# The above implementation with `build("places", ...)` is highly conceptual and might not work directly
# due to the way Places API is structured and typically accessed.
# A production app would use a robust HTTP client and parse the JSON response.
# The mock data will be used if GOOGLE_API_KEY is not set or if google libraries are not installed.

# Helper function to calculate distance (Haversine formula)
# from math import radians, sin, cos, sqrt, atan2
# def calculate_distance(coord1: Tuple[float, float], coord2: Tuple[float, float]) -> float:
#     R = 6371  # Earth radius in kilometers
#     lat1, lon1 = radians(coord1[0]), radians(coord1[1])
#     lat2, lon2 = radians(coord2[0]), radians(coord2[1])
#     dlon = lon2 - lon1
#     dlat = lat2 - lat1
#     a = sin(dlat / 2)**2 + cos(lat1) * cos(lat2) * sin(dlon / 2)**2
#     c = 2 * atan2(sqrt(a), sqrt(1 - a))
#     distance = R * c
#     return round(distance, 2) 
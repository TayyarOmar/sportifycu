from typing import List
from math import radians, sin, cos, sqrt, atan2

# from googleapiclient.discovery import build # Potentially needed
# from google.oauth2 import service_account # If using service account credentials

from ..config import settings # Corrected relative import
from ..schemas import GymNearbyResponse # For structuring the output

# Attempt to import Google API client libraries
try:
    # Removed unused import: from googleapiclient.discovery import build
    from google.auth.exceptions import DefaultCredentialsError
    GOOGLE_API_AVAILABLE = True
except ImportError:
    GOOGLE_API_AVAILABLE = False
    print("WARNING: google-api-python-client or google-auth not installed. GCloud service will use mock data.")
    print("Please install with: uv pip install google-api-python-client google-auth-httplib2 google-auth-oauthlib")

# Placeholder for Google API client initialization
# def get_places_service():
#     # This would initialize the Google Places API client
#     # Requires GOOGLE_API_KEY to be set in .env
#     # Example (conceptual):
#     # if settings.GOOGLE_API_KEY == "your_google_maps_api_key" or not settings.GOOGLE_API_KEY:
#     #     print("Google API Key not configured. GCloud services will be mocked.")
#     #     return None
#     # try:
#     #     service = build("places", "v1", developerKey=settings.GOOGLE_API_KEY) # This is conceptual
#     #     return service
#     # except Exception as e:
#     #     print(f"Error initializing Google Places service: {e}")
#     #     return None
#     return None # Placeholder

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
    Connects to Google Places API to find nearby gyms.
    Returns a list of gyms with their details, including distance.
    """
    if not GOOGLE_API_AVAILABLE or settings.GOOGLE_API_KEY == "your_google_maps_api_key" or not settings.GOOGLE_API_KEY:
        print(f"GCloud service: find_nearby_gyms using MOCK DATA for lat={latitude}, lon={longitude}.")
        print("Ensure GOOGLE_API_KEY is set and google-api-python-client libraries are installed.")
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
        # Filter mock data by distance conceptually
        return [gym for gym in mock_gym_list if gym.distance and gym.distance <= radius_meters / 1000]

    try:
        # Note: The 'places' API name and version might change. Refer to Google Cloud documentation.
        # Using the older "customsearch" as a generic example of building a service.
        # For Google Places API (New), you'd typically use a specific client library or REST calls.
        # Let's assume a direct REST API call approach for Places API for simplicity if client is complex.
        # However, the `google-api-python-client` is generally for services like Drive, Calendar, etc.
        # For Places API, direct HTTP requests with `httpx` or `aiohttp` are often preferred in async Python.

        # Simulating a direct API call structure if google-api-python-client isn't ideal for "Places API (New)"
        # For this example, we will stick to trying to use `build` if it were a service listed.
        # The "places" service might not be available via `build` in this manner.
        # If it's not, this block will fail and fall back to mock.
        
        # This is a conceptual placeholder for using the 'build' function.
        # Actual Places API (especially the newer versions) might require direct HTTP calls or a different client.
        # service = build("places", "v1", developerKey=settings.GOOGLE_API_KEY, static_discovery=False) # Fictional
        
        # Given the complexity and potential for `build` not supporting Places API directly in this way,
        # we will print a message and fall back to mock if it's not straightforward.
        # A production implementation would use `httpx` or `requests` for direct REST calls to Places API.
        
        print(f"Attempting Google Places API call for ({latitude}, {longitude})")
        print("Note: The following is a simplified conceptualisation of using the Google Places API.")
        print("A robust implementation would use `httpx` or `requests` for direct REST calls.")
        
        # This is where you'd make the actual API call.
        # Example of what the call might look like (conceptual, actual API may differ):
        # request = service.places().searchNearby( # This is a hypothetical method
        #     location=f'{latitude},{longitude}',
        #     radius=radius_meters,
        #     type='gym', # Or keyword='gym'
        #     fields='places.id,places.displayName,places.formattedAddress,places.location,places.websiteUri'
        # ).execute() # This is a blocking call, in async, use await loop.run_in_executor

        # For now, as a placeholder for actual API call logic and because `build` might not work for Places easily:
        raise NotImplementedError("Actual Google Places API call via `build` is complex; direct HTTP request is typical.")

    except DefaultCredentialsError:
        print("Google API: DefaultCredentialsError. Ensure your environment is authenticated or API key is valid.")
        # Fallback to mock data
        return await find_nearby_gyms(latitude, longitude, radius_meters) # Recursive call to get mock
    except NotImplementedError as e:
        print(f"Google API: {e}. Falling back to mock data.")
        return await find_nearby_gyms(latitude, longitude, radius_meters) # Recursive call to get mock
    except Exception as e:
        print(f"Error connecting to Google Places API or processing results: {e}")
        # Fallback to mock data in case of any other error during API interaction
        return await find_nearby_gyms(latitude, longitude, radius_meters) # Recursive call to get mock

    # Assuming `api_results` is a list of place data from the API
    # api_results = request.get('places', []) # Example if 'places' is the key in response
    api_results_placeholder = [] # Replace with actual API call results

    processed_gyms: List[GymNearbyResponse] = []
    for place in api_results_placeholder:
        place_lat = place.get('location', {}).get('latitude')
        place_lng = place.get('location', {}).get('longitude')
        
        if not place_lat or not place_lng:
            continue

        dist_km = calculate_distance_haversine(latitude, longitude, place_lat, place_lng)

        if dist_km * 1000 <= radius_meters:
            # Map API fields to your GymNearbyResponse schema
            # This requires knowing the exact structure of the Google Places API response
            gym_response = GymNearbyResponse(
                gym_id=place.get('id', f"pid_{place_lat}_{place_lng}"), # place.id or place.name
                name=place.get('displayName', {}).get('text', 'N/A') if isinstance(place.get('displayName'), dict) else place.get('displayName', 'N/A'),
                location=place.get('formattedAddress', 'Address not available'),
                location_url=place.get('websiteUri', None), # Or construct Google Maps URL
                # These fields would need to be fetched or defaulted if not directly from Places API basic search
                token_per_visit=None, 
                genders_accepted=[], 
                subscriptions=[], 
                services=[], 
                distance=dist_km
            )
            processed_gyms.append(gym_response)
            
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
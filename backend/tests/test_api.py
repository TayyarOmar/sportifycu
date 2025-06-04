import pytest
from fastapi.testclient import TestClient
from datetime import datetime, timezone, timedelta
from unittest.mock import patch, AsyncMock

from backend.main import app
from backend.database import UserTable, GymTable, GroupActivityTeamTable
from backend.models import Gym, GroupActivityTeam
from backend import crud, auth

client = TestClient(app)

@pytest.fixture(scope="function")
def clean_db():
    """Clean database and in-memory code store before each test"""
    UserTable.truncate()
    GymTable.truncate()
    GroupActivityTeamTable.truncate()
    auth.temp_code_store.clear()
    yield
    UserTable.truncate()
    GymTable.truncate()
    GroupActivityTeamTable.truncate()
    auth.temp_code_store.clear()

@pytest.fixture
def sample_user_data():
    return {
        "name": "Test User",
        "email": "test@example.com",
        "password": "testpassword123",
        "gender": "Male",
        "age": 25
    }

@pytest.fixture
def sample_gym_data():
    return {
        "name": "Test Gym",
        "location": "123 Test Street",
        "location_url": "https://maps.google.com/test",
        "token_per_visit": 15.0,
        "genders_accepted": ["Male", "Female"],
        "subscriptions": [{"name": "Monthly", "length": "1 month", "price": 50.0}],
        "services": ["Weights", "Cardio"]
    }

@pytest.fixture
def sample_team_data():
    return {
        "name": "Test Team",
        "description": "Test Description",
        "category": "Running",
        "location": "Test Location",
        "date_and_time": "2024-12-31T10:00:00",
        "age_range": "18-30",
        "contact_information": "test@contact.com",
        "players_needed": 5,
        "photo_base64": "iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNkYPhfDwAChwGA60e6kgAAAABJRU5ErkJggg=="  # Sample base64 image
    }

@pytest.fixture
def authenticated_user(clean_db, sample_user_data):
    """Create user, simulate 2FA code login, return access token and user details"""
    # 1. Create user (signup)
    signup_response = client.post("/api/v1/auth/signup", json=sample_user_data)
    assert signup_response.status_code == 201
    user_details_from_signup = signup_response.json()
    
    # 2. Request 2FA login code (login step 1)
    with patch('backend.services.email_service.send_2fa_login_email', new_callable=AsyncMock) as mock_send_email:
        login_response = client.post("/api/v1/auth/login", json={
            "email": sample_user_data["email"],
            "password": sample_user_data["password"]
        })
        assert login_response.status_code == 200
        mock_send_email.assert_called_once() # Ensure email sending was attempted
        # Get the code directly from the in-memory store for testing (instead of parsing email)
        sent_code = auth.temp_code_store[sample_user_data["email"]]["code"]
        assert auth.temp_code_store[sample_user_data["email"]]["type"] == "2fa_login_code"
    
    # 3. Verify 2FA code (login step 2)
    verify_payload = {"email": sample_user_data["email"], "code": sent_code}
    verify_response = client.post("/api/v1/auth/verify-2fa-code", json=verify_payload)
    assert verify_response.status_code == 200
    
    token_data = verify_response.json()
    return {
        "token": token_data["access_token"],
        "user_id": user_details_from_signup["user_id"],
        "email": sample_user_data["email"]
    }

class TestAuthEndpoints:
    
    def test_signup_success(self, clean_db, sample_user_data):
        response = client.post("/api/v1/auth/signup", json=sample_user_data)
        assert response.status_code == 201
        data = response.json()
        assert data["email"] == sample_user_data["email"]
        assert data["name"] == sample_user_data["name"]
        assert "user_id" in data
        assert "otp_provisioning_uri" in data
        assert "Email code login also available" in data["message"]

    def test_signup_duplicate_email(self, clean_db, sample_user_data):
        client.post("/api/v1/auth/signup", json=sample_user_data)
        response = client.post("/api/v1/auth/signup", json=sample_user_data)
        assert response.status_code == 400
        assert "already registered" in response.json()["detail"]

    def test_signup_invalid_email(self, clean_db):
        invalid_data = {
            "name": "Test User",
            "email": "invalid-email",
            "password": "testpassword123"
        }
        response = client.post("/api/v1/auth/signup", json=invalid_data)
        assert response.status_code == 422

    @patch('backend.services.email_service.send_2fa_login_email', new_callable=AsyncMock)
    def test_login_sends_2fa_code_email(self, mock_send_email, clean_db, sample_user_data):
        client.post("/api/v1/auth/signup", json=sample_user_data)
        
        response = client.post("/api/v1/auth/login", json={
            "email": sample_user_data["email"],
            "password": sample_user_data["password"]
        })
        assert response.status_code == 200
        assert "A 6-digit code has been sent" in response.json()["message"]
        mock_send_email.assert_called_once() # Check that email sending was called
        # Further check: code should be in temp_code_store
        assert sample_user_data["email"] in auth.temp_code_store
        assert auth.temp_code_store[sample_user_data["email"]]["type"] == "2fa_login_code"

    def test_login_invalid_credentials(self, clean_db, sample_user_data):
        client.post("/api/v1/auth/signup", json=sample_user_data)
        response = client.post("/api/v1/auth/login", json={
            "email": sample_user_data["email"],
            "password": "wrongpassword"
        })
        assert response.status_code == 401

    def test_verify_2fa_login_code_success(self, clean_db, sample_user_data):
        client.post("/api/v1/auth/signup", json=sample_user_data) # Signup user
        # Manually create and store code for testing this endpoint directly
        test_email = sample_user_data["email"]
        test_code = auth.create_email_verification_code(email=test_email, code_type="2fa_login_code")
        
        payload = {"email": test_email, "code": test_code}
        response = client.post("/api/v1/auth/verify-2fa-code", json=payload)
        assert response.status_code == 200
        data = response.json()
        assert "access_token" in data
        assert data["token_type"] == "bearer"

    def test_verify_2fa_login_code_invalid_code(self, clean_db, sample_user_data):
        client.post("/api/v1/auth/signup", json=sample_user_data)
        payload = {"email": sample_user_data["email"], "code": "000000"} # Incorrect code
        response = client.post("/api/v1/auth/verify-2fa-code", json=payload)
        assert response.status_code == 400
        assert "Invalid or expired 2FA login code" in response.json()["detail"]

    def test_verify_2fa_login_code_expired(self, clean_db, sample_user_data):
        client.post("/api/v1/auth/signup", json=sample_user_data)
        test_email = sample_user_data["email"]
        test_code = auth.create_email_verification_code(email=test_email, code_type="2fa_login_code")
        
        # Manually expire the code in the store
        auth.temp_code_store[test_email]["expires_at"] = datetime.now(timezone.utc) - timedelta(minutes=1)
        
        payload = {"email": test_email, "code": test_code}
        response = client.post("/api/v1/auth/verify-2fa-code", json=payload)
        assert response.status_code == 400
        assert "Invalid or expired 2FA login code" in response.json()["detail"]

    @patch('backend.services.email_service.send_password_reset_email', new_callable=AsyncMock)
    def test_request_password_reset_sends_code_email(self, mock_send_email, clean_db, sample_user_data):
        client.post("/api/v1/auth/signup", json=sample_user_data)
        
        response = client.post("/api/v1/auth/request-password-reset", json={
            "email": sample_user_data["email"]
        })
        assert response.status_code == 200
        assert "Password reset code sent" in response.json()["message"]
        mock_send_email.assert_called_once()
        assert sample_user_data["email"] in auth.temp_code_store
        assert auth.temp_code_store[sample_user_data["email"]]["type"] == "password_reset_code"

    def test_request_password_reset_user_not_found(self, clean_db):
        response = client.post("/api/v1/auth/request-password-reset", json={
            "email": "nonexistent@example.com"
        })
        assert response.status_code == 404

    def test_confirm_password_reset_with_code_success(self, clean_db, sample_user_data):
        client.post("/api/v1/auth/signup", json=sample_user_data)
        test_email = sample_user_data["email"]
        reset_code = auth.create_email_verification_code(email=test_email, code_type="password_reset_code")
        
        payload = {
            "email": test_email,
            "code": reset_code,
            "new_password": "newpassword123"
        }
        response = client.post("/api/v1/auth/confirm-password-reset", json=payload)
        assert response.status_code == 200
        assert "Password has been reset successfully" in response.json()["message"]

        # Verify old password no longer works
        login_response = client.post("/api/v1/auth/login", json={
            "email": test_email,
            "password": sample_user_data["password"]
        })
        assert login_response.status_code == 401 # Should fail with old password
        
        # Verify new password works (leads to 2FA code email)
        login_response_new_pw = client.post("/api/v1/auth/login", json={
            "email": test_email,
            "password": "newpassword123"
        })
        assert login_response_new_pw.status_code == 200 # New password leads to 2FA step

    def test_confirm_password_reset_invalid_code(self, clean_db, sample_user_data):
        client.post("/api/v1/auth/signup", json=sample_user_data)
        payload = {
            "email": sample_user_data["email"],
            "code": "000000",
            "new_password": "newpassword123"
        }
        response = client.post("/api/v1/auth/confirm-password-reset", json=payload)
        assert response.status_code == 400
        assert "Invalid or expired password reset code" in response.json()["detail"]

class TestUserEndpoints:
    
    def test_get_current_user(self, authenticated_user):
        headers = {"Authorization": f"Bearer {authenticated_user['token']}"}
        response = client.get("/api/v1/users/me", headers=headers)
        assert response.status_code == 200
        data = response.json()
        assert data["email"] == authenticated_user["email"]

    def test_update_user_profile(self, authenticated_user):
        headers = {"Authorization": f"Bearer {authenticated_user['token']}"}
        update_data = {
            "name": "Updated Name",
            "age": 30,
            "fitness_goals": ["Weight Loss", "Muscle Gain"]
        }
        response = client.put("/api/v1/users/me/profile", json=update_data, headers=headers)
        assert response.status_code == 200
        data = response.json()
        assert data["name"] == "Updated Name"
        assert data["age"] == 30
        assert "Weight Loss" in data["fitness_goals"]

    def test_get_activity_tracking(self, authenticated_user):
        headers = {"Authorization": f"Bearer {authenticated_user['token']}"}
        response = client.get("/api/v1/users/me/activity-tracking", headers=headers)
        assert response.status_code == 200
        data = response.json()
        assert "running_total_km" in data
        assert "steps_total" in data
        assert "gym_time_total_minutes" in data
        assert "calculated_score" in data

    def test_add_activity_log(self, authenticated_user):
        headers = {"Authorization": f"Bearer {authenticated_user['token']}"}
        activity_data = {
            "date": "2024-01-01",
            "activity_type": "running",
            "value": 5.0,
            "unit": "km"
        }
        response = client.post("/api/v1/users/me/activity-log", json=activity_data, headers=headers)
        assert response.status_code == 200
        data = response.json()
        assert data["activity_type"] == "running"
        assert data["value"] == 5.0

    def test_log_running_activity_new(self, authenticated_user):
        headers = {"Authorization": f"Bearer {authenticated_user['token']}"}
        running_data = {
            "date": "2024-01-15",
            "value": 10.5
        }
        response = client.post("/api/v1/users/me/activity-log/running", json=running_data, headers=headers)
        assert response.status_code == 200
        data = response.json()
        assert data["activity_type"] == "running"
        assert data["value"] == 10.5
        assert data["unit"] == "km"
        assert data["date"] == "2024-01-15"

    def test_log_running_activity_update_existing(self, authenticated_user):
        headers = {"Authorization": f"Bearer {authenticated_user['token']}"}
        # First log
        running_data = {
            "date": "2024-01-16",
            "value": 5.0
        }
        response1 = client.post("/api/v1/users/me/activity-log/running", json=running_data, headers=headers)
        assert response1.status_code == 200
        
        # Update same date
        running_data_updated = {
            "date": "2024-01-16",
            "value": 8.0
        }
        response2 = client.post("/api/v1/users/me/activity-log/running", json=running_data_updated, headers=headers)
        assert response2.status_code == 200
        data = response2.json()
        assert data["value"] == 8.0
        
        # Verify only one entry exists for this date by checking activity tracking
        tracking_response = client.get("/api/v1/users/me/activity-tracking", headers=headers)
        tracking_data = tracking_response.json()
        # Should have 8.0 km, not 13.0 km (5.0 + 8.0)
        assert tracking_data["running_total_km"] == 8.0

    def test_log_steps_activity_new(self, authenticated_user):
        headers = {"Authorization": f"Bearer {authenticated_user['token']}"}
        steps_data = {
            "date": "2024-01-17",
            "value": 12000
        }
        response = client.post("/api/v1/users/me/activity-log/steps", json=steps_data, headers=headers)
        assert response.status_code == 200
        data = response.json()
        assert data["activity_type"] == "steps"
        assert data["value"] == 12000.0
        assert data["unit"] == "steps"
        assert data["date"] == "2024-01-17"

    def test_log_steps_activity_update_existing(self, authenticated_user):
        headers = {"Authorization": f"Bearer {authenticated_user['token']}"}
        # First log
        steps_data = {
            "date": "2024-01-18",
            "value": 8000
        }
        response1 = client.post("/api/v1/users/me/activity-log/steps", json=steps_data, headers=headers)
        assert response1.status_code == 200
        
        # Update same date
        steps_data_updated = {
            "date": "2024-01-18",
            "value": 15000
        }
        response2 = client.post("/api/v1/users/me/activity-log/steps", json=steps_data_updated, headers=headers)
        assert response2.status_code == 200
        data = response2.json()
        assert data["value"] == 15000.0
        
        # Verify only one entry exists for this date
        tracking_response = client.get("/api/v1/users/me/activity-tracking", headers=headers)
        tracking_data = tracking_response.json()
        assert tracking_data["steps_total"] == 15000

    def test_log_gym_time_activity_new(self, authenticated_user):
        headers = {"Authorization": f"Bearer {authenticated_user['token']}"}
        gym_time_data = {
            "date": "2024-01-19",
            "value": 90
        }
        response = client.post("/api/v1/users/me/activity-log/gym-time", json=gym_time_data, headers=headers)
        assert response.status_code == 200
        data = response.json()
        assert data["activity_type"] == "gym_time"
        assert data["value"] == 90.0
        assert data["unit"] == "minutes"
        assert data["date"] == "2024-01-19"

    def test_log_gym_time_activity_update_existing(self, authenticated_user):
        headers = {"Authorization": f"Bearer {authenticated_user['token']}"}
        # First log
        gym_time_data = {
            "date": "2024-01-20",
            "value": 60
        }
        response1 = client.post("/api/v1/users/me/activity-log/gym-time", json=gym_time_data, headers=headers)
        assert response1.status_code == 200
        
        # Update same date
        gym_time_data_updated = {
            "date": "2024-01-20",
            "value": 120
        }
        response2 = client.post("/api/v1/users/me/activity-log/gym-time", json=gym_time_data_updated, headers=headers)
        assert response2.status_code == 200
        data = response2.json()
        assert data["value"] == 120.0
        
        # Verify only one entry exists for this date
        tracking_response = client.get("/api/v1/users/me/activity-tracking", headers=headers)
        tracking_data = tracking_response.json()
        assert tracking_data["gym_time_total_minutes"] == 120

    def test_log_multiple_activities_same_date(self, authenticated_user):
        headers = {"Authorization": f"Bearer {authenticated_user['token']}"}
        test_date = "2024-01-21"
        
        # Log all three activities for the same date
        running_data = {"date": test_date, "value": 5.0}
        steps_data = {"date": test_date, "value": 10000}
        gym_time_data = {"date": test_date, "value": 75}
        
        # Log running
        response1 = client.post("/api/v1/users/me/activity-log/running", json=running_data, headers=headers)
        assert response1.status_code == 200
        
        # Log steps
        response2 = client.post("/api/v1/users/me/activity-log/steps", json=steps_data, headers=headers)
        assert response2.status_code == 200
        
        # Log gym time
        response3 = client.post("/api/v1/users/me/activity-log/gym-time", json=gym_time_data, headers=headers)
        assert response3.status_code == 200
        
        # Verify all activities are tracked
        tracking_response = client.get("/api/v1/users/me/activity-tracking", headers=headers)
        tracking_data = tracking_response.json()
        assert tracking_data["running_total_km"] >= 5.0
        assert tracking_data["steps_total"] >= 10000
        assert tracking_data["gym_time_total_minutes"] >= 75

    def test_activity_log_invalid_date_format(self, authenticated_user):
        headers = {"Authorization": f"Bearer {authenticated_user['token']}"}
        invalid_data = {
            "date": "invalid-date",
            "value": 5.0
        }
        response = client.post("/api/v1/users/me/activity-log/running", json=invalid_data, headers=headers)
        assert response.status_code == 422

    def test_activity_log_negative_value(self, authenticated_user):
        headers = {"Authorization": f"Bearer {authenticated_user['token']}"}
        negative_data = {
            "date": "2024-01-22",
            "value": -5.0
        }
        # The API should accept negative values (might be corrections), but this tests the behavior
        response = client.post("/api/v1/users/me/activity-log/running", json=negative_data, headers=headers)
        assert response.status_code == 200  # Assuming we allow negative values

    def test_set_favourite_gym(self, authenticated_user, clean_db):
        # Create a gym first
        gym = Gym(name="Test Gym", location="Test Location")
        crud.create_gym_db(gym)
        
        headers = {"Authorization": f"Bearer {authenticated_user['token']}"}
        response = client.post(f"/api/v1/users/me/favourites/{gym.gym_id}", headers=headers)
        assert response.status_code == 200
        data = response.json()
        assert gym.gym_id in data["favourites"]

    def test_remove_favourite_gym(self, authenticated_user, clean_db):
        # Create a gym and add to favourites
        gym = Gym(name="Test Gym", location="Test Location")
        crud.create_gym_db(gym)
        
        headers = {"Authorization": f"Bearer {authenticated_user['token']}"}
        # Add to favourites
        client.post(f"/api/v1/users/me/favourites/{gym.gym_id}", headers=headers)
        
        # Remove from favourites
        response = client.delete(f"/api/v1/users/me/favourites/{gym.gym_id}", headers=headers)
        assert response.status_code == 200
        data = response.json()
        assert gym.gym_id not in data["favourites"]

    def test_set_notification_settings(self, authenticated_user):
        headers = {"Authorization": f"Bearer {authenticated_user['token']}"}
        response = client.put("/api/v1/users/me/notification-settings", 
                            json={"enabled": False}, headers=headers)
        assert response.status_code == 200
        data = response.json()
        assert not data["notification_setting"]

    def test_get_user_bookings(self, authenticated_user):
        headers = {"Authorization": f"Bearer {authenticated_user['token']}"}
        response = client.get("/api/v1/users/me/bookings", headers=headers)
        assert response.status_code == 200
        assert isinstance(response.json(), list)

    def test_get_user_achievements(self, authenticated_user):
        headers = {"Authorization": f"Bearer {authenticated_user['token']}"}
        response = client.get("/api/v1/users/me/achievements", headers=headers)
        assert response.status_code == 200
        assert isinstance(response.json(), list)

class TestGymEndpoints:
    
    def test_get_all_gyms(self, clean_db):
        # Create test gyms
        gym1 = Gym(name="Gym 1", location="Location 1")
        gym2 = Gym(name="Gym 2", location="Location 2")
        crud.create_gym_db(gym1)
        crud.create_gym_db(gym2)
        
        response = client.get("/api/v1/gyms/")
        assert response.status_code == 200
        data = response.json()
        assert len(data) == 2
        assert any(gym["name"] == "Gym 1" for gym in data)

    @patch('backend.services.gcloud_service.find_nearby_gyms')
    def test_find_gyms_around_you(self, mock_find_gyms, clean_db):
        # Mock the gcloud service response
        mock_find_gyms.return_value = [
            {
                "gym_id": "test_gym_1",
                "name": "Nearby Gym",
                "location": "Test Location",
                "location_url": "https://maps.google.com/test",
                "token_per_visit": 15.0,
                "genders_accepted": ["Unisex"],
                "subscriptions": [],
                "services": ["Weights"],
                "distance": 2.5
            }
        ]
        
        response = client.get("/api/v1/gyms/around-you?latitude=40.7128&longitude=-74.0060")
        assert response.status_code == 200
        data = response.json()
        assert len(data) == 1
        assert data[0]["name"] == "Nearby Gym"
        assert data[0]["distance"] == 2.5

    def test_find_gyms_invalid_coordinates(self, clean_db):
        response = client.get("/api/v1/gyms/around-you?latitude=91&longitude=-74.0060")
        assert response.status_code == 400

class TestActivityTeamEndpoints:
    
    def test_create_activity_team(self, authenticated_user, sample_team_data):
        headers = {"Authorization": f"Bearer {authenticated_user['token']}"}
        
        # Convert to form data
        form_data = {
            "name": sample_team_data["name"],
            "description": sample_team_data["description"],
            "category": sample_team_data["category"],
            "location": sample_team_data["location"],
            "date_and_time": sample_team_data["date_and_time"],
            "age_range": sample_team_data["age_range"],
            "contact_information": sample_team_data["contact_information"],
            "players_needed": sample_team_data["players_needed"],
            "photo_base64": sample_team_data["photo_base64"]
        }
        
        response = client.post("/api/v1/activity-teams/", data=form_data, headers=headers)
        assert response.status_code == 201
        data = response.json()
        assert data["name"] == sample_team_data["name"]
        assert data["lister_id"] == authenticated_user["user_id"]

    def test_edit_activity_team(self, authenticated_user, sample_team_data):
        headers = {"Authorization": f"Bearer {authenticated_user['token']}"}
        
        # Create team first
        form_data = {
            "name": sample_team_data["name"],
            "description": sample_team_data["description"],
            "category": sample_team_data["category"],
            "location": sample_team_data["location"],
            "date_and_time": sample_team_data["date_and_time"],
            "age_range": sample_team_data["age_range"],
            "contact_information": sample_team_data["contact_information"],
            "players_needed": sample_team_data["players_needed"],
            "photo_base64": sample_team_data["photo_base64"]
        }
        
        create_response = client.post("/api/v1/activity-teams/", data=form_data, headers=headers)
        team_id = create_response.json()["team_id"]
        
        # Edit team
        update_data = {"name": "Updated Team Name", "players_needed": 10}
        response = client.put(f"/api/v1/activity-teams/{team_id}", json=update_data, headers=headers)
        assert response.status_code == 200
        data = response.json()
        assert data["name"] == "Updated Team Name"
        assert data["players_needed"] == 10

    def test_delete_activity_team(self, authenticated_user, sample_team_data):
        headers = {"Authorization": f"Bearer {authenticated_user['token']}"}
        
        # Create team first
        form_data = {
            "name": sample_team_data["name"],
            "description": sample_team_data["description"],
            "category": sample_team_data["category"],
            "location": sample_team_data["location"],
            "date_and_time": sample_team_data["date_and_time"],
            "age_range": sample_team_data["age_range"],
            "contact_information": sample_team_data["contact_information"],
            "players_needed": sample_team_data["players_needed"],
            "photo_base64": sample_team_data["photo_base64"]
        }
        
        create_response = client.post("/api/v1/activity-teams/", data=form_data, headers=headers)
        team_id = create_response.json()["team_id"]
        
        # Delete team
        response = client.delete(f"/api/v1/activity-teams/{team_id}", headers=headers)
        assert response.status_code == 204

    def test_get_all_active_activity_teams(self, authenticated_user, sample_team_data):
        headers = {"Authorization": f"Bearer {authenticated_user['token']}"}
        
        # Create team first
        form_data = {
            "name": sample_team_data["name"],
            "description": sample_team_data["description"],
            "category": sample_team_data["category"],
            "location": sample_team_data["location"],
            "date_and_time": sample_team_data["date_and_time"],
            "age_range": sample_team_data["age_range"],
            "contact_information": sample_team_data["contact_information"],
            "players_needed": sample_team_data["players_needed"],
            "photo_base64": sample_team_data["photo_base64"]
        }
        
        client.post("/api/v1/activity-teams/", data=form_data, headers=headers)
        
        # Get all teams
        response = client.get("/api/v1/activity-teams/")
        assert response.status_code == 200
        data = response.json()
        assert len(data) >= 1
        assert any(team["name"] == sample_team_data["name"] for team in data)

    def test_add_booking_for_team(self, authenticated_user, sample_team_data, clean_db):
        # Create another user to be the lister
        lister_data = {
            "name": "Lister User",
            "email": "lister@example.com",
            "password": "password123"
        }
        client.post("/api/v1/auth/signup", json=lister_data)
        lister_user = crud.get_user_by_email("lister@example.com")
        
        # Create team with lister
        team_data = sample_team_data.copy()
        team_data["date_and_time"] = datetime.fromisoformat(sample_team_data["date_and_time"])
        team = GroupActivityTeam(
            **team_data,
            lister_id=lister_user.user_id
        )
        crud.create_group_activity_team_db(team)
        
        # Book team
        headers = {"Authorization": f"Bearer {authenticated_user['token']}"}
        response = client.post(f"/api/v1/activity-teams/{team.team_id}/bookings", headers=headers)
        assert response.status_code == 200
        assert "Successfully booked" in response.json()["message"]

class TestLeaderboardEndpoints:
    
    def test_get_top_users_by_score(self, authenticated_user):
        # Add some activity logs to generate score
        headers = {"Authorization": f"Bearer {authenticated_user['token']}"}
        activity_data = {
            "date": "2024-01-01",
            "activity_type": "running",
            "value": 10.0,
            "unit": "km"
        }
        client.post("/api/v1/users/me/activity-log", json=activity_data, headers=headers)
        
        # Get leaderboard
        response = client.get("/api/v1/leaderboards/top-scores")
        assert response.status_code == 200
        data = response.json()
        assert isinstance(data, list)
        if len(data) > 0:
            assert "user_id" in data[0]
            assert "name" in data[0]
            assert "score" in data[0]

    def test_get_top_users_with_limit(self, authenticated_user):
        response = client.get("/api/v1/leaderboards/top-scores?limit=5")
        assert response.status_code == 200
        data = response.json()
        assert len(data) <= 5

class TestAuthenticationRequired:
    
    def test_protected_endpoints_require_auth(self):
        """Test that protected endpoints return 401 without authentication"""
        protected_endpoints = [
            ("GET", "/api/v1/users/me"),
            ("PUT", "/api/v1/users/me/profile"),
            ("GET", "/api/v1/users/me/activity-tracking"),
            ("POST", "/api/v1/users/me/activity-log"),
            ("POST", "/api/v1/users/me/activity-log/running"),
            ("POST", "/api/v1/users/me/activity-log/steps"),
            ("POST", "/api/v1/users/me/activity-log/gym-time"),
            ("POST", "/api/v1/users/me/favourites/test_gym_id"),
            ("PUT", "/api/v1/users/me/notification-settings"),
            ("GET", "/api/v1/users/me/bookings"),
            ("GET", "/api/v1/users/me/achievements"),
            ("POST", "/api/v1/activity-teams/"),
            ("PUT", "/api/v1/activity-teams/test_team_id"),
            ("DELETE", "/api/v1/activity-teams/test_team_id"),
            ("POST", "/api/v1/activity-teams/test_team_id/bookings")
        ]
        
        for method, endpoint in protected_endpoints:
            if method == "GET":
                response = client.get(endpoint)
            elif method == "POST":
                response = client.post(endpoint, json={})
            elif method == "PUT":
                response = client.put(endpoint, json={})
            elif method == "DELETE":
                response = client.delete(endpoint)
            
            assert response.status_code == 401, f"Endpoint {method} {endpoint} should require authentication"

class TestErrorHandling:
    
    def test_404_endpoints(self):
        """Test that non-existent endpoints return 404"""
        response = client.get("/api/v1/nonexistent")
        assert response.status_code == 404

    def test_invalid_json_payload(self, authenticated_user):
        """Test handling of invalid JSON payloads"""
        headers = {"Authorization": f"Bearer {authenticated_user['token']}"}
        response = client.put("/api/v1/users/me/profile", 
                            data="invalid json", 
                            headers={**headers, "Content-Type": "application/json"})
        assert response.status_code == 422

    def test_missing_required_fields(self, clean_db):
        """Test handling of missing required fields"""
        incomplete_data = {
            "name": "Test User",
            # Missing email and password
        }
        response = client.post("/api/v1/auth/signup", json=incomplete_data)
        assert response.status_code == 422

if __name__ == "__main__":
    pytest.main([__file__, "-v"]) 
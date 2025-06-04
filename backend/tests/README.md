# Sportify Backend Test Suite

This directory contains comprehensive tests for all API endpoints in the Sportify fitness application backend.

## Test Coverage

### Authentication Endpoints (`TestAuthEndpoints`)
- ✅ User signup with 2FA setup
- ✅ Duplicate email validation
- ✅ Invalid email format handling
- ✅ Login with 2FA email verification
- ✅ Invalid credentials handling
- ✅ 2FA token verification
- ✅ Password reset request
- ✅ Password reset confirmation

### User Management Endpoints (`TestUserEndpoints`)
- ✅ Get current user profile
- ✅ Update user profile
- ✅ Activity tracking (running, steps, gym time, score)
- ✅ Add activity logs
- ✅ Set/remove favorite gyms
- ✅ Notification settings
- ✅ User bookings management
- ✅ User achievements

### Gym Endpoints (`TestGymEndpoints`)
- ✅ Get all gyms
- ✅ Find nearby gyms (with Google Places API integration)
- ✅ Invalid coordinates validation

### Activity Team Endpoints (`TestActivityTeamEndpoints`)
- ✅ Create activity teams with form data and photo upload
- ✅ Edit activity teams (lister authorization)
- ✅ Delete activity teams (lister authorization)
- ✅ Get all active activity teams (public endpoint)
- ✅ Add bookings to teams

### Leaderboard Endpoints (`TestLeaderboardEndpoints`)
- ✅ Get top users by activity score
- ✅ Limit parameter validation

### Security Tests (`TestAuthenticationRequired`)
- ✅ Protected endpoints require authentication
- ✅ Proper 401 responses for unauthorized access

### Error Handling Tests (`TestErrorHandling`)
- ✅ 404 for non-existent endpoints
- ✅ Invalid JSON payload handling
- ✅ Missing required fields validation

## Running Tests

From the project root directory:

```bash
# Run all tests
python -m pytest backend/tests/test_api.py -v

# Run specific test class
python -m pytest backend/tests/test_api.py::TestAuthEndpoints -v

# Run specific test
python -m pytest backend/tests/test_api.py::TestAuthEndpoints::test_signup_success -v

# Run with coverage (if coverage is installed)
python -m pytest backend/tests/test_api.py --cov=backend --cov-report=html
```

## Test Features

- **Database Isolation**: Each test uses a clean database state
- **Authentication Mocking**: Email services and external APIs are mocked
- **Comprehensive Fixtures**: Reusable test data and authenticated users
- **Error Scenario Testing**: Invalid inputs, unauthorized access, etc.
- **Integration Testing**: Full request/response cycle testing

## Dependencies

The test suite requires:
- `pytest` - Test framework
- `pytest-asyncio` - Async test support
- `httpx` - HTTP client for testing
- `python-multipart` - Form data handling
- `bcrypt` - Password hashing

## Test Database

Tests use a temporary database file that is automatically created and cleaned up. The database is isolated for each test to ensure no interference between tests.

## Mocked Services

- Email sending (fastapi-mail)
- Google Places API calls
- External service configurations

## Current Status

**✅ All 33 tests passing**

The test suite provides comprehensive coverage of all API endpoints and ensures the backend behaves correctly according to the fitness app specifications. 
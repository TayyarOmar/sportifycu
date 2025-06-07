// lib/core/constants/app_constants.dart

class AppConstants {
  // NOTE: Change the hostname/port to wherever your FastAPI server is running.
  // For local development, if your FastAPI is on port 8000, use:
  static const String baseUrl = 'http://localhost:8000/api/v1/auth';

  static const String contentType = 'application/json';
  static const String authorizationHeader = 'Authorization';
}

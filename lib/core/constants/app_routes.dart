// lib/core/constants/app_routes.dart

abstract class AppRoutes {
  static const String splash = '/'; // Added splash route at root
  static const String authOptions = '/auth-options'; // Added AuthOptions route
  static const String signup = '/signup';
  static const String login = '/login';
  static const String verify2FA =
      '/verify'; // deep‐link path: sportify://verify?token=<token>
  static const String resetPassword = '/reset-password';
  static const String confirmReset =
      '/confirm-reset'; // a screen to submit new password
  static const String home = '/home';
  static const String personalizeGenderAge =
      '/personalize-gender-age'; // New route
  static const String personalizeFitnessGoals =
      '/personalize-fitness-goals'; // New route

  // Main App routes
  static const String explore = '/explore';
  static const String gyms = '/gyms';
  static const String scanQR = '/scan-qr';
  static const String profile = '/profile';
  static const String plans = '/plans';
  static const String activityLeaderboard = '/activity-leaderboard';
  static const String groupActivities = '/group-activities';
  static const String createTeam = 'create-team'; // a sub-route
  static const String teamCreatedSuccess =
      'success'; // Nested under groupActivities
  static const String activities = '/activities';
  static const String faq = '/faq';
  static const String qrScanner = 'scanner';
  static const String favoriteFacilities = 'favorite-facilities';
  static const String gymDetails = 'gym-details';
  static const String achievements = '/achievements';

  // Nested routes under Profile
  static const String personalInfo = 'personal-info';
  static const String notifications = 'notifications';
  static const String favorites = 'favorites';
  static const String settings = 'settings';
}

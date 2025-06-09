class User {
  final String userId;
  final String name;
  final String email;
  final String? gender;
  final int? age;
  final List<String> fitnessGoals;
  final bool is2faEnabled;
  final List<dynamic> trackedActivities; // Simplified for now
  final List<String> favourites; // List of gym_ids
  final List<String> achievements;
  final bool notificationSetting;
  final List<String> bookings; // List of team_ids

  User({
    required this.userId,
    required this.name,
    required this.email,
    this.gender,
    this.age,
    required this.fitnessGoals,
    required this.is2faEnabled,
    required this.trackedActivities,
    required this.favourites,
    required this.achievements,
    required this.notificationSetting,
    required this.bookings,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['user_id'],
      name: json['name'],
      email: json['email'],
      gender: json['gender'],
      age: json['age'],
      fitnessGoals: List<String>.from(json['fitness_goals'] ?? []),
      is2faEnabled: json['is_2fa_enabled'],
      trackedActivities: List<dynamic>.from(json['tracked_activities'] ?? []),
      favourites: List<String>.from(json['favourites'] ?? []),
      achievements: List<String>.from(json['achievements'] ?? []),
      notificationSetting: json['notification_setting'],
      bookings: List<String>.from(json['bookings'] ?? []),
    );
  }
}

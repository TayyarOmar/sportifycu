class Gym {
  final String gymId;
  final String name;
  final String location;
  final String? locationUrl;
  final double? tokenPerVisit;
  final List<String> gendersAccepted;
  final List<dynamic> subscriptions; // Simplified for now
  final List<String> services;
  final double? distance; // For nearby gyms

  Gym({
    required this.gymId,
    required this.name,
    required this.location,
    this.locationUrl,
    this.tokenPerVisit,
    required this.gendersAccepted,
    required this.subscriptions,
    required this.services,
    this.distance,
  });

  factory Gym.fromJson(Map<String, dynamic> json) {
    return Gym(
      gymId: json['gym_id'],
      name: json['name'],
      location: json['location'],
      locationUrl: json['location_url'],
      tokenPerVisit: (json['token_per_visit'] as num?)?.toDouble(),
      gendersAccepted: List<String>.from(json['genders_accepted']),
      subscriptions: List<dynamic>.from(json['subscriptions']),
      services: List<String>.from(json['services']),
      distance: (json['distance'] as num?)?.toDouble(),
    );
  }
}

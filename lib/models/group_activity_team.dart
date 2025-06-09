class GroupActivityTeam {
  final String teamId;
  final String listerId;
  final String name;
  final String description;
  final String category;
  final String location;
  final DateTime dateAndTime;
  final String? ageRange;
  final String contactInformation;
  final int playersNeeded;
  final int currentPlayersCount;
  final List<String> playersEnrolled;
  final String status;
  final String? photoUrl; // Changed from photo_base64 to match response

  GroupActivityTeam({
    required this.teamId,
    required this.listerId,
    required this.name,
    required this.description,
    required this.category,
    required this.location,
    required this.dateAndTime,
    this.ageRange,
    required this.contactInformation,
    required this.playersNeeded,
    required this.currentPlayersCount,
    required this.playersEnrolled,
    required this.status,
    this.photoUrl,
  });

  factory GroupActivityTeam.fromJson(Map<String, dynamic> json) {
    return GroupActivityTeam(
      teamId: json['team_id'],
      listerId: json['lister_id'],
      name: json['name'],
      description: json['description'],
      category: json['category'],
      location: json['location'],
      dateAndTime: DateTime.parse(json['date_and_time']),
      ageRange: json['age_range'],
      contactInformation: json['contact_information'],
      playersNeeded: json['players_needed'],
      currentPlayersCount: json['current_players_count'],
      playersEnrolled: List<String>.from(json['players_enrolled']),
      status: json['status'],
      photoUrl: json['photo_url'],
    );
  }
}

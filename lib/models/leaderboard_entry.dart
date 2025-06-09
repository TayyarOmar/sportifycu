class LeaderboardEntry {
  final String userId;
  final String name;
  final String email;
  final double score;

  LeaderboardEntry({
    required this.userId,
    required this.name,
    required this.email,
    required this.score,
  });

  factory LeaderboardEntry.fromJson(Map<String, dynamic> json) {
    return LeaderboardEntry(
      userId: json['user_id'],
      name: json['name'],
      email: json['email'],
      score: (json['score'] as num).toDouble(),
    );
  }
}

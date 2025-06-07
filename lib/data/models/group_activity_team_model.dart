import 'package:freezed_annotation/freezed_annotation.dart';

part 'group_activity_team_model.freezed.dart';
part 'group_activity_team_model.g.dart';

@freezed
class GroupActivityTeam with _$GroupActivityTeam {
  const factory GroupActivityTeam({
    required String team_id,
    required String name,
    required String description,
    required String sport_type,
    required String category,
    required String location,
    required DateTime date_and_time,
    String? age_range,
    required String contact_information,
    required int players_needed,
    required String lister_id,
    required int current_players_count,
    required List<String> players_enrolled,
    required String status,
    String? photo_url,
  }) = _GroupActivityTeam;

  factory GroupActivityTeam.fromJson(Map<String, dynamic> json) =>
      _$GroupActivityTeamFromJson(json);
}

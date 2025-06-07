import 'package:freezed_annotation/freezed_annotation.dart';

part 'team_model.freezed.dart';
part 'team_model.g.dart';

@freezed
class Team with _$Team {
  const factory Team({
    required int id,
    required String name,
    required String sport,
    required String description,
    required String location,
    @JsonKey(name: 'date_time') required String dateTime,
    @JsonKey(name: 'age_range') required String ageRange,
    @JsonKey(name: 'contact_info') required String contactInfo,
    @JsonKey(name: 'players_needed') required String playersNeeded,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'owner_id') required int ownerId,
  }) = _Team;

  factory Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);
}

// Used for creating a new team, so no ID is needed.
@freezed
class TeamCreate with _$TeamCreate {
  const factory TeamCreate({
    required String name,
    required String sport,
    required String description,
    required String location,
    @JsonKey(name: 'date_time') required String dateTime,
    @JsonKey(name: 'age_range') required String ageRange,
    @JsonKey(name: 'contact_info') required String contactInfo,
    @JsonKey(name: 'players_needed') required String playersNeeded,
    @JsonKey(name: 'image_url') String? imageUrl,
  }) = _TeamCreate;

  factory TeamCreate.fromJson(Map<String, dynamic> json) =>
      _$TeamCreateFromJson(json);
}

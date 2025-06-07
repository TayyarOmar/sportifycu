import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class ActivityLog with _$ActivityLog {
  const factory ActivityLog({
    @JsonKey(name: 'activity_type') required String activityType,
    required double value,
    required String unit,
    required DateTime date,
  }) = _ActivityLog;

  factory ActivityLog.fromJson(Map<String, dynamic> json) =>
      _$ActivityLogFromJson(json);
}

@freezed
class User with _$User {
  const factory User({
    @JsonKey(name: 'user_id') required String userId,
    required String name,
    required String email,
    String? gender,
    int? age,
    @JsonKey(name: 'fitness_goals') @Default([]) List<String> fitnessGoals,
    @JsonKey(name: 'is_2fa_enabled') required bool is2faEnabled,
    @JsonKey(name: 'tracked_activities')
    @Default([])
    List<ActivityLog> trackedActivities,
    @Default([]) List<String> favourites,
    @Default([]) List<String> achievements,
    @JsonKey(name: 'notification_setting') required bool notificationSetting,
    @Default([]) List<String> bookings,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

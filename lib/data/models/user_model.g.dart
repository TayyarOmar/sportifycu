// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ActivityLogImpl _$$ActivityLogImplFromJson(Map<String, dynamic> json) =>
    _$ActivityLogImpl(
      activityType: json['activity_type'] as String,
      value: (json['value'] as num).toDouble(),
      unit: json['unit'] as String,
      date: DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$$ActivityLogImplToJson(_$ActivityLogImpl instance) =>
    <String, dynamic>{
      'activity_type': instance.activityType,
      'value': instance.value,
      'unit': instance.unit,
      'date': instance.date.toIso8601String(),
    };

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      userId: json['user_id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      gender: json['gender'] as String?,
      age: (json['age'] as num?)?.toInt(),
      fitnessGoals: (json['fitness_goals'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      is2faEnabled: json['is_2fa_enabled'] as bool,
      trackedActivities: (json['tracked_activities'] as List<dynamic>?)
              ?.map((e) => ActivityLog.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      favourites: (json['favourites'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      achievements: (json['achievements'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      notificationSetting: json['notification_setting'] as bool,
      bookings: (json['bookings'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'name': instance.name,
      'email': instance.email,
      'gender': instance.gender,
      'age': instance.age,
      'fitness_goals': instance.fitnessGoals,
      'is_2fa_enabled': instance.is2faEnabled,
      'tracked_activities': instance.trackedActivities,
      'favourites': instance.favourites,
      'achievements': instance.achievements,
      'notification_setting': instance.notificationSetting,
      'bookings': instance.bookings,
    };

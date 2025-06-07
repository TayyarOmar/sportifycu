// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_activity_team_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GroupActivityTeamImpl _$$GroupActivityTeamImplFromJson(
        Map<String, dynamic> json) =>
    _$GroupActivityTeamImpl(
      team_id: json['team_id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      sport_type: json['sport_type'] as String,
      category: json['category'] as String,
      location: json['location'] as String,
      date_and_time: DateTime.parse(json['date_and_time'] as String),
      age_range: json['age_range'] as String?,
      contact_information: json['contact_information'] as String,
      players_needed: (json['players_needed'] as num).toInt(),
      lister_id: json['lister_id'] as String,
      current_players_count: (json['current_players_count'] as num).toInt(),
      players_enrolled: (json['players_enrolled'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      status: json['status'] as String,
      photo_url: json['photo_url'] as String?,
    );

Map<String, dynamic> _$$GroupActivityTeamImplToJson(
        _$GroupActivityTeamImpl instance) =>
    <String, dynamic>{
      'team_id': instance.team_id,
      'name': instance.name,
      'description': instance.description,
      'sport_type': instance.sport_type,
      'category': instance.category,
      'location': instance.location,
      'date_and_time': instance.date_and_time.toIso8601String(),
      'age_range': instance.age_range,
      'contact_information': instance.contact_information,
      'players_needed': instance.players_needed,
      'lister_id': instance.lister_id,
      'current_players_count': instance.current_players_count,
      'players_enrolled': instance.players_enrolled,
      'status': instance.status,
      'photo_url': instance.photo_url,
    };

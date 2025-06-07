// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TeamImpl _$$TeamImplFromJson(Map<String, dynamic> json) => _$TeamImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      sport: json['sport'] as String,
      description: json['description'] as String,
      location: json['location'] as String,
      dateTime: json['date_time'] as String,
      ageRange: json['age_range'] as String,
      contactInfo: json['contact_info'] as String,
      playersNeeded: json['players_needed'] as String,
      imageUrl: json['image_url'] as String?,
      ownerId: (json['owner_id'] as num).toInt(),
    );

Map<String, dynamic> _$$TeamImplToJson(_$TeamImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'sport': instance.sport,
      'description': instance.description,
      'location': instance.location,
      'date_time': instance.dateTime,
      'age_range': instance.ageRange,
      'contact_info': instance.contactInfo,
      'players_needed': instance.playersNeeded,
      'image_url': instance.imageUrl,
      'owner_id': instance.ownerId,
    };

_$TeamCreateImpl _$$TeamCreateImplFromJson(Map<String, dynamic> json) =>
    _$TeamCreateImpl(
      name: json['name'] as String,
      sport: json['sport'] as String,
      description: json['description'] as String,
      location: json['location'] as String,
      dateTime: json['date_time'] as String,
      ageRange: json['age_range'] as String,
      contactInfo: json['contact_info'] as String,
      playersNeeded: json['players_needed'] as String,
      imageUrl: json['image_url'] as String?,
    );

Map<String, dynamic> _$$TeamCreateImplToJson(_$TeamCreateImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'sport': instance.sport,
      'description': instance.description,
      'location': instance.location,
      'date_time': instance.dateTime,
      'age_range': instance.ageRange,
      'contact_info': instance.contactInfo,
      'players_needed': instance.playersNeeded,
      'image_url': instance.imageUrl,
    };

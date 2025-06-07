// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'team_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Team _$TeamFromJson(Map<String, dynamic> json) {
  return _Team.fromJson(json);
}

/// @nodoc
mixin _$Team {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get sport => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  @JsonKey(name: 'date_time')
  String get dateTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'age_range')
  String get ageRange => throw _privateConstructorUsedError;
  @JsonKey(name: 'contact_info')
  String get contactInfo => throw _privateConstructorUsedError;
  @JsonKey(name: 'players_needed')
  String get playersNeeded => throw _privateConstructorUsedError;
  @JsonKey(name: 'image_url')
  String? get imageUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'owner_id')
  int get ownerId => throw _privateConstructorUsedError;

  /// Serializes this Team to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Team
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TeamCopyWith<Team> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TeamCopyWith<$Res> {
  factory $TeamCopyWith(Team value, $Res Function(Team) then) =
      _$TeamCopyWithImpl<$Res, Team>;
  @useResult
  $Res call(
      {int id,
      String name,
      String sport,
      String description,
      String location,
      @JsonKey(name: 'date_time') String dateTime,
      @JsonKey(name: 'age_range') String ageRange,
      @JsonKey(name: 'contact_info') String contactInfo,
      @JsonKey(name: 'players_needed') String playersNeeded,
      @JsonKey(name: 'image_url') String? imageUrl,
      @JsonKey(name: 'owner_id') int ownerId});
}

/// @nodoc
class _$TeamCopyWithImpl<$Res, $Val extends Team>
    implements $TeamCopyWith<$Res> {
  _$TeamCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Team
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? sport = null,
    Object? description = null,
    Object? location = null,
    Object? dateTime = null,
    Object? ageRange = null,
    Object? contactInfo = null,
    Object? playersNeeded = null,
    Object? imageUrl = freezed,
    Object? ownerId = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      sport: null == sport
          ? _value.sport
          : sport // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      dateTime: null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as String,
      ageRange: null == ageRange
          ? _value.ageRange
          : ageRange // ignore: cast_nullable_to_non_nullable
              as String,
      contactInfo: null == contactInfo
          ? _value.contactInfo
          : contactInfo // ignore: cast_nullable_to_non_nullable
              as String,
      playersNeeded: null == playersNeeded
          ? _value.playersNeeded
          : playersNeeded // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      ownerId: null == ownerId
          ? _value.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TeamImplCopyWith<$Res> implements $TeamCopyWith<$Res> {
  factory _$$TeamImplCopyWith(
          _$TeamImpl value, $Res Function(_$TeamImpl) then) =
      __$$TeamImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String sport,
      String description,
      String location,
      @JsonKey(name: 'date_time') String dateTime,
      @JsonKey(name: 'age_range') String ageRange,
      @JsonKey(name: 'contact_info') String contactInfo,
      @JsonKey(name: 'players_needed') String playersNeeded,
      @JsonKey(name: 'image_url') String? imageUrl,
      @JsonKey(name: 'owner_id') int ownerId});
}

/// @nodoc
class __$$TeamImplCopyWithImpl<$Res>
    extends _$TeamCopyWithImpl<$Res, _$TeamImpl>
    implements _$$TeamImplCopyWith<$Res> {
  __$$TeamImplCopyWithImpl(_$TeamImpl _value, $Res Function(_$TeamImpl) _then)
      : super(_value, _then);

  /// Create a copy of Team
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? sport = null,
    Object? description = null,
    Object? location = null,
    Object? dateTime = null,
    Object? ageRange = null,
    Object? contactInfo = null,
    Object? playersNeeded = null,
    Object? imageUrl = freezed,
    Object? ownerId = null,
  }) {
    return _then(_$TeamImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      sport: null == sport
          ? _value.sport
          : sport // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      dateTime: null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as String,
      ageRange: null == ageRange
          ? _value.ageRange
          : ageRange // ignore: cast_nullable_to_non_nullable
              as String,
      contactInfo: null == contactInfo
          ? _value.contactInfo
          : contactInfo // ignore: cast_nullable_to_non_nullable
              as String,
      playersNeeded: null == playersNeeded
          ? _value.playersNeeded
          : playersNeeded // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      ownerId: null == ownerId
          ? _value.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TeamImpl implements _Team {
  const _$TeamImpl(
      {required this.id,
      required this.name,
      required this.sport,
      required this.description,
      required this.location,
      @JsonKey(name: 'date_time') required this.dateTime,
      @JsonKey(name: 'age_range') required this.ageRange,
      @JsonKey(name: 'contact_info') required this.contactInfo,
      @JsonKey(name: 'players_needed') required this.playersNeeded,
      @JsonKey(name: 'image_url') this.imageUrl,
      @JsonKey(name: 'owner_id') required this.ownerId});

  factory _$TeamImpl.fromJson(Map<String, dynamic> json) =>
      _$$TeamImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String sport;
  @override
  final String description;
  @override
  final String location;
  @override
  @JsonKey(name: 'date_time')
  final String dateTime;
  @override
  @JsonKey(name: 'age_range')
  final String ageRange;
  @override
  @JsonKey(name: 'contact_info')
  final String contactInfo;
  @override
  @JsonKey(name: 'players_needed')
  final String playersNeeded;
  @override
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  @override
  @JsonKey(name: 'owner_id')
  final int ownerId;

  @override
  String toString() {
    return 'Team(id: $id, name: $name, sport: $sport, description: $description, location: $location, dateTime: $dateTime, ageRange: $ageRange, contactInfo: $contactInfo, playersNeeded: $playersNeeded, imageUrl: $imageUrl, ownerId: $ownerId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TeamImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.sport, sport) || other.sport == sport) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.dateTime, dateTime) ||
                other.dateTime == dateTime) &&
            (identical(other.ageRange, ageRange) ||
                other.ageRange == ageRange) &&
            (identical(other.contactInfo, contactInfo) ||
                other.contactInfo == contactInfo) &&
            (identical(other.playersNeeded, playersNeeded) ||
                other.playersNeeded == playersNeeded) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.ownerId, ownerId) || other.ownerId == ownerId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      sport,
      description,
      location,
      dateTime,
      ageRange,
      contactInfo,
      playersNeeded,
      imageUrl,
      ownerId);

  /// Create a copy of Team
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TeamImplCopyWith<_$TeamImpl> get copyWith =>
      __$$TeamImplCopyWithImpl<_$TeamImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TeamImplToJson(
      this,
    );
  }
}

abstract class _Team implements Team {
  const factory _Team(
      {required final int id,
      required final String name,
      required final String sport,
      required final String description,
      required final String location,
      @JsonKey(name: 'date_time') required final String dateTime,
      @JsonKey(name: 'age_range') required final String ageRange,
      @JsonKey(name: 'contact_info') required final String contactInfo,
      @JsonKey(name: 'players_needed') required final String playersNeeded,
      @JsonKey(name: 'image_url') final String? imageUrl,
      @JsonKey(name: 'owner_id') required final int ownerId}) = _$TeamImpl;

  factory _Team.fromJson(Map<String, dynamic> json) = _$TeamImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get sport;
  @override
  String get description;
  @override
  String get location;
  @override
  @JsonKey(name: 'date_time')
  String get dateTime;
  @override
  @JsonKey(name: 'age_range')
  String get ageRange;
  @override
  @JsonKey(name: 'contact_info')
  String get contactInfo;
  @override
  @JsonKey(name: 'players_needed')
  String get playersNeeded;
  @override
  @JsonKey(name: 'image_url')
  String? get imageUrl;
  @override
  @JsonKey(name: 'owner_id')
  int get ownerId;

  /// Create a copy of Team
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TeamImplCopyWith<_$TeamImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TeamCreate _$TeamCreateFromJson(Map<String, dynamic> json) {
  return _TeamCreate.fromJson(json);
}

/// @nodoc
mixin _$TeamCreate {
  String get name => throw _privateConstructorUsedError;
  String get sport => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  @JsonKey(name: 'date_time')
  String get dateTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'age_range')
  String get ageRange => throw _privateConstructorUsedError;
  @JsonKey(name: 'contact_info')
  String get contactInfo => throw _privateConstructorUsedError;
  @JsonKey(name: 'players_needed')
  String get playersNeeded => throw _privateConstructorUsedError;
  @JsonKey(name: 'image_url')
  String? get imageUrl => throw _privateConstructorUsedError;

  /// Serializes this TeamCreate to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TeamCreate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TeamCreateCopyWith<TeamCreate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TeamCreateCopyWith<$Res> {
  factory $TeamCreateCopyWith(
          TeamCreate value, $Res Function(TeamCreate) then) =
      _$TeamCreateCopyWithImpl<$Res, TeamCreate>;
  @useResult
  $Res call(
      {String name,
      String sport,
      String description,
      String location,
      @JsonKey(name: 'date_time') String dateTime,
      @JsonKey(name: 'age_range') String ageRange,
      @JsonKey(name: 'contact_info') String contactInfo,
      @JsonKey(name: 'players_needed') String playersNeeded,
      @JsonKey(name: 'image_url') String? imageUrl});
}

/// @nodoc
class _$TeamCreateCopyWithImpl<$Res, $Val extends TeamCreate>
    implements $TeamCreateCopyWith<$Res> {
  _$TeamCreateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TeamCreate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? sport = null,
    Object? description = null,
    Object? location = null,
    Object? dateTime = null,
    Object? ageRange = null,
    Object? contactInfo = null,
    Object? playersNeeded = null,
    Object? imageUrl = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      sport: null == sport
          ? _value.sport
          : sport // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      dateTime: null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as String,
      ageRange: null == ageRange
          ? _value.ageRange
          : ageRange // ignore: cast_nullable_to_non_nullable
              as String,
      contactInfo: null == contactInfo
          ? _value.contactInfo
          : contactInfo // ignore: cast_nullable_to_non_nullable
              as String,
      playersNeeded: null == playersNeeded
          ? _value.playersNeeded
          : playersNeeded // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TeamCreateImplCopyWith<$Res>
    implements $TeamCreateCopyWith<$Res> {
  factory _$$TeamCreateImplCopyWith(
          _$TeamCreateImpl value, $Res Function(_$TeamCreateImpl) then) =
      __$$TeamCreateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String sport,
      String description,
      String location,
      @JsonKey(name: 'date_time') String dateTime,
      @JsonKey(name: 'age_range') String ageRange,
      @JsonKey(name: 'contact_info') String contactInfo,
      @JsonKey(name: 'players_needed') String playersNeeded,
      @JsonKey(name: 'image_url') String? imageUrl});
}

/// @nodoc
class __$$TeamCreateImplCopyWithImpl<$Res>
    extends _$TeamCreateCopyWithImpl<$Res, _$TeamCreateImpl>
    implements _$$TeamCreateImplCopyWith<$Res> {
  __$$TeamCreateImplCopyWithImpl(
      _$TeamCreateImpl _value, $Res Function(_$TeamCreateImpl) _then)
      : super(_value, _then);

  /// Create a copy of TeamCreate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? sport = null,
    Object? description = null,
    Object? location = null,
    Object? dateTime = null,
    Object? ageRange = null,
    Object? contactInfo = null,
    Object? playersNeeded = null,
    Object? imageUrl = freezed,
  }) {
    return _then(_$TeamCreateImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      sport: null == sport
          ? _value.sport
          : sport // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      dateTime: null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as String,
      ageRange: null == ageRange
          ? _value.ageRange
          : ageRange // ignore: cast_nullable_to_non_nullable
              as String,
      contactInfo: null == contactInfo
          ? _value.contactInfo
          : contactInfo // ignore: cast_nullable_to_non_nullable
              as String,
      playersNeeded: null == playersNeeded
          ? _value.playersNeeded
          : playersNeeded // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TeamCreateImpl implements _TeamCreate {
  const _$TeamCreateImpl(
      {required this.name,
      required this.sport,
      required this.description,
      required this.location,
      @JsonKey(name: 'date_time') required this.dateTime,
      @JsonKey(name: 'age_range') required this.ageRange,
      @JsonKey(name: 'contact_info') required this.contactInfo,
      @JsonKey(name: 'players_needed') required this.playersNeeded,
      @JsonKey(name: 'image_url') this.imageUrl});

  factory _$TeamCreateImpl.fromJson(Map<String, dynamic> json) =>
      _$$TeamCreateImplFromJson(json);

  @override
  final String name;
  @override
  final String sport;
  @override
  final String description;
  @override
  final String location;
  @override
  @JsonKey(name: 'date_time')
  final String dateTime;
  @override
  @JsonKey(name: 'age_range')
  final String ageRange;
  @override
  @JsonKey(name: 'contact_info')
  final String contactInfo;
  @override
  @JsonKey(name: 'players_needed')
  final String playersNeeded;
  @override
  @JsonKey(name: 'image_url')
  final String? imageUrl;

  @override
  String toString() {
    return 'TeamCreate(name: $name, sport: $sport, description: $description, location: $location, dateTime: $dateTime, ageRange: $ageRange, contactInfo: $contactInfo, playersNeeded: $playersNeeded, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TeamCreateImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.sport, sport) || other.sport == sport) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.dateTime, dateTime) ||
                other.dateTime == dateTime) &&
            (identical(other.ageRange, ageRange) ||
                other.ageRange == ageRange) &&
            (identical(other.contactInfo, contactInfo) ||
                other.contactInfo == contactInfo) &&
            (identical(other.playersNeeded, playersNeeded) ||
                other.playersNeeded == playersNeeded) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, sport, description,
      location, dateTime, ageRange, contactInfo, playersNeeded, imageUrl);

  /// Create a copy of TeamCreate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TeamCreateImplCopyWith<_$TeamCreateImpl> get copyWith =>
      __$$TeamCreateImplCopyWithImpl<_$TeamCreateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TeamCreateImplToJson(
      this,
    );
  }
}

abstract class _TeamCreate implements TeamCreate {
  const factory _TeamCreate(
      {required final String name,
      required final String sport,
      required final String description,
      required final String location,
      @JsonKey(name: 'date_time') required final String dateTime,
      @JsonKey(name: 'age_range') required final String ageRange,
      @JsonKey(name: 'contact_info') required final String contactInfo,
      @JsonKey(name: 'players_needed') required final String playersNeeded,
      @JsonKey(name: 'image_url') final String? imageUrl}) = _$TeamCreateImpl;

  factory _TeamCreate.fromJson(Map<String, dynamic> json) =
      _$TeamCreateImpl.fromJson;

  @override
  String get name;
  @override
  String get sport;
  @override
  String get description;
  @override
  String get location;
  @override
  @JsonKey(name: 'date_time')
  String get dateTime;
  @override
  @JsonKey(name: 'age_range')
  String get ageRange;
  @override
  @JsonKey(name: 'contact_info')
  String get contactInfo;
  @override
  @JsonKey(name: 'players_needed')
  String get playersNeeded;
  @override
  @JsonKey(name: 'image_url')
  String? get imageUrl;

  /// Create a copy of TeamCreate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TeamCreateImplCopyWith<_$TeamCreateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_activity_team_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GroupActivityTeam _$GroupActivityTeamFromJson(Map<String, dynamic> json) {
  return _GroupActivityTeam.fromJson(json);
}

/// @nodoc
mixin _$GroupActivityTeam {
  String get team_id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get sport_type => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  DateTime get date_and_time => throw _privateConstructorUsedError;
  String? get age_range => throw _privateConstructorUsedError;
  String get contact_information => throw _privateConstructorUsedError;
  int get players_needed => throw _privateConstructorUsedError;
  String get lister_id => throw _privateConstructorUsedError;
  int get current_players_count => throw _privateConstructorUsedError;
  List<String> get players_enrolled => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get photo_url => throw _privateConstructorUsedError;

  /// Serializes this GroupActivityTeam to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GroupActivityTeam
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GroupActivityTeamCopyWith<GroupActivityTeam> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupActivityTeamCopyWith<$Res> {
  factory $GroupActivityTeamCopyWith(
          GroupActivityTeam value, $Res Function(GroupActivityTeam) then) =
      _$GroupActivityTeamCopyWithImpl<$Res, GroupActivityTeam>;
  @useResult
  $Res call(
      {String team_id,
      String name,
      String description,
      String sport_type,
      String category,
      String location,
      DateTime date_and_time,
      String? age_range,
      String contact_information,
      int players_needed,
      String lister_id,
      int current_players_count,
      List<String> players_enrolled,
      String status,
      String? photo_url});
}

/// @nodoc
class _$GroupActivityTeamCopyWithImpl<$Res, $Val extends GroupActivityTeam>
    implements $GroupActivityTeamCopyWith<$Res> {
  _$GroupActivityTeamCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GroupActivityTeam
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? team_id = null,
    Object? name = null,
    Object? description = null,
    Object? sport_type = null,
    Object? category = null,
    Object? location = null,
    Object? date_and_time = null,
    Object? age_range = freezed,
    Object? contact_information = null,
    Object? players_needed = null,
    Object? lister_id = null,
    Object? current_players_count = null,
    Object? players_enrolled = null,
    Object? status = null,
    Object? photo_url = freezed,
  }) {
    return _then(_value.copyWith(
      team_id: null == team_id
          ? _value.team_id
          : team_id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      sport_type: null == sport_type
          ? _value.sport_type
          : sport_type // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      date_and_time: null == date_and_time
          ? _value.date_and_time
          : date_and_time // ignore: cast_nullable_to_non_nullable
              as DateTime,
      age_range: freezed == age_range
          ? _value.age_range
          : age_range // ignore: cast_nullable_to_non_nullable
              as String?,
      contact_information: null == contact_information
          ? _value.contact_information
          : contact_information // ignore: cast_nullable_to_non_nullable
              as String,
      players_needed: null == players_needed
          ? _value.players_needed
          : players_needed // ignore: cast_nullable_to_non_nullable
              as int,
      lister_id: null == lister_id
          ? _value.lister_id
          : lister_id // ignore: cast_nullable_to_non_nullable
              as String,
      current_players_count: null == current_players_count
          ? _value.current_players_count
          : current_players_count // ignore: cast_nullable_to_non_nullable
              as int,
      players_enrolled: null == players_enrolled
          ? _value.players_enrolled
          : players_enrolled // ignore: cast_nullable_to_non_nullable
              as List<String>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      photo_url: freezed == photo_url
          ? _value.photo_url
          : photo_url // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GroupActivityTeamImplCopyWith<$Res>
    implements $GroupActivityTeamCopyWith<$Res> {
  factory _$$GroupActivityTeamImplCopyWith(_$GroupActivityTeamImpl value,
          $Res Function(_$GroupActivityTeamImpl) then) =
      __$$GroupActivityTeamImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String team_id,
      String name,
      String description,
      String sport_type,
      String category,
      String location,
      DateTime date_and_time,
      String? age_range,
      String contact_information,
      int players_needed,
      String lister_id,
      int current_players_count,
      List<String> players_enrolled,
      String status,
      String? photo_url});
}

/// @nodoc
class __$$GroupActivityTeamImplCopyWithImpl<$Res>
    extends _$GroupActivityTeamCopyWithImpl<$Res, _$GroupActivityTeamImpl>
    implements _$$GroupActivityTeamImplCopyWith<$Res> {
  __$$GroupActivityTeamImplCopyWithImpl(_$GroupActivityTeamImpl _value,
      $Res Function(_$GroupActivityTeamImpl) _then)
      : super(_value, _then);

  /// Create a copy of GroupActivityTeam
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? team_id = null,
    Object? name = null,
    Object? description = null,
    Object? sport_type = null,
    Object? category = null,
    Object? location = null,
    Object? date_and_time = null,
    Object? age_range = freezed,
    Object? contact_information = null,
    Object? players_needed = null,
    Object? lister_id = null,
    Object? current_players_count = null,
    Object? players_enrolled = null,
    Object? status = null,
    Object? photo_url = freezed,
  }) {
    return _then(_$GroupActivityTeamImpl(
      team_id: null == team_id
          ? _value.team_id
          : team_id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      sport_type: null == sport_type
          ? _value.sport_type
          : sport_type // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      date_and_time: null == date_and_time
          ? _value.date_and_time
          : date_and_time // ignore: cast_nullable_to_non_nullable
              as DateTime,
      age_range: freezed == age_range
          ? _value.age_range
          : age_range // ignore: cast_nullable_to_non_nullable
              as String?,
      contact_information: null == contact_information
          ? _value.contact_information
          : contact_information // ignore: cast_nullable_to_non_nullable
              as String,
      players_needed: null == players_needed
          ? _value.players_needed
          : players_needed // ignore: cast_nullable_to_non_nullable
              as int,
      lister_id: null == lister_id
          ? _value.lister_id
          : lister_id // ignore: cast_nullable_to_non_nullable
              as String,
      current_players_count: null == current_players_count
          ? _value.current_players_count
          : current_players_count // ignore: cast_nullable_to_non_nullable
              as int,
      players_enrolled: null == players_enrolled
          ? _value._players_enrolled
          : players_enrolled // ignore: cast_nullable_to_non_nullable
              as List<String>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      photo_url: freezed == photo_url
          ? _value.photo_url
          : photo_url // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GroupActivityTeamImpl implements _GroupActivityTeam {
  const _$GroupActivityTeamImpl(
      {required this.team_id,
      required this.name,
      required this.description,
      required this.sport_type,
      required this.category,
      required this.location,
      required this.date_and_time,
      this.age_range,
      required this.contact_information,
      required this.players_needed,
      required this.lister_id,
      required this.current_players_count,
      required final List<String> players_enrolled,
      required this.status,
      this.photo_url})
      : _players_enrolled = players_enrolled;

  factory _$GroupActivityTeamImpl.fromJson(Map<String, dynamic> json) =>
      _$$GroupActivityTeamImplFromJson(json);

  @override
  final String team_id;
  @override
  final String name;
  @override
  final String description;
  @override
  final String sport_type;
  @override
  final String category;
  @override
  final String location;
  @override
  final DateTime date_and_time;
  @override
  final String? age_range;
  @override
  final String contact_information;
  @override
  final int players_needed;
  @override
  final String lister_id;
  @override
  final int current_players_count;
  final List<String> _players_enrolled;
  @override
  List<String> get players_enrolled {
    if (_players_enrolled is EqualUnmodifiableListView)
      return _players_enrolled;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_players_enrolled);
  }

  @override
  final String status;
  @override
  final String? photo_url;

  @override
  String toString() {
    return 'GroupActivityTeam(team_id: $team_id, name: $name, description: $description, sport_type: $sport_type, category: $category, location: $location, date_and_time: $date_and_time, age_range: $age_range, contact_information: $contact_information, players_needed: $players_needed, lister_id: $lister_id, current_players_count: $current_players_count, players_enrolled: $players_enrolled, status: $status, photo_url: $photo_url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupActivityTeamImpl &&
            (identical(other.team_id, team_id) || other.team_id == team_id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.sport_type, sport_type) ||
                other.sport_type == sport_type) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.date_and_time, date_and_time) ||
                other.date_and_time == date_and_time) &&
            (identical(other.age_range, age_range) ||
                other.age_range == age_range) &&
            (identical(other.contact_information, contact_information) ||
                other.contact_information == contact_information) &&
            (identical(other.players_needed, players_needed) ||
                other.players_needed == players_needed) &&
            (identical(other.lister_id, lister_id) ||
                other.lister_id == lister_id) &&
            (identical(other.current_players_count, current_players_count) ||
                other.current_players_count == current_players_count) &&
            const DeepCollectionEquality()
                .equals(other._players_enrolled, _players_enrolled) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.photo_url, photo_url) ||
                other.photo_url == photo_url));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      team_id,
      name,
      description,
      sport_type,
      category,
      location,
      date_and_time,
      age_range,
      contact_information,
      players_needed,
      lister_id,
      current_players_count,
      const DeepCollectionEquality().hash(_players_enrolled),
      status,
      photo_url);

  /// Create a copy of GroupActivityTeam
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupActivityTeamImplCopyWith<_$GroupActivityTeamImpl> get copyWith =>
      __$$GroupActivityTeamImplCopyWithImpl<_$GroupActivityTeamImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GroupActivityTeamImplToJson(
      this,
    );
  }
}

abstract class _GroupActivityTeam implements GroupActivityTeam {
  const factory _GroupActivityTeam(
      {required final String team_id,
      required final String name,
      required final String description,
      required final String sport_type,
      required final String category,
      required final String location,
      required final DateTime date_and_time,
      final String? age_range,
      required final String contact_information,
      required final int players_needed,
      required final String lister_id,
      required final int current_players_count,
      required final List<String> players_enrolled,
      required final String status,
      final String? photo_url}) = _$GroupActivityTeamImpl;

  factory _GroupActivityTeam.fromJson(Map<String, dynamic> json) =
      _$GroupActivityTeamImpl.fromJson;

  @override
  String get team_id;
  @override
  String get name;
  @override
  String get description;
  @override
  String get sport_type;
  @override
  String get category;
  @override
  String get location;
  @override
  DateTime get date_and_time;
  @override
  String? get age_range;
  @override
  String get contact_information;
  @override
  int get players_needed;
  @override
  String get lister_id;
  @override
  int get current_players_count;
  @override
  List<String> get players_enrolled;
  @override
  String get status;
  @override
  String? get photo_url;

  /// Create a copy of GroupActivityTeam
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GroupActivityTeamImplCopyWith<_$GroupActivityTeamImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

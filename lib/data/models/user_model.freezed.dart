// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ActivityLog _$ActivityLogFromJson(Map<String, dynamic> json) {
  return _ActivityLog.fromJson(json);
}

/// @nodoc
mixin _$ActivityLog {
  @JsonKey(name: 'activity_type')
  String get activityType => throw _privateConstructorUsedError;
  double get value => throw _privateConstructorUsedError;
  String get unit => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;

  /// Serializes this ActivityLog to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ActivityLog
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ActivityLogCopyWith<ActivityLog> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActivityLogCopyWith<$Res> {
  factory $ActivityLogCopyWith(
          ActivityLog value, $Res Function(ActivityLog) then) =
      _$ActivityLogCopyWithImpl<$Res, ActivityLog>;
  @useResult
  $Res call(
      {@JsonKey(name: 'activity_type') String activityType,
      double value,
      String unit,
      DateTime date});
}

/// @nodoc
class _$ActivityLogCopyWithImpl<$Res, $Val extends ActivityLog>
    implements $ActivityLogCopyWith<$Res> {
  _$ActivityLogCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ActivityLog
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activityType = null,
    Object? value = null,
    Object? unit = null,
    Object? date = null,
  }) {
    return _then(_value.copyWith(
      activityType: null == activityType
          ? _value.activityType
          : activityType // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ActivityLogImplCopyWith<$Res>
    implements $ActivityLogCopyWith<$Res> {
  factory _$$ActivityLogImplCopyWith(
          _$ActivityLogImpl value, $Res Function(_$ActivityLogImpl) then) =
      __$$ActivityLogImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'activity_type') String activityType,
      double value,
      String unit,
      DateTime date});
}

/// @nodoc
class __$$ActivityLogImplCopyWithImpl<$Res>
    extends _$ActivityLogCopyWithImpl<$Res, _$ActivityLogImpl>
    implements _$$ActivityLogImplCopyWith<$Res> {
  __$$ActivityLogImplCopyWithImpl(
      _$ActivityLogImpl _value, $Res Function(_$ActivityLogImpl) _then)
      : super(_value, _then);

  /// Create a copy of ActivityLog
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activityType = null,
    Object? value = null,
    Object? unit = null,
    Object? date = null,
  }) {
    return _then(_$ActivityLogImpl(
      activityType: null == activityType
          ? _value.activityType
          : activityType // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ActivityLogImpl implements _ActivityLog {
  const _$ActivityLogImpl(
      {@JsonKey(name: 'activity_type') required this.activityType,
      required this.value,
      required this.unit,
      required this.date});

  factory _$ActivityLogImpl.fromJson(Map<String, dynamic> json) =>
      _$$ActivityLogImplFromJson(json);

  @override
  @JsonKey(name: 'activity_type')
  final String activityType;
  @override
  final double value;
  @override
  final String unit;
  @override
  final DateTime date;

  @override
  String toString() {
    return 'ActivityLog(activityType: $activityType, value: $value, unit: $unit, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActivityLogImpl &&
            (identical(other.activityType, activityType) ||
                other.activityType == activityType) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.date, date) || other.date == date));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, activityType, value, unit, date);

  /// Create a copy of ActivityLog
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ActivityLogImplCopyWith<_$ActivityLogImpl> get copyWith =>
      __$$ActivityLogImplCopyWithImpl<_$ActivityLogImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ActivityLogImplToJson(
      this,
    );
  }
}

abstract class _ActivityLog implements ActivityLog {
  const factory _ActivityLog(
      {@JsonKey(name: 'activity_type') required final String activityType,
      required final double value,
      required final String unit,
      required final DateTime date}) = _$ActivityLogImpl;

  factory _ActivityLog.fromJson(Map<String, dynamic> json) =
      _$ActivityLogImpl.fromJson;

  @override
  @JsonKey(name: 'activity_type')
  String get activityType;
  @override
  double get value;
  @override
  String get unit;
  @override
  DateTime get date;

  /// Create a copy of ActivityLog
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ActivityLogImplCopyWith<_$ActivityLogImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
mixin _$User {
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String? get gender => throw _privateConstructorUsedError;
  int? get age => throw _privateConstructorUsedError;
  @JsonKey(name: 'fitness_goals')
  List<String> get fitnessGoals => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_2fa_enabled')
  bool get is2faEnabled => throw _privateConstructorUsedError;
  @JsonKey(name: 'tracked_activities')
  List<ActivityLog> get trackedActivities => throw _privateConstructorUsedError;
  List<String> get favourites => throw _privateConstructorUsedError;
  List<String> get achievements => throw _privateConstructorUsedError;
  @JsonKey(name: 'notification_setting')
  bool get notificationSetting => throw _privateConstructorUsedError;
  List<String> get bookings => throw _privateConstructorUsedError;

  /// Serializes this User to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call(
      {@JsonKey(name: 'user_id') String userId,
      String name,
      String email,
      String? gender,
      int? age,
      @JsonKey(name: 'fitness_goals') List<String> fitnessGoals,
      @JsonKey(name: 'is_2fa_enabled') bool is2faEnabled,
      @JsonKey(name: 'tracked_activities') List<ActivityLog> trackedActivities,
      List<String> favourites,
      List<String> achievements,
      @JsonKey(name: 'notification_setting') bool notificationSetting,
      List<String> bookings});
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? name = null,
    Object? email = null,
    Object? gender = freezed,
    Object? age = freezed,
    Object? fitnessGoals = null,
    Object? is2faEnabled = null,
    Object? trackedActivities = null,
    Object? favourites = null,
    Object? achievements = null,
    Object? notificationSetting = null,
    Object? bookings = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      age: freezed == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int?,
      fitnessGoals: null == fitnessGoals
          ? _value.fitnessGoals
          : fitnessGoals // ignore: cast_nullable_to_non_nullable
              as List<String>,
      is2faEnabled: null == is2faEnabled
          ? _value.is2faEnabled
          : is2faEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      trackedActivities: null == trackedActivities
          ? _value.trackedActivities
          : trackedActivities // ignore: cast_nullable_to_non_nullable
              as List<ActivityLog>,
      favourites: null == favourites
          ? _value.favourites
          : favourites // ignore: cast_nullable_to_non_nullable
              as List<String>,
      achievements: null == achievements
          ? _value.achievements
          : achievements // ignore: cast_nullable_to_non_nullable
              as List<String>,
      notificationSetting: null == notificationSetting
          ? _value.notificationSetting
          : notificationSetting // ignore: cast_nullable_to_non_nullable
              as bool,
      bookings: null == bookings
          ? _value.bookings
          : bookings // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserImplCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$UserImplCopyWith(
          _$UserImpl value, $Res Function(_$UserImpl) then) =
      __$$UserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'user_id') String userId,
      String name,
      String email,
      String? gender,
      int? age,
      @JsonKey(name: 'fitness_goals') List<String> fitnessGoals,
      @JsonKey(name: 'is_2fa_enabled') bool is2faEnabled,
      @JsonKey(name: 'tracked_activities') List<ActivityLog> trackedActivities,
      List<String> favourites,
      List<String> achievements,
      @JsonKey(name: 'notification_setting') bool notificationSetting,
      List<String> bookings});
}

/// @nodoc
class __$$UserImplCopyWithImpl<$Res>
    extends _$UserCopyWithImpl<$Res, _$UserImpl>
    implements _$$UserImplCopyWith<$Res> {
  __$$UserImplCopyWithImpl(_$UserImpl _value, $Res Function(_$UserImpl) _then)
      : super(_value, _then);

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? name = null,
    Object? email = null,
    Object? gender = freezed,
    Object? age = freezed,
    Object? fitnessGoals = null,
    Object? is2faEnabled = null,
    Object? trackedActivities = null,
    Object? favourites = null,
    Object? achievements = null,
    Object? notificationSetting = null,
    Object? bookings = null,
  }) {
    return _then(_$UserImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      age: freezed == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int?,
      fitnessGoals: null == fitnessGoals
          ? _value._fitnessGoals
          : fitnessGoals // ignore: cast_nullable_to_non_nullable
              as List<String>,
      is2faEnabled: null == is2faEnabled
          ? _value.is2faEnabled
          : is2faEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      trackedActivities: null == trackedActivities
          ? _value._trackedActivities
          : trackedActivities // ignore: cast_nullable_to_non_nullable
              as List<ActivityLog>,
      favourites: null == favourites
          ? _value._favourites
          : favourites // ignore: cast_nullable_to_non_nullable
              as List<String>,
      achievements: null == achievements
          ? _value._achievements
          : achievements // ignore: cast_nullable_to_non_nullable
              as List<String>,
      notificationSetting: null == notificationSetting
          ? _value.notificationSetting
          : notificationSetting // ignore: cast_nullable_to_non_nullable
              as bool,
      bookings: null == bookings
          ? _value._bookings
          : bookings // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserImpl implements _User {
  const _$UserImpl(
      {@JsonKey(name: 'user_id') required this.userId,
      required this.name,
      required this.email,
      this.gender,
      this.age,
      @JsonKey(name: 'fitness_goals')
      final List<String> fitnessGoals = const [],
      @JsonKey(name: 'is_2fa_enabled') required this.is2faEnabled,
      @JsonKey(name: 'tracked_activities')
      final List<ActivityLog> trackedActivities = const [],
      final List<String> favourites = const [],
      final List<String> achievements = const [],
      @JsonKey(name: 'notification_setting') required this.notificationSetting,
      final List<String> bookings = const []})
      : _fitnessGoals = fitnessGoals,
        _trackedActivities = trackedActivities,
        _favourites = favourites,
        _achievements = achievements,
        _bookings = bookings;

  factory _$UserImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserImplFromJson(json);

  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  final String name;
  @override
  final String email;
  @override
  final String? gender;
  @override
  final int? age;
  final List<String> _fitnessGoals;
  @override
  @JsonKey(name: 'fitness_goals')
  List<String> get fitnessGoals {
    if (_fitnessGoals is EqualUnmodifiableListView) return _fitnessGoals;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_fitnessGoals);
  }

  @override
  @JsonKey(name: 'is_2fa_enabled')
  final bool is2faEnabled;
  final List<ActivityLog> _trackedActivities;
  @override
  @JsonKey(name: 'tracked_activities')
  List<ActivityLog> get trackedActivities {
    if (_trackedActivities is EqualUnmodifiableListView)
      return _trackedActivities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_trackedActivities);
  }

  final List<String> _favourites;
  @override
  @JsonKey()
  List<String> get favourites {
    if (_favourites is EqualUnmodifiableListView) return _favourites;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_favourites);
  }

  final List<String> _achievements;
  @override
  @JsonKey()
  List<String> get achievements {
    if (_achievements is EqualUnmodifiableListView) return _achievements;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_achievements);
  }

  @override
  @JsonKey(name: 'notification_setting')
  final bool notificationSetting;
  final List<String> _bookings;
  @override
  @JsonKey()
  List<String> get bookings {
    if (_bookings is EqualUnmodifiableListView) return _bookings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_bookings);
  }

  @override
  String toString() {
    return 'User(userId: $userId, name: $name, email: $email, gender: $gender, age: $age, fitnessGoals: $fitnessGoals, is2faEnabled: $is2faEnabled, trackedActivities: $trackedActivities, favourites: $favourites, achievements: $achievements, notificationSetting: $notificationSetting, bookings: $bookings)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.age, age) || other.age == age) &&
            const DeepCollectionEquality()
                .equals(other._fitnessGoals, _fitnessGoals) &&
            (identical(other.is2faEnabled, is2faEnabled) ||
                other.is2faEnabled == is2faEnabled) &&
            const DeepCollectionEquality()
                .equals(other._trackedActivities, _trackedActivities) &&
            const DeepCollectionEquality()
                .equals(other._favourites, _favourites) &&
            const DeepCollectionEquality()
                .equals(other._achievements, _achievements) &&
            (identical(other.notificationSetting, notificationSetting) ||
                other.notificationSetting == notificationSetting) &&
            const DeepCollectionEquality().equals(other._bookings, _bookings));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      userId,
      name,
      email,
      gender,
      age,
      const DeepCollectionEquality().hash(_fitnessGoals),
      is2faEnabled,
      const DeepCollectionEquality().hash(_trackedActivities),
      const DeepCollectionEquality().hash(_favourites),
      const DeepCollectionEquality().hash(_achievements),
      notificationSetting,
      const DeepCollectionEquality().hash(_bookings));

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      __$$UserImplCopyWithImpl<_$UserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserImplToJson(
      this,
    );
  }
}

abstract class _User implements User {
  const factory _User(
      {@JsonKey(name: 'user_id') required final String userId,
      required final String name,
      required final String email,
      final String? gender,
      final int? age,
      @JsonKey(name: 'fitness_goals') final List<String> fitnessGoals,
      @JsonKey(name: 'is_2fa_enabled') required final bool is2faEnabled,
      @JsonKey(name: 'tracked_activities')
      final List<ActivityLog> trackedActivities,
      final List<String> favourites,
      final List<String> achievements,
      @JsonKey(name: 'notification_setting')
      required final bool notificationSetting,
      final List<String> bookings}) = _$UserImpl;

  factory _User.fromJson(Map<String, dynamic> json) = _$UserImpl.fromJson;

  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  String get name;
  @override
  String get email;
  @override
  String? get gender;
  @override
  int? get age;
  @override
  @JsonKey(name: 'fitness_goals')
  List<String> get fitnessGoals;
  @override
  @JsonKey(name: 'is_2fa_enabled')
  bool get is2faEnabled;
  @override
  @JsonKey(name: 'tracked_activities')
  List<ActivityLog> get trackedActivities;
  @override
  List<String> get favourites;
  @override
  List<String> get achievements;
  @override
  @JsonKey(name: 'notification_setting')
  bool get notificationSetting;
  @override
  List<String> get bookings;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

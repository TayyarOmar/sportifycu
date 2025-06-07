// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'signup_data_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SignUpData {
  String? get name => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get password => throw _privateConstructorUsedError;
  String? get gender => throw _privateConstructorUsedError;
  int? get age => throw _privateConstructorUsedError;
  List<String>? get fitnessGoals => throw _privateConstructorUsedError;

  /// Create a copy of SignUpData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SignUpDataCopyWith<SignUpData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignUpDataCopyWith<$Res> {
  factory $SignUpDataCopyWith(
          SignUpData value, $Res Function(SignUpData) then) =
      _$SignUpDataCopyWithImpl<$Res, SignUpData>;
  @useResult
  $Res call(
      {String? name,
      String? email,
      String? password,
      String? gender,
      int? age,
      List<String>? fitnessGoals});
}

/// @nodoc
class _$SignUpDataCopyWithImpl<$Res, $Val extends SignUpData>
    implements $SignUpDataCopyWith<$Res> {
  _$SignUpDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SignUpData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? email = freezed,
    Object? password = freezed,
    Object? gender = freezed,
    Object? age = freezed,
    Object? fitnessGoals = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      age: freezed == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int?,
      fitnessGoals: freezed == fitnessGoals
          ? _value.fitnessGoals
          : fitnessGoals // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SignUpDataImplCopyWith<$Res>
    implements $SignUpDataCopyWith<$Res> {
  factory _$$SignUpDataImplCopyWith(
          _$SignUpDataImpl value, $Res Function(_$SignUpDataImpl) then) =
      __$$SignUpDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? name,
      String? email,
      String? password,
      String? gender,
      int? age,
      List<String>? fitnessGoals});
}

/// @nodoc
class __$$SignUpDataImplCopyWithImpl<$Res>
    extends _$SignUpDataCopyWithImpl<$Res, _$SignUpDataImpl>
    implements _$$SignUpDataImplCopyWith<$Res> {
  __$$SignUpDataImplCopyWithImpl(
      _$SignUpDataImpl _value, $Res Function(_$SignUpDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of SignUpData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? email = freezed,
    Object? password = freezed,
    Object? gender = freezed,
    Object? age = freezed,
    Object? fitnessGoals = freezed,
  }) {
    return _then(_$SignUpDataImpl(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      age: freezed == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int?,
      fitnessGoals: freezed == fitnessGoals
          ? _value._fitnessGoals
          : fitnessGoals // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc

class _$SignUpDataImpl implements _SignUpData {
  const _$SignUpDataImpl(
      {this.name,
      this.email,
      this.password,
      this.gender,
      this.age,
      final List<String>? fitnessGoals})
      : _fitnessGoals = fitnessGoals;

  @override
  final String? name;
  @override
  final String? email;
  @override
  final String? password;
  @override
  final String? gender;
  @override
  final int? age;
  final List<String>? _fitnessGoals;
  @override
  List<String>? get fitnessGoals {
    final value = _fitnessGoals;
    if (value == null) return null;
    if (_fitnessGoals is EqualUnmodifiableListView) return _fitnessGoals;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'SignUpData(name: $name, email: $email, password: $password, gender: $gender, age: $age, fitnessGoals: $fitnessGoals)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignUpDataImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.age, age) || other.age == age) &&
            const DeepCollectionEquality()
                .equals(other._fitnessGoals, _fitnessGoals));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, email, password, gender,
      age, const DeepCollectionEquality().hash(_fitnessGoals));

  /// Create a copy of SignUpData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SignUpDataImplCopyWith<_$SignUpDataImpl> get copyWith =>
      __$$SignUpDataImplCopyWithImpl<_$SignUpDataImpl>(this, _$identity);
}

abstract class _SignUpData implements SignUpData {
  const factory _SignUpData(
      {final String? name,
      final String? email,
      final String? password,
      final String? gender,
      final int? age,
      final List<String>? fitnessGoals}) = _$SignUpDataImpl;

  @override
  String? get name;
  @override
  String? get email;
  @override
  String? get password;
  @override
  String? get gender;
  @override
  int? get age;
  @override
  List<String>? get fitnessGoals;

  /// Create a copy of SignUpData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SignUpDataImplCopyWith<_$SignUpDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

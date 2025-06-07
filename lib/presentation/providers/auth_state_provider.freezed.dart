// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_state_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AuthState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(TokenResponse token) authenticated,
    required TResult Function(String? message) unauthenticated,
    required TResult Function(String email, String message) requires2FACode,
    required TResult Function(User user) signupSucceeded,
    required TResult Function(String email, String message)
        passwordResetCodeSent,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(TokenResponse token)? authenticated,
    TResult? Function(String? message)? unauthenticated,
    TResult? Function(String email, String message)? requires2FACode,
    TResult? Function(User user)? signupSucceeded,
    TResult? Function(String email, String message)? passwordResetCodeSent,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(TokenResponse token)? authenticated,
    TResult Function(String? message)? unauthenticated,
    TResult Function(String email, String message)? requires2FACode,
    TResult Function(User user)? signupSucceeded,
    TResult Function(String email, String message)? passwordResetCodeSent,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_Unauthenticated value) unauthenticated,
    required TResult Function(_Requires2FACode value) requires2FACode,
    required TResult Function(_SignupSucceeded value) signupSucceeded,
    required TResult Function(_PasswordResetCodeSent value)
        passwordResetCodeSent,
    required TResult Function(_Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_Unauthenticated value)? unauthenticated,
    TResult? Function(_Requires2FACode value)? requires2FACode,
    TResult? Function(_SignupSucceeded value)? signupSucceeded,
    TResult? Function(_PasswordResetCodeSent value)? passwordResetCodeSent,
    TResult? Function(_Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_Unauthenticated value)? unauthenticated,
    TResult Function(_Requires2FACode value)? requires2FACode,
    TResult Function(_SignupSucceeded value)? signupSucceeded,
    TResult Function(_PasswordResetCodeSent value)? passwordResetCodeSent,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) then) =
      _$AuthStateCopyWithImpl<$Res, AuthState>;
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res, $Val extends AuthState>
    implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'AuthState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(TokenResponse token) authenticated,
    required TResult Function(String? message) unauthenticated,
    required TResult Function(String email, String message) requires2FACode,
    required TResult Function(User user) signupSucceeded,
    required TResult Function(String email, String message)
        passwordResetCodeSent,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(TokenResponse token)? authenticated,
    TResult? Function(String? message)? unauthenticated,
    TResult? Function(String email, String message)? requires2FACode,
    TResult? Function(User user)? signupSucceeded,
    TResult? Function(String email, String message)? passwordResetCodeSent,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(TokenResponse token)? authenticated,
    TResult Function(String? message)? unauthenticated,
    TResult Function(String email, String message)? requires2FACode,
    TResult Function(User user)? signupSucceeded,
    TResult Function(String email, String message)? passwordResetCodeSent,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_Unauthenticated value) unauthenticated,
    required TResult Function(_Requires2FACode value) requires2FACode,
    required TResult Function(_SignupSucceeded value) signupSucceeded,
    required TResult Function(_PasswordResetCodeSent value)
        passwordResetCodeSent,
    required TResult Function(_Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_Unauthenticated value)? unauthenticated,
    TResult? Function(_Requires2FACode value)? requires2FACode,
    TResult? Function(_SignupSucceeded value)? signupSucceeded,
    TResult? Function(_PasswordResetCodeSent value)? passwordResetCodeSent,
    TResult? Function(_Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_Unauthenticated value)? unauthenticated,
    TResult Function(_Requires2FACode value)? requires2FACode,
    TResult Function(_SignupSucceeded value)? signupSucceeded,
    TResult Function(_PasswordResetCodeSent value)? passwordResetCodeSent,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements AuthState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'AuthState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(TokenResponse token) authenticated,
    required TResult Function(String? message) unauthenticated,
    required TResult Function(String email, String message) requires2FACode,
    required TResult Function(User user) signupSucceeded,
    required TResult Function(String email, String message)
        passwordResetCodeSent,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(TokenResponse token)? authenticated,
    TResult? Function(String? message)? unauthenticated,
    TResult? Function(String email, String message)? requires2FACode,
    TResult? Function(User user)? signupSucceeded,
    TResult? Function(String email, String message)? passwordResetCodeSent,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(TokenResponse token)? authenticated,
    TResult Function(String? message)? unauthenticated,
    TResult Function(String email, String message)? requires2FACode,
    TResult Function(User user)? signupSucceeded,
    TResult Function(String email, String message)? passwordResetCodeSent,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_Unauthenticated value) unauthenticated,
    required TResult Function(_Requires2FACode value) requires2FACode,
    required TResult Function(_SignupSucceeded value) signupSucceeded,
    required TResult Function(_PasswordResetCodeSent value)
        passwordResetCodeSent,
    required TResult Function(_Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_Unauthenticated value)? unauthenticated,
    TResult? Function(_Requires2FACode value)? requires2FACode,
    TResult? Function(_SignupSucceeded value)? signupSucceeded,
    TResult? Function(_PasswordResetCodeSent value)? passwordResetCodeSent,
    TResult? Function(_Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_Unauthenticated value)? unauthenticated,
    TResult Function(_Requires2FACode value)? requires2FACode,
    TResult Function(_SignupSucceeded value)? signupSucceeded,
    TResult Function(_PasswordResetCodeSent value)? passwordResetCodeSent,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements AuthState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$AuthenticatedImplCopyWith<$Res> {
  factory _$$AuthenticatedImplCopyWith(
          _$AuthenticatedImpl value, $Res Function(_$AuthenticatedImpl) then) =
      __$$AuthenticatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({TokenResponse token});

  $TokenResponseCopyWith<$Res> get token;
}

/// @nodoc
class __$$AuthenticatedImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthenticatedImpl>
    implements _$$AuthenticatedImplCopyWith<$Res> {
  __$$AuthenticatedImplCopyWithImpl(
      _$AuthenticatedImpl _value, $Res Function(_$AuthenticatedImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
  }) {
    return _then(_$AuthenticatedImpl(
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as TokenResponse,
    ));
  }

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TokenResponseCopyWith<$Res> get token {
    return $TokenResponseCopyWith<$Res>(_value.token, (value) {
      return _then(_value.copyWith(token: value));
    });
  }
}

/// @nodoc

class _$AuthenticatedImpl implements _Authenticated {
  const _$AuthenticatedImpl({required this.token});

  @override
  final TokenResponse token;

  @override
  String toString() {
    return 'AuthState.authenticated(token: $token)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticatedImpl &&
            (identical(other.token, token) || other.token == token));
  }

  @override
  int get hashCode => Object.hash(runtimeType, token);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthenticatedImplCopyWith<_$AuthenticatedImpl> get copyWith =>
      __$$AuthenticatedImplCopyWithImpl<_$AuthenticatedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(TokenResponse token) authenticated,
    required TResult Function(String? message) unauthenticated,
    required TResult Function(String email, String message) requires2FACode,
    required TResult Function(User user) signupSucceeded,
    required TResult Function(String email, String message)
        passwordResetCodeSent,
    required TResult Function(String message) error,
  }) {
    return authenticated(token);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(TokenResponse token)? authenticated,
    TResult? Function(String? message)? unauthenticated,
    TResult? Function(String email, String message)? requires2FACode,
    TResult? Function(User user)? signupSucceeded,
    TResult? Function(String email, String message)? passwordResetCodeSent,
    TResult? Function(String message)? error,
  }) {
    return authenticated?.call(token);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(TokenResponse token)? authenticated,
    TResult Function(String? message)? unauthenticated,
    TResult Function(String email, String message)? requires2FACode,
    TResult Function(User user)? signupSucceeded,
    TResult Function(String email, String message)? passwordResetCodeSent,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(token);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_Unauthenticated value) unauthenticated,
    required TResult Function(_Requires2FACode value) requires2FACode,
    required TResult Function(_SignupSucceeded value) signupSucceeded,
    required TResult Function(_PasswordResetCodeSent value)
        passwordResetCodeSent,
    required TResult Function(_Error value) error,
  }) {
    return authenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_Unauthenticated value)? unauthenticated,
    TResult? Function(_Requires2FACode value)? requires2FACode,
    TResult? Function(_SignupSucceeded value)? signupSucceeded,
    TResult? Function(_PasswordResetCodeSent value)? passwordResetCodeSent,
    TResult? Function(_Error value)? error,
  }) {
    return authenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_Unauthenticated value)? unauthenticated,
    TResult Function(_Requires2FACode value)? requires2FACode,
    TResult Function(_SignupSucceeded value)? signupSucceeded,
    TResult Function(_PasswordResetCodeSent value)? passwordResetCodeSent,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(this);
    }
    return orElse();
  }
}

abstract class _Authenticated implements AuthState {
  const factory _Authenticated({required final TokenResponse token}) =
      _$AuthenticatedImpl;

  TokenResponse get token;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthenticatedImplCopyWith<_$AuthenticatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnauthenticatedImplCopyWith<$Res> {
  factory _$$UnauthenticatedImplCopyWith(_$UnauthenticatedImpl value,
          $Res Function(_$UnauthenticatedImpl) then) =
      __$$UnauthenticatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$UnauthenticatedImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$UnauthenticatedImpl>
    implements _$$UnauthenticatedImplCopyWith<$Res> {
  __$$UnauthenticatedImplCopyWithImpl(
      _$UnauthenticatedImpl _value, $Res Function(_$UnauthenticatedImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_$UnauthenticatedImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$UnauthenticatedImpl implements _Unauthenticated {
  const _$UnauthenticatedImpl({this.message});

  @override
  final String? message;

  @override
  String toString() {
    return 'AuthState.unauthenticated(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnauthenticatedImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UnauthenticatedImplCopyWith<_$UnauthenticatedImpl> get copyWith =>
      __$$UnauthenticatedImplCopyWithImpl<_$UnauthenticatedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(TokenResponse token) authenticated,
    required TResult Function(String? message) unauthenticated,
    required TResult Function(String email, String message) requires2FACode,
    required TResult Function(User user) signupSucceeded,
    required TResult Function(String email, String message)
        passwordResetCodeSent,
    required TResult Function(String message) error,
  }) {
    return unauthenticated(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(TokenResponse token)? authenticated,
    TResult? Function(String? message)? unauthenticated,
    TResult? Function(String email, String message)? requires2FACode,
    TResult? Function(User user)? signupSucceeded,
    TResult? Function(String email, String message)? passwordResetCodeSent,
    TResult? Function(String message)? error,
  }) {
    return unauthenticated?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(TokenResponse token)? authenticated,
    TResult Function(String? message)? unauthenticated,
    TResult Function(String email, String message)? requires2FACode,
    TResult Function(User user)? signupSucceeded,
    TResult Function(String email, String message)? passwordResetCodeSent,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (unauthenticated != null) {
      return unauthenticated(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_Unauthenticated value) unauthenticated,
    required TResult Function(_Requires2FACode value) requires2FACode,
    required TResult Function(_SignupSucceeded value) signupSucceeded,
    required TResult Function(_PasswordResetCodeSent value)
        passwordResetCodeSent,
    required TResult Function(_Error value) error,
  }) {
    return unauthenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_Unauthenticated value)? unauthenticated,
    TResult? Function(_Requires2FACode value)? requires2FACode,
    TResult? Function(_SignupSucceeded value)? signupSucceeded,
    TResult? Function(_PasswordResetCodeSent value)? passwordResetCodeSent,
    TResult? Function(_Error value)? error,
  }) {
    return unauthenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_Unauthenticated value)? unauthenticated,
    TResult Function(_Requires2FACode value)? requires2FACode,
    TResult Function(_SignupSucceeded value)? signupSucceeded,
    TResult Function(_PasswordResetCodeSent value)? passwordResetCodeSent,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (unauthenticated != null) {
      return unauthenticated(this);
    }
    return orElse();
  }
}

abstract class _Unauthenticated implements AuthState {
  const factory _Unauthenticated({final String? message}) =
      _$UnauthenticatedImpl;

  String? get message;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UnauthenticatedImplCopyWith<_$UnauthenticatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$Requires2FACodeImplCopyWith<$Res> {
  factory _$$Requires2FACodeImplCopyWith(_$Requires2FACodeImpl value,
          $Res Function(_$Requires2FACodeImpl) then) =
      __$$Requires2FACodeImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String email, String message});
}

/// @nodoc
class __$$Requires2FACodeImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$Requires2FACodeImpl>
    implements _$$Requires2FACodeImplCopyWith<$Res> {
  __$$Requires2FACodeImplCopyWithImpl(
      _$Requires2FACodeImpl _value, $Res Function(_$Requires2FACodeImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? message = null,
  }) {
    return _then(_$Requires2FACodeImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$Requires2FACodeImpl implements _Requires2FACode {
  const _$Requires2FACodeImpl({required this.email, required this.message});

  @override
  final String email;
  @override
  final String message;

  @override
  String toString() {
    return 'AuthState.requires2FACode(email: $email, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Requires2FACodeImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email, message);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$Requires2FACodeImplCopyWith<_$Requires2FACodeImpl> get copyWith =>
      __$$Requires2FACodeImplCopyWithImpl<_$Requires2FACodeImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(TokenResponse token) authenticated,
    required TResult Function(String? message) unauthenticated,
    required TResult Function(String email, String message) requires2FACode,
    required TResult Function(User user) signupSucceeded,
    required TResult Function(String email, String message)
        passwordResetCodeSent,
    required TResult Function(String message) error,
  }) {
    return requires2FACode(email, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(TokenResponse token)? authenticated,
    TResult? Function(String? message)? unauthenticated,
    TResult? Function(String email, String message)? requires2FACode,
    TResult? Function(User user)? signupSucceeded,
    TResult? Function(String email, String message)? passwordResetCodeSent,
    TResult? Function(String message)? error,
  }) {
    return requires2FACode?.call(email, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(TokenResponse token)? authenticated,
    TResult Function(String? message)? unauthenticated,
    TResult Function(String email, String message)? requires2FACode,
    TResult Function(User user)? signupSucceeded,
    TResult Function(String email, String message)? passwordResetCodeSent,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (requires2FACode != null) {
      return requires2FACode(email, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_Unauthenticated value) unauthenticated,
    required TResult Function(_Requires2FACode value) requires2FACode,
    required TResult Function(_SignupSucceeded value) signupSucceeded,
    required TResult Function(_PasswordResetCodeSent value)
        passwordResetCodeSent,
    required TResult Function(_Error value) error,
  }) {
    return requires2FACode(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_Unauthenticated value)? unauthenticated,
    TResult? Function(_Requires2FACode value)? requires2FACode,
    TResult? Function(_SignupSucceeded value)? signupSucceeded,
    TResult? Function(_PasswordResetCodeSent value)? passwordResetCodeSent,
    TResult? Function(_Error value)? error,
  }) {
    return requires2FACode?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_Unauthenticated value)? unauthenticated,
    TResult Function(_Requires2FACode value)? requires2FACode,
    TResult Function(_SignupSucceeded value)? signupSucceeded,
    TResult Function(_PasswordResetCodeSent value)? passwordResetCodeSent,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (requires2FACode != null) {
      return requires2FACode(this);
    }
    return orElse();
  }
}

abstract class _Requires2FACode implements AuthState {
  const factory _Requires2FACode(
      {required final String email,
      required final String message}) = _$Requires2FACodeImpl;

  String get email;
  String get message;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$Requires2FACodeImplCopyWith<_$Requires2FACodeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SignupSucceededImplCopyWith<$Res> {
  factory _$$SignupSucceededImplCopyWith(_$SignupSucceededImpl value,
          $Res Function(_$SignupSucceededImpl) then) =
      __$$SignupSucceededImplCopyWithImpl<$Res>;
  @useResult
  $Res call({User user});

  $UserCopyWith<$Res> get user;
}

/// @nodoc
class __$$SignupSucceededImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$SignupSucceededImpl>
    implements _$$SignupSucceededImplCopyWith<$Res> {
  __$$SignupSucceededImplCopyWithImpl(
      _$SignupSucceededImpl _value, $Res Function(_$SignupSucceededImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
  }) {
    return _then(_$SignupSucceededImpl(
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
    ));
  }

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res> get user {
    return $UserCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value));
    });
  }
}

/// @nodoc

class _$SignupSucceededImpl implements _SignupSucceeded {
  const _$SignupSucceededImpl({required this.user});

  @override
  final User user;

  @override
  String toString() {
    return 'AuthState.signupSucceeded(user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignupSucceededImpl &&
            (identical(other.user, user) || other.user == user));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SignupSucceededImplCopyWith<_$SignupSucceededImpl> get copyWith =>
      __$$SignupSucceededImplCopyWithImpl<_$SignupSucceededImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(TokenResponse token) authenticated,
    required TResult Function(String? message) unauthenticated,
    required TResult Function(String email, String message) requires2FACode,
    required TResult Function(User user) signupSucceeded,
    required TResult Function(String email, String message)
        passwordResetCodeSent,
    required TResult Function(String message) error,
  }) {
    return signupSucceeded(user);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(TokenResponse token)? authenticated,
    TResult? Function(String? message)? unauthenticated,
    TResult? Function(String email, String message)? requires2FACode,
    TResult? Function(User user)? signupSucceeded,
    TResult? Function(String email, String message)? passwordResetCodeSent,
    TResult? Function(String message)? error,
  }) {
    return signupSucceeded?.call(user);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(TokenResponse token)? authenticated,
    TResult Function(String? message)? unauthenticated,
    TResult Function(String email, String message)? requires2FACode,
    TResult Function(User user)? signupSucceeded,
    TResult Function(String email, String message)? passwordResetCodeSent,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (signupSucceeded != null) {
      return signupSucceeded(user);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_Unauthenticated value) unauthenticated,
    required TResult Function(_Requires2FACode value) requires2FACode,
    required TResult Function(_SignupSucceeded value) signupSucceeded,
    required TResult Function(_PasswordResetCodeSent value)
        passwordResetCodeSent,
    required TResult Function(_Error value) error,
  }) {
    return signupSucceeded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_Unauthenticated value)? unauthenticated,
    TResult? Function(_Requires2FACode value)? requires2FACode,
    TResult? Function(_SignupSucceeded value)? signupSucceeded,
    TResult? Function(_PasswordResetCodeSent value)? passwordResetCodeSent,
    TResult? Function(_Error value)? error,
  }) {
    return signupSucceeded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_Unauthenticated value)? unauthenticated,
    TResult Function(_Requires2FACode value)? requires2FACode,
    TResult Function(_SignupSucceeded value)? signupSucceeded,
    TResult Function(_PasswordResetCodeSent value)? passwordResetCodeSent,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (signupSucceeded != null) {
      return signupSucceeded(this);
    }
    return orElse();
  }
}

abstract class _SignupSucceeded implements AuthState {
  const factory _SignupSucceeded({required final User user}) =
      _$SignupSucceededImpl;

  User get user;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SignupSucceededImplCopyWith<_$SignupSucceededImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PasswordResetCodeSentImplCopyWith<$Res> {
  factory _$$PasswordResetCodeSentImplCopyWith(
          _$PasswordResetCodeSentImpl value,
          $Res Function(_$PasswordResetCodeSentImpl) then) =
      __$$PasswordResetCodeSentImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String email, String message});
}

/// @nodoc
class __$$PasswordResetCodeSentImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$PasswordResetCodeSentImpl>
    implements _$$PasswordResetCodeSentImplCopyWith<$Res> {
  __$$PasswordResetCodeSentImplCopyWithImpl(_$PasswordResetCodeSentImpl _value,
      $Res Function(_$PasswordResetCodeSentImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? message = null,
  }) {
    return _then(_$PasswordResetCodeSentImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$PasswordResetCodeSentImpl implements _PasswordResetCodeSent {
  const _$PasswordResetCodeSentImpl(
      {required this.email, required this.message});

  @override
  final String email;
  @override
  final String message;

  @override
  String toString() {
    return 'AuthState.passwordResetCodeSent(email: $email, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PasswordResetCodeSentImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email, message);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PasswordResetCodeSentImplCopyWith<_$PasswordResetCodeSentImpl>
      get copyWith => __$$PasswordResetCodeSentImplCopyWithImpl<
          _$PasswordResetCodeSentImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(TokenResponse token) authenticated,
    required TResult Function(String? message) unauthenticated,
    required TResult Function(String email, String message) requires2FACode,
    required TResult Function(User user) signupSucceeded,
    required TResult Function(String email, String message)
        passwordResetCodeSent,
    required TResult Function(String message) error,
  }) {
    return passwordResetCodeSent(email, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(TokenResponse token)? authenticated,
    TResult? Function(String? message)? unauthenticated,
    TResult? Function(String email, String message)? requires2FACode,
    TResult? Function(User user)? signupSucceeded,
    TResult? Function(String email, String message)? passwordResetCodeSent,
    TResult? Function(String message)? error,
  }) {
    return passwordResetCodeSent?.call(email, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(TokenResponse token)? authenticated,
    TResult Function(String? message)? unauthenticated,
    TResult Function(String email, String message)? requires2FACode,
    TResult Function(User user)? signupSucceeded,
    TResult Function(String email, String message)? passwordResetCodeSent,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (passwordResetCodeSent != null) {
      return passwordResetCodeSent(email, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_Unauthenticated value) unauthenticated,
    required TResult Function(_Requires2FACode value) requires2FACode,
    required TResult Function(_SignupSucceeded value) signupSucceeded,
    required TResult Function(_PasswordResetCodeSent value)
        passwordResetCodeSent,
    required TResult Function(_Error value) error,
  }) {
    return passwordResetCodeSent(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_Unauthenticated value)? unauthenticated,
    TResult? Function(_Requires2FACode value)? requires2FACode,
    TResult? Function(_SignupSucceeded value)? signupSucceeded,
    TResult? Function(_PasswordResetCodeSent value)? passwordResetCodeSent,
    TResult? Function(_Error value)? error,
  }) {
    return passwordResetCodeSent?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_Unauthenticated value)? unauthenticated,
    TResult Function(_Requires2FACode value)? requires2FACode,
    TResult Function(_SignupSucceeded value)? signupSucceeded,
    TResult Function(_PasswordResetCodeSent value)? passwordResetCodeSent,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (passwordResetCodeSent != null) {
      return passwordResetCodeSent(this);
    }
    return orElse();
  }
}

abstract class _PasswordResetCodeSent implements AuthState {
  const factory _PasswordResetCodeSent(
      {required final String email,
      required final String message}) = _$PasswordResetCodeSentImpl;

  String get email;
  String get message;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PasswordResetCodeSentImplCopyWith<_$PasswordResetCodeSentImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
          _$ErrorImpl value, $Res Function(_$ErrorImpl) then) =
      __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$ErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ErrorImpl implements _Error {
  const _$ErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'AuthState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(TokenResponse token) authenticated,
    required TResult Function(String? message) unauthenticated,
    required TResult Function(String email, String message) requires2FACode,
    required TResult Function(User user) signupSucceeded,
    required TResult Function(String email, String message)
        passwordResetCodeSent,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(TokenResponse token)? authenticated,
    TResult? Function(String? message)? unauthenticated,
    TResult? Function(String email, String message)? requires2FACode,
    TResult? Function(User user)? signupSucceeded,
    TResult? Function(String email, String message)? passwordResetCodeSent,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(TokenResponse token)? authenticated,
    TResult Function(String? message)? unauthenticated,
    TResult Function(String email, String message)? requires2FACode,
    TResult Function(User user)? signupSucceeded,
    TResult Function(String email, String message)? passwordResetCodeSent,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_Unauthenticated value) unauthenticated,
    required TResult Function(_Requires2FACode value) requires2FACode,
    required TResult Function(_SignupSucceeded value) signupSucceeded,
    required TResult Function(_PasswordResetCodeSent value)
        passwordResetCodeSent,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_Unauthenticated value)? unauthenticated,
    TResult? Function(_Requires2FACode value)? requires2FACode,
    TResult? Function(_SignupSucceeded value)? signupSucceeded,
    TResult? Function(_PasswordResetCodeSent value)? passwordResetCodeSent,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_Unauthenticated value)? unauthenticated,
    TResult Function(_Requires2FACode value)? requires2FACode,
    TResult Function(_SignupSucceeded value)? signupSucceeded,
    TResult Function(_PasswordResetCodeSent value)? passwordResetCodeSent,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements AuthState {
  const factory _Error(final String message) = _$ErrorImpl;

  String get message;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

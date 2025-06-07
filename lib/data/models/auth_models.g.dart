// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SignUpRequestImpl _$$SignUpRequestImplFromJson(Map<String, dynamic> json) =>
    _$SignUpRequestImpl(
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      gender: json['gender'] as String?,
      age: (json['age'] as num?)?.toInt(),
      fitnessGoals: (json['fitness_goals'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$SignUpRequestImplToJson(_$SignUpRequestImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'gender': instance.gender,
      'age': instance.age,
      'fitness_goals': instance.fitnessGoals,
    };

_$LoginRequestImpl _$$LoginRequestImplFromJson(Map<String, dynamic> json) =>
    _$LoginRequestImpl(
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$$LoginRequestImplToJson(_$LoginRequestImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };

_$TwoFALoginResponseImpl _$$TwoFALoginResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$TwoFALoginResponseImpl(
      message: json['message'] as String,
    );

Map<String, dynamic> _$$TwoFALoginResponseImplToJson(
        _$TwoFALoginResponseImpl instance) =>
    <String, dynamic>{
      'message': instance.message,
    };

_$VerifyCodeRequestImpl _$$VerifyCodeRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$VerifyCodeRequestImpl(
      email: json['email'] as String,
      code: json['code'] as String,
    );

Map<String, dynamic> _$$VerifyCodeRequestImplToJson(
        _$VerifyCodeRequestImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'code': instance.code,
    };

_$TokenResponseImpl _$$TokenResponseImplFromJson(Map<String, dynamic> json) =>
    _$TokenResponseImpl(
      accessToken: json['access_token'] as String,
      tokenType: json['token_type'] as String,
    );

Map<String, dynamic> _$$TokenResponseImplToJson(_$TokenResponseImpl instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'token_type': instance.tokenType,
    };

_$PasswordResetRequestImpl _$$PasswordResetRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$PasswordResetRequestImpl(
      email: json['email'] as String,
    );

Map<String, dynamic> _$$PasswordResetRequestImplToJson(
        _$PasswordResetRequestImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
    };

_$ConfirmPasswordResetRequestImpl _$$ConfirmPasswordResetRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$ConfirmPasswordResetRequestImpl(
      email: json['email'] as String,
      code: json['code'] as String,
      newPassword: json['new_password'] as String,
    );

Map<String, dynamic> _$$ConfirmPasswordResetRequestImplToJson(
        _$ConfirmPasswordResetRequestImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'code': instance.code,
      'new_password': instance.newPassword,
    };

_$MessageResponseImpl _$$MessageResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$MessageResponseImpl(
      message: json['message'] as String,
    );

Map<String, dynamic> _$$MessageResponseImplToJson(
        _$MessageResponseImpl instance) =>
    <String, dynamic>{
      'message': instance.message,
    };

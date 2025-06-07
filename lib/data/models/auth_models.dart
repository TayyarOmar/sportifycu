// lib/data/models/auth_models.dart
import 'package:freezed_annotation/freezed_annotation.dart';
part 'auth_models.freezed.dart';
part 'auth_models.g.dart';

/// 1. Signup request (POST /signup)
@freezed
class SignUpRequest with _$SignUpRequest {
  factory SignUpRequest({
    required String name,
    required String email,
    required String password,
    String? gender,
    int? age,
    @JsonKey(name: 'fitness_goals') List<String>? fitnessGoals,
  }) = _SignUpRequest;

  factory SignUpRequest.fromJson(Map<String, Object?> json) =>
      _$SignUpRequestFromJson(json);
}

/// 3. Login request (POST /login)
@freezed
class LoginRequest with _$LoginRequest {
  factory LoginRequest({
    required String email,
    required String password,
  }) = _LoginRequest;

  factory LoginRequest.fromJson(Map<String, Object?> json) =>
      _$LoginRequestFromJson(json);
}

/// 4. TwoFALoginResponse (POST /login returns this)
///    FastAPI model:
///    {
///      "message": str
///    }
@freezed
class TwoFALoginResponse with _$TwoFALoginResponse {
  factory TwoFALoginResponse({
    required String message,
  }) = _TwoFALoginResponse;

  factory TwoFALoginResponse.fromJson(Map<String, Object?> json) =>
      _$TwoFALoginResponseFromJson(json);
}

/// 5. VerifyCodeRequest (POST /verify-2fa-code body)
///    FastAPI model:
///    {
///        "email": EmailStr,
///        "code": str
///    }
@freezed
class VerifyCodeRequest with _$VerifyCodeRequest {
  factory VerifyCodeRequest({
    required String email,
    required String code,
  }) = _VerifyCodeRequest;

  factory VerifyCodeRequest.fromJson(Map<String, Object?> json) =>
      _$VerifyCodeRequestFromJson(json);
}

/// 6. TokenResponse (Response from /verify-2fa-code)
///    FastAPI returns a Token model:
///    {
///      "access_token": str,
///      "token_type": "bearer"
///    }
@freezed
class TokenResponse with _$TokenResponse {
  factory TokenResponse({
    @JsonKey(name: 'access_token') required String accessToken,
    @JsonKey(name: 'token_type') required String tokenType,
  }) = _TokenResponse;

  factory TokenResponse.fromJson(Map<String, Object?> json) =>
      _$TokenResponseFromJson(json);
}

/// 7. Password reset request (POST /request-password-reset)
@freezed
class PasswordResetRequest with _$PasswordResetRequest {
  factory PasswordResetRequest({
    required String email,
  }) = _PasswordResetRequest;

  factory PasswordResetRequest.fromJson(Map<String, Object?> json) =>
      _$PasswordResetRequestFromJson(json);
}

/// 8. Confirm password reset payload (POST /confirm-password-reset)
///    FastAPI model: PasswordResetConfirmWithCodeRequest
///    {
///        "email": EmailStr
///        "code": str
///        "new_password": str
///    }
@freezed
class ConfirmPasswordResetRequest with _$ConfirmPasswordResetRequest {
  factory ConfirmPasswordResetRequest({
    required String email,
    required String code,
    @JsonKey(name: 'new_password') required String newPassword,
  }) = _ConfirmPasswordResetRequest;

  factory ConfirmPasswordResetRequest.fromJson(Map<String, Object?> json) =>
      _$ConfirmPasswordResetRequestFromJson(json);
}

/// 9. Generic message response (Used by /request-password-reset and /confirm-password-reset)
@freezed
class MessageResponse with _$MessageResponse {
  factory MessageResponse({
    required String message,
  }) = _MessageResponse;

  factory MessageResponse.fromJson(Map<String, Object?> json) =>
      _$MessageResponseFromJson(json);
}

// lib/domain/repositories/auth_repository.dart

import '../../data/models/auth_models.dart';
// Remove UserEntity import if TokenResponse is used directly and UserEntity isn't constructed here.
// import '../entities/user_entity.dart';
import '../../data/models/user_model.dart';

abstract class AuthRepository {
  /// Sign up a new user.
  /// The backend creates the user and returns the full user profile.
  Future<User> signUp(SignUpRequest request);

  /// Log in existing user (sends 2FA email with a code).
  /// Returns a message indicating the code has been sent.
  Future<TwoFALoginResponse> login(LoginRequest request);

  /// Verify the 2FA code sent to user's email after login attempt.
  /// Takes email and code, returns JWT upon success.
  Future<TokenResponse> verifyLoginCode(VerifyCodeRequest request);

  /// Request a password reset email (sends a code).
  Future<MessageResponse> requestPasswordReset(PasswordResetRequest request);

  /// Confirm password reset with the code and new password.
  /// Takes email, code, and new_password via ConfirmPasswordResetRequest.
  Future<MessageResponse> confirmPasswordReset(
      ConfirmPasswordResetRequest request);

  /// Fetch the current user's profile information.
  Future<User> getMe();
}

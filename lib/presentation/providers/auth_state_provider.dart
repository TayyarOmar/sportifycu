import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../core/providers/repository_providers.dart';
import '../../data/models/auth_models.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../data/models/user_model.dart';
import 'user_profile_provider.dart';

part 'auth_state_provider.freezed.dart';

const String _authTokenKey = 'auth_token';

@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.authenticated({required TokenResponse token}) =
      _Authenticated;
  const factory AuthState.unauthenticated({String? message}) = _Unauthenticated;
  const factory AuthState.requires2FACode(
      {required String email, required String message}) = _Requires2FACode;
  const factory AuthState.signupSucceeded({required User user}) =
      _SignupSucceeded;
  const factory AuthState.passwordResetCodeSent(
      {required String email,
      required String message}) = _PasswordResetCodeSent;
  const factory AuthState.error(String message) = _Error;
}

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;
  final FlutterSecureStorage _secureStorage;
  final Ref _ref;

  AuthNotifier(this._authRepository, this._secureStorage, this._ref)
      : super(const AuthState.initial()) {
    _checkPersistedToken();
  }

  Future<void> _checkPersistedToken() async {
    state = const AuthState.loading();
    try {
      final accessToken = await _secureStorage.read(key: _authTokenKey);
      if (accessToken != null && accessToken.isNotEmpty) {
        state = AuthState.authenticated(
            token:
                TokenResponse(accessToken: accessToken, tokenType: 'bearer'));
        await _ref.read(userProfileProvider.notifier).fetchUserProfile();
      } else {
        state = const AuthState.unauthenticated();
      }
    } catch (e) {
      state = AuthState.unauthenticated(
          message: 'Error loading session: ${e.toString()}');
    }
  }

  Future<void> signUp(SignUpRequest request) async {
    state = const AuthState.loading();
    try {
      final User userResponse = await _authRepository.signUp(request);
      _ref.read(userProfileProvider.notifier).state =
          UserProfileState.loaded(user: userResponse);
      state = AuthState.signupSucceeded(user: userResponse);
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> login(LoginRequest request) async {
    state = const AuthState.loading();
    try {
      final response = await _authRepository.login(request);
      state = AuthState.requires2FACode(
          email: request.email, message: response.message);
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> verifyLoginCode(VerifyCodeRequest request) async {
    state = const AuthState.loading();
    try {
      final tokenResponse = await _authRepository.verifyLoginCode(request);
      await _secureStorage.write(
          key: _authTokenKey, value: tokenResponse.accessToken);
      state = AuthState.authenticated(token: tokenResponse);
      await _ref.read(userProfileProvider.notifier).fetchUserProfile();
    } catch (e) {
      await _secureStorage.delete(key: _authTokenKey);
      state = AuthState.error(e.toString());
    }
  }

  Future<void> updateNotificationSetting(bool isEnabled) async {
    final userProfileState = _ref.read(userProfileProvider);
    userProfileState.maybeWhen(
      loaded: (user) {
        final updatedUser = user.copyWith(notificationSetting: isEnabled);
        _ref.read(userProfileProvider.notifier).state =
            UserProfileState.loaded(user: updatedUser);
        // Here you would also make an API call to persist the change
        // For example: await _authRepository.updateNotificationSettings(isEnabled);
      },
      orElse: () {
        // Handle cases where the user is not loaded, maybe do nothing or log an error
      },
    );
  }

  Future<void> requestPasswordReset(PasswordResetRequest request) async {
    state = const AuthState.loading();
    try {
      final response = await _authRepository.requestPasswordReset(request);
      state = AuthState.passwordResetCodeSent(
          email: request.email, message: response.message);
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> confirmPasswordReset(ConfirmPasswordResetRequest request) async {
    state = const AuthState.loading();
    try {
      await _authRepository.confirmPasswordReset(request);
      state = const AuthState.unauthenticated(
          message: "Password reset successful. Please login.");
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> logout() async {
    state = const AuthState.loading();
    try {
      await _secureStorage.delete(key: _authTokenKey);
      _ref.read(userProfileProvider.notifier).clearProfile();
      state =
          const AuthState.unauthenticated(message: "Successfully logged out.");
    } catch (e) {
      state = AuthState.unauthenticated(
          message: "Logged out. Error clearing session: ${e.toString()}");
    }
  }
}

final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  const secureStorage = FlutterSecureStorage();
  return AuthNotifier(authRepository, secureStorage, ref);
});

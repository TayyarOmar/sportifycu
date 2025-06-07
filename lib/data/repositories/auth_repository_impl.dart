// lib/data/repositories/auth_repository_impl.dart

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart'; // Import for kDebugMode
import '../../core/services/api_service.dart';
import '../../data/models/auth_models.dart';
import '../../data/models/user_model.dart'; // Added import for User model
// import '../../domain/entities/user_entity.dart'; // Not directly used here anymore
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final Dio _client = ApiService.instance.client;
  final String _authPrefix = '/api/v1/auth'; // Centralize API prefix

  @override
  Future<User> signUp(SignUpRequest request) async {
    try {
      final response = await _client.post(
        '$_authPrefix/signup', // Updated path
        data: request.toJson(),
      );
      return User.fromJson(response.data as Map<String, Object?>);
    } on DioException catch (e) {
      if (kDebugMode) {
        print('DioException in signUp: ${e.requestOptions.uri}');
        print('Response data: ${e.response?.data}');
        print('Error: $e');
      }
      if (e.response?.data is Map<String, dynamic>) {
        final Map<String, dynamic> errMap =
            e.response!.data as Map<String, dynamic>;
        final detail = errMap['detail'] ??
            errMap['message'] ??
            'Unknown signup error from API';
        throw Exception(detail);
      }
      throw Exception(
          'Signup failed: Network or server error. ${e.message ?? e.toString()}');
    } catch (e) {
      if (kDebugMode) {
        print('Generic Exception in signUp: $e');
      }
      throw Exception(
          'Signup failed due to an unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<TwoFALoginResponse> login(LoginRequest request) async {
    try {
      final response = await _client.post(
        '$_authPrefix/login', // Updated path
        data: request.toJson(),
      );
      return TwoFALoginResponse.fromJson(response.data as Map<String, Object?>);
    } on DioException catch (e) {
      if (kDebugMode) {
        print('DioException in login: ${e.requestOptions.uri}');
        print('Response data: ${e.response?.data}');
        print('Error: $e');
      }
      if (e.response?.data is Map<String, dynamic>) {
        final Map<String, dynamic> errMap =
            e.response!.data as Map<String, dynamic>;
        final detail =
            errMap['detail'] ?? errMap['message'] ?? 'Login failed from API';
        throw Exception(detail);
      }
      throw Exception(
          'Login failed: Network or server error. ${e.message ?? e.toString()}');
    } catch (e) {
      if (kDebugMode) {
        print('Generic Exception in login: $e');
      }
      throw Exception(
          'Login failed due to an unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<TokenResponse> verifyLoginCode(VerifyCodeRequest request) async {
    try {
      final response = await _client.post(
        '$_authPrefix/verify-2fa-code', // Updated path and method
        data: request.toJson(),
      );
      return TokenResponse.fromJson(response.data as Map<String, Object?>);
    } on DioException catch (e) {
      if (kDebugMode) {
        print('DioException in verifyLoginCode: ${e.requestOptions.uri}');
        print('Response data: ${e.response?.data}');
        print('Error: $e');
      }
      if (e.response?.data is Map<String, dynamic>) {
        final Map<String, dynamic> errMap =
            e.response!.data as Map<String, dynamic>;
        final detail =
            errMap['detail'] ?? '2FA code verification failed from API';
        throw Exception(detail);
      }
      throw Exception(
          '2FA code verification failed: Network or server error. ${e.message ?? e.toString()}');
    } catch (e) {
      if (kDebugMode) {
        print('Generic Exception in verifyLoginCode: $e');
      }
      throw Exception(
          '2FA code verification failed due to an unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<MessageResponse> requestPasswordReset(
      PasswordResetRequest request) async {
    try {
      final response = await _client.post(
        '$_authPrefix/request-password-reset', // Updated path
        data: request.toJson(),
      );
      return MessageResponse.fromJson(response.data as Map<String, Object?>);
    } on DioException catch (e) {
      if (kDebugMode) {
        print('DioException in requestPasswordReset: ${e.requestOptions.uri}');
        print('Response data: ${e.response?.data}');
        print('Error: $e');
      }
      if (e.response?.data is Map<String, dynamic>) {
        final Map<String, dynamic> errMap =
            e.response!.data as Map<String, dynamic>;
        final detail =
            errMap['detail'] ?? 'Password reset request failed from API';
        throw Exception(detail);
      }
      throw Exception(
          'Request password reset failed: Network or server error. ${e.message ?? e.toString()}');
    } catch (e) {
      if (kDebugMode) {
        print('Generic Exception in requestPasswordReset: $e');
      }
      throw Exception(
          'Request password reset failed due to an unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<MessageResponse> confirmPasswordReset(
      ConfirmPasswordResetRequest request) async {
    try {
      final response = await _client.post(
        '$_authPrefix/confirm-password-reset', // Updated path, removed queryParameters
        data: request.toJson(),
      );
      return MessageResponse.fromJson(response.data as Map<String, Object?>);
    } on DioException catch (e) {
      if (kDebugMode) {
        print('DioException in confirmPasswordReset: ${e.requestOptions.uri}');
        print('Response data: ${e.response?.data}');
        print('Error: $e');
      }
      if (e.response?.data is Map<String, dynamic>) {
        final Map<String, dynamic> errMap =
            e.response!.data as Map<String, dynamic>;
        final detail =
            errMap['detail'] ?? 'Password reset confirmation failed from API';
        throw Exception(detail);
      }
      throw Exception(
          'Confirm password reset failed: Network or server error. ${e.message ?? e.toString()}');
    } catch (e) {
      if (kDebugMode) {
        print('Generic Exception in confirmPasswordReset: $e');
      }
      throw Exception(
          'Confirm password reset failed due to an unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<User> getMe() async {
    try {
      final response = await _client.get('/api/v1/users/me');
      return User.fromJson(response.data as Map<String, Object?>);
    } on DioException catch (e) {
      if (kDebugMode) {
        print('DioException in getMe: ${e.requestOptions.uri}');
        print('Response data: ${e.response?.data}');
        print('Error: $e');
      }
      if (e.response?.data is Map<String, dynamic>) {
        final Map<String, dynamic> errMap =
            e.response!.data as Map<String, dynamic>;
        final detail =
            errMap['detail'] ?? 'Failed to fetch user profile from API';
        throw Exception(detail);
      }
      throw Exception(
          'Failed to fetch user profile: Network or server error. ${e.message ?? e.toString()}');
    } catch (e) {
      if (kDebugMode) {
        print('Generic Exception in getMe: $e');
      }
      throw Exception(
          'Failed to fetch user profile due to an unexpected error: ${e.toString()}');
    }
  }
}

// lib/domain/entities/user_entity.dart

/// We only need a minimal entity to hold the final JWT token after 2FA.
///
/// In this example, we store the access token, which you can later save
/// in secure storage for authenticated calls.
class UserEntity {
  final String accessToken;
  final String tokenType; // usually "bearer"

  UserEntity({
    required this.accessToken,
    required this.tokenType,
  });
}

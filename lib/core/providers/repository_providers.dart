import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/team_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/team_repository.dart';

/// Provides an instance of [AuthRepository].
///
/// This is used by other providers (e.g., AuthStateNotifier) to interact
/// with the authentication data layer.
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl();
});

final teamRepositoryProvider = Provider<TeamRepository>((ref) {
  return TeamRepositoryImpl();
});

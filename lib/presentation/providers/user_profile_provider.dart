import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../core/providers/repository_providers.dart';
import '../../data/models/user_model.dart';
import '../../domain/repositories/auth_repository.dart';

part 'user_profile_provider.freezed.dart';

@freezed
sealed class UserProfileState with _$UserProfileState {
  const factory UserProfileState.initial() = _Initial;
  const factory UserProfileState.loading() = _Loading;
  const factory UserProfileState.loaded({required User user}) = _Loaded;
  const factory UserProfileState.error(String message) = _Error;
}

class UserProfileNotifier extends StateNotifier<UserProfileState> {
  final AuthRepository _authRepository;

  UserProfileNotifier(this._authRepository)
      : super(const UserProfileState.initial());

  Future<void> fetchUserProfile() async {
    state = const UserProfileState.loading();
    try {
      final user = await _authRepository.getMe();
      state = UserProfileState.loaded(user: user);
    } catch (e) {
      state = UserProfileState.error(e.toString());
    }
  }

  void clearProfile() {
    state = const UserProfileState.initial();
  }
}

final userProfileProvider =
    StateNotifierProvider<UserProfileNotifier, UserProfileState>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return UserProfileNotifier(authRepository);
});

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'signup_data_provider.freezed.dart';

@freezed
class SignUpData with _$SignUpData {
  const factory SignUpData({
    String? name,
    String? email,
    String? password,
    String? gender,
    int? age,
    List<String>? fitnessGoals,
  }) = _SignUpData;
}

class SignUpDataNotifier extends StateNotifier<SignUpData> {
  SignUpDataNotifier() : super(const SignUpData());

  void updateNameEmailPassword(String name, String email, String password) {
    state = state.copyWith(name: name, email: email, password: password);
  }

  void updateGenderAndAge({String? gender, int? age}) {
    state = state.copyWith(gender: gender, age: age);
  }

  void updateFitnessGoals(List<String>? goals) {
    state = state.copyWith(fitnessGoals: goals ?? []);
  }

  void clearFitnessGoals() {
    state = state.copyWith(fitnessGoals: []);
  }

  void reset() {
    state = const SignUpData();
  }
}

final signUpDataProvider =
    StateNotifierProvider<SignUpDataNotifier, SignUpData>((ref) {
  return SignUpDataNotifier();
});

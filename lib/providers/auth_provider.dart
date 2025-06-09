import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportify_app/api/auth_api.dart';

class SignupData {
  String? name;
  String? email;
  String? password;
  String? gender;
  String? age;
  List<String> fitnessGoals = [];
}

class AuthProvider with ChangeNotifier {
  final AuthApi _authApi = AuthApi();
  SignupData _signupData = SignupData();
  bool _isLoading = false;

  SignupData get signupData => _signupData;
  bool get isLoading => _isLoading;

  void updateSignupData({
    String? name,
    String? email,
    String? password,
    String? gender,
    String? age,
    List<String>? fitnessGoals,
  }) {
    _signupData.name = name ?? _signupData.name;
    _signupData.email = email ?? _signupData.email;
    _signupData.password = password ?? _signupData.password;
    _signupData.gender = gender ?? _signupData.gender;
    _signupData.age = age ?? _signupData.age;
    _signupData.fitnessGoals = fitnessGoals ?? _signupData.fitnessGoals;
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> signup() async {
    _setLoading(true);
    try {
      // TODO: The backend doesn't currently take fitness goals on signup.
      // This would require a second API call after login to update the user profile.
      // For now, we are only sending the data the signup endpoint accepts.
      int? ageValue;
      if (_signupData.age != null) {
        if (_signupData.age == 'Under 18') ageValue = 17;
        if (_signupData.age == '18 - 35') ageValue = 25;
        if (_signupData.age == 'More than 35') ageValue = 40;
      }

      await _authApi.signup(
        name: _signupData.name!,
        email: _signupData.email!,
        password: _signupData.password!,
        gender: _signupData.gender,
        age: ageValue,
      );
      _signupData = SignupData(); // Clear data after successful signup
    } finally {
      _setLoading(false);
    }
  }

  Future<void> login(String email, String password) async {
    _setLoading(true);
    try {
      await _authApi.login(email, password);
    } finally {
      _setLoading(false);
    }
  }

  Future<void> verifyCodeAndLogin(String email, String code) async {
    _setLoading(true);
    try {
      final response = await _authApi.verify2FACode(email, code);
      final token = response['access_token'];

      // Store the token
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('authToken', token);

      // TODO: Implement logic to handle successful login, e.g., navigate to home
    } finally {
      _setLoading(false);
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('authToken');
    // TODO: Implement navigation to login screen
    notifyListeners();
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('authToken');
  }
}

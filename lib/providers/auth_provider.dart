import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportify_app/api/auth_api.dart';
import 'package:sportify_app/api/user_api.dart';
import 'package:sportify_app/models/user.dart';

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
  final UserApi _userApi = UserApi();

  SignupData _signupData = SignupData();
  bool _isLoading = false;
  User? _user;

  SignupData get signupData => _signupData;
  bool get isLoading => _isLoading;
  User? get user => _user;
  bool get isLoggedIn => _user != null;

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

      await fetchCurrentUser();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> fetchCurrentUser() async {
    try {
      _user = await _userApi.getMe();
      notifyListeners();
    } catch (e) {
      // Could fail if token is expired, etc.
      await logout(); // Log out if we can't fetch the user
      throw Exception('Session expired. Please log in again.');
    }
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('authToken')) {
      return false;
    }
    _setLoading(true);
    try {
      await fetchCurrentUser();
      return isLoggedIn;
    } catch (e) {
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> addFavorite(String gymId) async {
    if (_user == null) return;
    try {
      _user = await _userApi.addFavoriteGym(gymId);
      notifyListeners();
    } catch (e) {
      // Handle error, maybe show a snackbar
      print("Error adding favorite: $e");
    }
  }

  Future<void> removeFavorite(String gymId) async {
    if (_user == null) return;
    try {
      _user = await _userApi.removeFavoriteGym(gymId);
      notifyListeners();
    } catch (e) {
      // Handle error
      print("Error removing favorite: $e");
    }
  }

  Future<bool> logActivity(String activityType, num value) async {
    if (_user == null) return false;
    _setLoading(true);
    try {
      final today = DateTime.now().toIso8601String().split('T').first;
      await _userApi.logActivity(activityType, today, value);
      // Refresh user data to get updated activity list and score
      await fetchCurrentUser();
      return true;
    } catch (e) {
      // Handle error, maybe expose it via a property
      print("Error logging activity: $e");
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> updateProfile({
    String? name,
    String? gender,
    int? age,
    List<String>? fitnessGoals,
  }) async {
    if (_user == null) return false;
    _setLoading(true);
    try {
      final updatedUser = await _userApi.updateProfile(
        name: name,
        gender: gender,
        age: age,
        fitnessGoals: fitnessGoals,
      );
      _user = updatedUser;
      notifyListeners();
      return true;
    } catch (e) {
      print("Error updating profile: $e");
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('authToken');
    _user = null;
    notifyListeners();
  }
}

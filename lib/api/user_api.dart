import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportify_app/models/user.dart';
import 'package:sportify_app/utils/constants.dart';

class UserApi {
  final String _baseUrl = AppConstants.baseUrl;

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken');
  }

  Future<User> getMe() async {
    final token = await _getToken();
    if (token == null) {
      throw Exception('Not authenticated');
    }

    final url = Uri.parse('$_baseUrl/api/v1/users/me');
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load user data');
    }
  }

  Future<User> addFavoriteGym(String gymId) async {
    final token = await _getToken();
    if (token == null) {
      throw Exception('Not authenticated');
    }

    final url = Uri.parse('$_baseUrl/api/v1/users/me/favourites/$gymId');
    final response = await http.post(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add favorite gym');
    }
  }

  Future<User> removeFavoriteGym(String gymId) async {
    final token = await _getToken();
    if (token == null) {
      throw Exception('Not authenticated');
    }

    final url = Uri.parse('$_baseUrl/api/v1/users/me/favourites/$gymId');
    final response = await http.delete(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to remove favorite gym');
    }
  }

  Future<User> updateProfile({
    String? name,
    String? gender,
    int? age,
    List<String>? fitnessGoals,
  }) async {
    final token = await _getToken();
    if (token == null) {
      throw Exception('Not authenticated');
    }

    final url = Uri.parse('$_baseUrl/api/v1/users/me/profile');

    // Create a map and remove null values
    final Map<String, dynamic> body = {
      'name': name,
      'gender': gender,
      'age': age,
      'fitness_goals': fitnessGoals,
    };
    body.removeWhere((key, value) => value == null);

    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(body),
    );

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update profile: ${response.body}');
    }
  }

  Future<void> logActivity(String activityType, String date, num value) async {
    final token = await _getToken();
    if (token == null) {
      throw Exception('Not authenticated');
    }

    // Determine endpoint based on activityType
    String endpoint;
    switch (activityType) {
      case 'running':
        endpoint = 'running';
        break;
      case 'steps':
        endpoint = 'steps';
        break;
      case 'gym_time':
        endpoint = 'gym-time';
        break;
      default:
        throw Exception('Invalid activity type');
    }

    final url = Uri.parse('$_baseUrl/api/v1/users/me/activity-log/$endpoint');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({'date': date, 'value': value}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to log $activityType: ${response.body}');
    }
  }
}

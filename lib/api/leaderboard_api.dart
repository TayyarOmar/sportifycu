import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportify_app/models/leaderboard_entry.dart';
import 'package:sportify_app/utils/constants.dart';

class LeaderboardApi {
  final String _baseUrl = AppConstants.baseUrl;

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken');
  }

  Future<List<LeaderboardEntry>> getTopUsers({int limit = 10}) async {
    final token = await _getToken();
    // This endpoint might be public, but sending token if available is fine
    final headers =
        token != null ? {'Authorization': 'Bearer $token'} : <String, String>{};

    final url =
        Uri.parse('$_baseUrl/api/v1/leaderboards/top-scores?limit=$limit');
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      return body
          .map((dynamic item) => LeaderboardEntry.fromJson(item))
          .toList();
    } else {
      throw Exception('Failed to load leaderboard');
    }
  }
}

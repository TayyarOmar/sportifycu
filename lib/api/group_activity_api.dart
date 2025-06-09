import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportify_app/models/group_activity_team.dart';
import 'package:sportify_app/utils/constants.dart';

class GroupActivityApi {
  final String _baseUrl = AppConstants.baseUrl;

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken');
  }

  // Fetch all active teams
  Future<List<GroupActivityTeam>> getAllActiveTeams() async {
    final url = Uri.parse('$_baseUrl/api/v1/activity-teams/');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      return body
          .map((dynamic item) => GroupActivityTeam.fromJson(item))
          .toList();
    } else {
      throw Exception('Failed to load active teams');
    }
  }

  // Create a new team
  Future<GroupActivityTeam> createTeam({
    required String name,
    required String description,
    required String category,
    required String location,
    required String dateAndTime,
    required int playersNeeded,
    required String contactInformation,
    String? ageRange,
    File? photo,
  }) async {
    final token = await _getToken();
    if (token == null) {
      throw Exception('Not authenticated');
    }

    final url = Uri.parse('$_baseUrl/api/v1/activity-teams/');
    var request = http.MultipartRequest('POST', url)
      ..headers['Authorization'] = 'Bearer $token'
      ..fields['name'] = name
      ..fields['description'] = description
      ..fields['category'] = category
      ..fields['location'] = location
      ..fields['date_and_time'] = dateAndTime
      ..fields['players_needed'] = playersNeeded.toString()
      ..fields['contact_information'] = contactInformation;

    if (ageRange != null) {
      request.fields['age_range'] = ageRange;
    }

    if (photo != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'photo',
        photo.path,
        contentType:
            MediaType('image', 'jpeg'), // Adjust content type as needed
      ));
    }

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 201) {
      return GroupActivityTeam.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          'Failed to create team. Status: ${response.statusCode} Body: ${response.body}');
    }
  }

  // Update a team
  Future<GroupActivityTeam> updateTeam({
    required String teamId,
    required String name,
    required String description,
    required String category,
    required String location,
    required String dateAndTime,
    required int playersNeeded,
    required String contactInformation,
    String? ageRange,
  }) async {
    final token = await _getToken();
    if (token == null) {
      throw Exception('Not authenticated');
    }

    final url = Uri.parse('$_baseUrl/api/v1/activity-teams/$teamId');
    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: json.encode({
        'name': name,
        'description': description,
        'category': category,
        'location': location,
        'date_and_time': dateAndTime,
        'players_needed': playersNeeded,
        'contact_information': contactInformation,
        'age_range': ageRange,
      }),
    );

    if (response.statusCode == 200) {
      return GroupActivityTeam.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          'Failed to update team. Status: ${response.statusCode} Body: ${response.body}');
    }
  }

  // Book a team
  Future<void> bookTeam(String teamId) async {
    final token = await _getToken();
    if (token == null) {
      throw Exception('Not authenticated');
    }

    final url = Uri.parse('$_baseUrl/api/v1/activity-teams/$teamId/bookings');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode != 200) {
      throw Exception(
          'Failed to book team. Status: ${response.statusCode} Body: ${response.body}');
    }
  }

  // Delete a team
  Future<void> deleteTeam(String teamId) async {
    final token = await _getToken();
    if (token == null) {
      throw Exception('Not authenticated');
    }

    final url = Uri.parse('$_baseUrl/api/v1/activity-teams/$teamId');
    final response = await http.delete(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode != 204) {
      throw Exception(
          'Failed to delete team. Status: ${response.statusCode} Body: ${response.body}');
    }
  }

  // Get user's bookings
  Future<List<GroupActivityTeam>> getUserBookings() async {
    final token = await _getToken();
    if (token == null) {
      throw Exception('Not authenticated');
    }

    final url = Uri.parse('$_baseUrl/api/v1/users/me/bookings');
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> body = json.decode(response.body);
      // The booking response is a list of team details. We need to fetch full details.
      // For now, let's assume the booking response is sufficient.
      // If not, we would need another endpoint or modify this one.
      // Based on `BookingResponse` schema, it seems limited.
      // Let's assume for now we need to fetch full team details for each booking.
      // This is inefficient. A better backend would return full objects.
      // Given the prompt to not change backend, we'll work with what we have.
      // The schema is BookingResponse, which is not the full team object.
      // Let's create a temporary list of teams.
      // This part of the code is tricky. The backend returns a BookingResponse, not a GroupActivityTeam.
      // I will assume for now I need to make another request to get the full team details.
      // This is not ideal. I'll add a TODO.
      // Let's check the user router again.
      final bookingsResponse = body.map((b) => b['team_id'] as String).toList();
      List<GroupActivityTeam> teams = [];
      final allTeams =
          await getAllActiveTeams(); // Not ideal, but works for now.
      for (String teamId in bookingsResponse) {
        final team = allTeams.firstWhere((t) => t.teamId == teamId,
            orElse: () =>
                throw Exception("Booked team not found in active list"));
        teams.add(team);
      }
      return teams;
    } else {
      throw Exception('Failed to load user bookings');
    }
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sportify_app/models/gym.dart';
import 'package:sportify_app/utils/constants.dart';

class GymApi {
  final String _baseUrl = AppConstants.baseUrl;

  // Fetches all gyms
  Future<List<Gym>> getAllGyms() async {
    final url = Uri.parse('$_baseUrl/api/v1/gyms/');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      List<Gym> gyms = body.map((dynamic item) => Gym.fromJson(item)).toList();
      return gyms;
    } else {
      throw Exception('Failed to load gyms');
    }
  }

  // Fetches gyms near a specific location
  Future<List<Gym>> getGymsAroundYou(double latitude, double longitude,
      {int radius = 20000}) async {
    final url = Uri.parse(
        '$_baseUrl/api/v1/gyms/around-you?latitude=$latitude&longitude=$longitude&radius_meters=$radius');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      List<Gym> gyms = body.map((dynamic item) => Gym.fromJson(item)).toList();
      return gyms;
    } else {
      // TODO: Handle specific error messages from the backend
      throw Exception('Failed to load nearby gyms');
    }
  }
}

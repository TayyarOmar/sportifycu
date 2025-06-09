import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sportify_app/utils/constants.dart';

class AuthApi {
  final String _baseUrl = AppConstants.baseUrl;

  Future<Map<String, dynamic>> signup({
    required String name,
    required String email,
    required String password,
    String? gender,
    int? age,
  }) async {
    final url = Uri.parse('$_baseUrl/api/v1/auth/signup');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'name': name,
        'email': email,
        'password': password,
        'gender': gender,
        'age': age,
      }),
    );
    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('$_baseUrl/api/v1/auth/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'password': password,
      }),
    );
    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> verify2FACode(String email, String code) async {
    final url = Uri.parse('$_baseUrl/api/v1/auth/verify-2fa-code');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'code': code,
      }),
    );
    return _handleResponse(response);
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    final Map<String, dynamic> body = json.decode(response.body);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return body;
    } else {
      // Throw an exception with the error message from the backend
      throw Exception(body['detail'] ?? 'An unknown error occurred');
    }
  }
}

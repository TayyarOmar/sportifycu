import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sportify_app/models/chat_message.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportify_app/utils/constants.dart';

class AiCoachApi {
  final String _baseUrl = AppConstants.baseUrl;

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken');
  }

  Future<String> sendMessages(List<ChatMessage> messages) async {
    // Keep last 20 (10 turns)
    final trimmed = messages.length > 20
        ? messages.sublist(messages.length - 20)
        : messages;
    final token = await _getToken();
    if (token == null) {
      throw Exception('Not authenticated');
    }

    final url = Uri.parse('$_baseUrl/api/v1/ai-coach/');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({
        'messages': trimmed.map((m) => m.toJson()).toList(),
      }),
    );

    final body = json.decode(response.body);
    if (response.statusCode == 200) {
      return body['assistant_response'];
    } else {
      throw Exception(body['detail'] ?? 'Failed to get AI response');
    }
  }
}

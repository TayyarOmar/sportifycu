import 'package:flutter/material.dart';
import 'package:sportify_app/api/ai_coach_api.dart';
import 'package:sportify_app/models/chat_message.dart';

class ChatProvider with ChangeNotifier {
  final AiCoachApi _api = AiCoachApi();

  final List<ChatMessage> _messages = [];
  List<ChatMessage> get messages => List.unmodifiable(_messages);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  void _setLoading(bool v) {
    _isLoading = v;
    notifyListeners();
  }

  Future<void> sendUserMessage(String content) async {
    if (content.trim().isEmpty) return;
    if (content.length > 500) {
      _error = 'Message too long (max 500 chars)';
      notifyListeners();
      return;
    }
    _error = null;
    _messages.add(ChatMessage(role: 'user', content: content.trim()));
    notifyListeners();

    _setLoading(true);
    try {
      final reply = await _api.sendMessages(_messages);
      _messages.add(ChatMessage(role: 'assistant', content: reply));
    } catch (e) {
      _error = e.toString();
    } finally {
      // Trim history to last 20
      if (_messages.length > 20) {
        _messages.removeRange(0, _messages.length - 20);
      }
      _setLoading(false);
    }
  }

  void clear() {
    _messages.clear();
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:sportify_app/api/leaderboard_api.dart';
import 'package:sportify_app/models/leaderboard_entry.dart';

class LeaderboardProvider with ChangeNotifier {
  final LeaderboardApi _leaderboardApi = LeaderboardApi();

  List<LeaderboardEntry> _leaderboard = [];
  List<LeaderboardEntry> get leaderboard => _leaderboard;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String? message) {
    _errorMessage = message;
  }

  Future<void> fetchLeaderboard() async {
    _setLoading(true);
    _setError(null);
    try {
      _leaderboard =
          await _leaderboardApi.getTopUsers(limit: 20); // Fetch top 20 users
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }
}

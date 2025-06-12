import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sportify_app/api/group_activity_api.dart';
import 'package:sportify_app/models/group_activity_team.dart';

class GroupActivityProvider with ChangeNotifier {
  final GroupActivityApi _groupActivityApi = GroupActivityApi();

  List<GroupActivityTeam> _activeTeams = [];
  List<GroupActivityTeam> get activeTeams => _activeTeams;

  List<GroupActivityTeam> _bookedTeams = [];
  List<GroupActivityTeam> get bookedTeams => _bookedTeams;

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

  // Fetch all active teams
  Future<void> fetchActiveTeams() async {
    _setLoading(true);
    _setError(null);
    try {
      _activeTeams = await _groupActivityApi.getAllActiveTeams();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  // Create a new team
  Future<GroupActivityTeam?> createTeam({
    required String name,
    required String description,
    required String category,
    required String location,
    required DateTime dateAndTime,
    required int playersNeeded,
    required String contactInformation,
    String? ageRange,
    File? photo,
  }) async {
    _setLoading(true);
    _setError(null);
    try {
      final newTeam = await _groupActivityApi.createTeam(
        name: name,
        description: description,
        category: category,
        location: location,
        dateAndTime: dateAndTime.toIso8601String(),
        playersNeeded: playersNeeded,
        contactInformation: contactInformation,
        ageRange: ageRange,
        photo: photo,
      );
      // Add to local list and notify
      _activeTeams.add(newTeam);
      notifyListeners();
      return newTeam;
    } catch (e) {
      _setError(e.toString());
      return null;
    } finally {
      _setLoading(false);
    }
  }

  // Update a team
  Future<GroupActivityTeam?> updateTeam({
    required String teamId,
    required String name,
    required String description,
    required String category,
    required String location,
    required DateTime dateAndTime,
    required int playersNeeded,
    required String contactInformation,
    String? ageRange,
    // Photo updating is not included in this simple update method
  }) async {
    _setLoading(true);
    _setError(null);
    try {
      final updatedTeam = await _groupActivityApi.updateTeam(
        teamId: teamId,
        name: name,
        description: description,
        category: category,
        location: location,
        dateAndTime: dateAndTime.toIso8601String(),
        playersNeeded: playersNeeded,
        contactInformation: contactInformation,
        ageRange: ageRange,
      );
      // Update local lists
      final index = _activeTeams.indexWhere((t) => t.teamId == teamId);
      if (index != -1) {
        _activeTeams[index] = updatedTeam;
      }
      final bookedIndex = _bookedTeams.indexWhere((t) => t.teamId == teamId);
      if (bookedIndex != -1) {
        _bookedTeams[bookedIndex] = updatedTeam;
      }
      notifyListeners();
      return updatedTeam;
    } catch (e) {
      _setError(e.toString());
      return null;
    } finally {
      _setLoading(false);
    }
  }

  // Delete a team
  Future<bool> deleteTeam(String teamId) async {
    _setLoading(true);
    _setError(null);
    try {
      await _groupActivityApi.deleteTeam(teamId);
      // Remove from local lists
      _activeTeams.removeWhere((team) => team.teamId == teamId);
      _bookedTeams.removeWhere((team) => team.teamId == teamId);
      notifyListeners();
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Book a team
  Future<bool> bookTeam(String teamId) async {
    _setLoading(true);
    _setError(null);
    try {
      await _groupActivityApi.bookTeam(teamId);
      // Refetch user bookings to update the UI
      await fetchUserBookings();
      await fetchActiveTeams();
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Cancel booking
  Future<bool> cancelBooking(String teamId) async {
    _setLoading(true);
    _setError(null);
    try {
      await _groupActivityApi.cancelBooking(teamId);
      await fetchUserBookings();
      await fetchActiveTeams();
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Fetch user's bookings
  Future<void> fetchUserBookings() async {
    _setLoading(true);
    _setError(null);
    try {
      _bookedTeams = await _groupActivityApi.getUserBookings();
    } catch (e) {
      _setError(e.toString().replaceFirst("Exception: ", ""));
    } finally {
      _setLoading(false);
    }
  }
}

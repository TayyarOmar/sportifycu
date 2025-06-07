import 'dart:io';
import 'package:dio/dio.dart';
import '../models/group_activity_team_model.dart';
import '../../domain/repositories/group_activity_repository.dart';

class GroupActivityRepositoryImpl implements GroupActivityRepository {
  final Dio _dio;

  GroupActivityRepositoryImpl(this._dio);

  @override
  Future<GroupActivityTeam> createTeam(
      Map<String, dynamic> data, File? image) async {
    // In a real app, you would make a multipart request to your backend
    print("Creating team with data: $data");
    await Future.delayed(
        const Duration(seconds: 1)); // Simulate network latency

    // This is a mock response. The backend would create the ID.
    final newTeamId = DateTime.now().millisecondsSinceEpoch.toString();

    // Simulate photo upload and getting a URL
    String? photoUrl;
    if (image != null) {
      print("Simulating image upload for ${image.path}");
      photoUrl = 'https://picsum.photos/seed/$newTeamId/200/300';
    }

    final fullData = Map<String, dynamic>.from(data)
      ..addAll({
        'team_id': newTeamId,
        'lister_id': 'user_123', // This would come from the auth token
        'current_players_count': 1,
        'players_enrolled': ['user_123'],
        'status': 'active',
        'photo_url': photoUrl,
      });

    return GroupActivityTeam.fromJson(fullData);
  }

  @override
  Future<void> deleteTeam(String teamId) async {
    print("Deleting team with ID: $teamId");
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<List<GroupActivityTeam>> getMyTeams() async {
    print("Fetching my teams");
    await Future.delayed(const Duration(seconds: 1));
    return []; // Return an empty list for now
  }

  @override
  Future<GroupActivityTeam> updateTeam(
      String teamId, Map<String, dynamic> data, File? image) async {
    print("Updating team $teamId with data: $data");
    await Future.delayed(const Duration(seconds: 1));

    String? photoUrl;
    if (image != null) {
      photoUrl = 'https://picsum.photos/seed/$teamId/200/300';
    }

    final updatedData = {
      'team_id': teamId,
      'name': data['name'] ?? 'Updated Team Name',
      // ... add all other fields from data
    };

    // This is a mock response. The backend would return the updated object.
    return GroupActivityTeam.fromJson(updatedData);
  }
}

import 'dart:io';
import '../../data/models/group_activity_team_model.dart';

abstract class GroupActivityRepository {
  Future<GroupActivityTeam> createTeam(Map<String, dynamic> data, File? image);
  Future<List<GroupActivityTeam>> getMyTeams();
  Future<void> deleteTeam(String teamId);
  Future<GroupActivityTeam> updateTeam(
      String teamId, Map<String, dynamic> data, File? image);
}

import '../../data/models/team_model.dart';

abstract class TeamRepository {
  Future<Team> createTeam(TeamCreate team);
  Future<void> deleteTeam(String teamId);
  Future<Team?> getTeamById(String teamId);
  Future<List<Team>> getTeams();
  Future<void> updateTeam(Team team);
  Future<Team?> getTeam(String teamId);
}

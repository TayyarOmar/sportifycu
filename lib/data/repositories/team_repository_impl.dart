import '../../domain/repositories/team_repository.dart';
import '../../data/models/team_model.dart';

class TeamRepositoryImpl implements TeamRepository {
  @override
  Future<Team> createTeam(TeamCreate team) async {
    // TODO: Implement createTeam
    throw UnimplementedError();
  }

  @override
  Future<void> deleteTeam(String teamId) async {
    // TODO: Implement deleteTeam
    throw UnimplementedError();
  }

  @override
  Future<Team?> getTeamById(String teamId) async {
    // TODO: Implement getTeamById
    throw UnimplementedError();
  }

  @override
  Future<List<Team>> getTeams() async {
    // TODO: Implement getTeams
    throw UnimplementedError();
  }

  @override
  Future<void> updateTeam(Team team) async {
    // TODO: Implement updateTeam
    throw UnimplementedError();
  }

  @override
  Future<Team?> getTeam(String teamId) async {
    // TODO: Implement getTeam
    throw UnimplementedError();
  }
}

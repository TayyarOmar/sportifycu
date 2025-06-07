import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers/repository_providers.dart';
import '../../data/models/team_model.dart';

// Provider to fetch a single team by its ID
final teamProvider =
    FutureProvider.autoDispose.family<Team?, String>((ref, teamId) {
  final teamRepository = ref.watch(teamRepositoryProvider);
  return teamRepository.getTeam(teamId);
});

// Provider to fetch all teams
final allTeamsProvider = FutureProvider.autoDispose<List<Team>>((ref) {
  final teamRepository = ref.watch(teamRepositoryProvider);
  return teamRepository.getTeams();
});

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../core/providers/repository_providers.dart';
import '../../data/models/team_model.dart';
import '../../domain/repositories/team_repository.dart';

part 'create_team_provider.freezed.dart';

@freezed
abstract class CreateTeamState with _$CreateTeamState {
  const factory CreateTeamState.initial() = _Initial;
  const factory CreateTeamState.loading() = _Loading;
  const factory CreateTeamState.success(Team team) = _Success;
  const factory CreateTeamState.error(String message) = _Error;
}

class CreateTeamNotifier extends StateNotifier<CreateTeamState> {
  final TeamRepository _teamRepository;

  CreateTeamNotifier(this._teamRepository)
      : super(const CreateTeamState.initial());

  Future<void> createTeam(TeamCreate team) async {
    state = const CreateTeamState.loading();
    try {
      final newTeam = await _teamRepository.createTeam(team);
      state = CreateTeamState.success(newTeam);
    } catch (e) {
      state = CreateTeamState.error(e.toString());
    }
  }
}

final createTeamProvider =
    StateNotifierProvider<CreateTeamNotifier, CreateTeamState>((ref) {
  final teamRepository = ref.watch(teamRepositoryProvider);
  return CreateTeamNotifier(teamRepository);
});

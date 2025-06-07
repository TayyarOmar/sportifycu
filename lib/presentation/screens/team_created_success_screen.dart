import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sportify_flutter/presentation/providers/team_providers.dart';
import '../../data/models/team_model.dart';

class TeamCreatedSuccessScreen extends ConsumerWidget {
  final String teamId;
  const TeamCreatedSuccessScreen({Key? key, required this.teamId})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teamAsyncValue = ref.watch(teamProvider(teamId));

    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1E),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120.0),
        child: _buildAppBar(context),
      ),
      body: teamAsyncValue.when(
        data: (team) {
          if (team == null) {
            return const Center(child: Text('Team not found.'));
          }
          return _buildBody(context, team);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }

  Widget _buildBody(BuildContext context, Team team) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildTeamCard(context, team),
          const SizedBox(height: 30),
          _buildActionButton(context, 'Edit', isPrimary: true, onPressed: () {
            // TODO: Navigate to an edit screen
          }),
          const SizedBox(height: 15),
          _buildActionButton(context, 'Delete', isPrimary: false,
              onPressed: () {
            // TODO: Implement delete confirmation and logic
          }),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      toolbarHeight: 120,
      backgroundColor: Colors.transparent,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFEF6A2A),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: BackButton(onPressed: () => context.pop()),
            ),
            const Align(
              alignment: Alignment.center,
              child: Text(
                'Team Created\nSuccessfully !',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamCard(BuildContext context, Team team) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: team.imageUrl != null
                      ? Image.network(
                          // Assuming imageUrl is a network URL now
                          team.imageUrl!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                          errorBuilder: (ctx, err, st) =>
                              const Icon(Icons.group_work, size: 100),
                        )
                      : const Icon(Icons.group_work, size: 100),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(team.name,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      _buildInfoRow(Icons.location_on, team.location),
                      _buildInfoRow(Icons.calendar_today, team.dateTime),
                      _buildInfoRow(Icons.people,
                          'Players Needed: ${team.playersNeeded}'),
                      _buildInfoRow(
                          Icons.phone, 'Contact: ${team.contactInfo}'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              team.description,
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFFEF6A2A), size: 16),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 12))),
        ],
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, String text,
      {required bool isPrimary, required VoidCallback onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary ? const Color(0xFFEF6A2A) : Colors.grey[800],
        foregroundColor: isPrimary ? Colors.white : Colors.red,
        padding: const EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      child: Text(text, style: const TextStyle(fontSize: 18)),
    );
  }
}

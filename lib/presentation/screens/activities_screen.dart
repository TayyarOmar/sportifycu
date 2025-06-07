import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sportify_flutter/presentation/providers/team_providers.dart';
import 'package:sportify_flutter/data/models/team_model.dart';
import 'package:sportify_flutter/core/constants/app_routes.dart';

class ActivitiesScreen extends ConsumerWidget {
  const ActivitiesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teamsAsyncValue = ref.watch(allTeamsProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Activities'),
        leading: BackButton(onPressed: () => context.pop()),
      ),
      body: teamsAsyncValue.when(
        data: (teams) {
          if (teams.isEmpty) {
            return const Center(child: Text('No activities found.'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: teams.length,
            itemBuilder: (context, index) {
              return _buildActivityCard(context, teams[index]);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }

  Widget _buildActivityCard(BuildContext context, Team team) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 20),
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(team.name,
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFF3A3A3A),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          team.dateTime,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
                if (team.imageUrl != null) ...[
                  const SizedBox(width: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.network(
                      team.imageUrl!,
                      width: 100,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (ctx, err, st) => Container(
                        width: 100,
                        height: 80,
                        color: Colors.grey[300],
                        child: const Icon(Icons.image,
                            size: 40, color: Colors.grey),
                      ),
                    ),
                  ),
                ]
              ],
            ),
            const Divider(height: 24, thickness: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.check_circle_outline,
                          color: Color(0xFFEF6A2A)),
                      label: const Text('Book Now',
                          style: TextStyle(color: Colors.black)),
                      style:
                          TextButton.styleFrom(foregroundColor: Colors.black)),
                ),
                const SizedBox(
                    height: 24, child: VerticalDivider(width: 1, thickness: 1)),
                Expanded(
                  child: TextButton.icon(
                      onPressed: () {
                        context.goNamed(AppRoutes.teamCreatedSuccess,
                            pathParameters: {'teamId': team.id.toString()});
                      },
                      icon: const Icon(Icons.info_outline,
                          color: Color(0xFFEF6A2A)),
                      label: const Text('Details',
                          style: TextStyle(color: Colors.black)),
                      style:
                          TextButton.styleFrom(foregroundColor: Colors.black)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

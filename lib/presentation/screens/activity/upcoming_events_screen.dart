import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportify_app/models/group_activity_team.dart';
import 'package:sportify_app/presentation/screens/activity/team_details_screen.dart';
import 'package:sportify_app/providers/group_activity_provider.dart';
import 'package:sportify_app/utils/app_colors.dart';
import 'package:sportify_app/utils/constants.dart';
import 'package:intl/intl.dart';

class UpcomingEventsScreen extends StatefulWidget {
  final String category;
  const UpcomingEventsScreen({super.key, required this.category});

  @override
  State<UpcomingEventsScreen> createState() => _UpcomingEventsScreenState();
}

class _UpcomingEventsScreenState extends State<UpcomingEventsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GroupActivityProvider>(context, listen: false)
          .fetchActiveTeams();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.category} Events'),
        backgroundColor: AppColors.background,
      ),
      body: Consumer<GroupActivityProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (provider.errorMessage != null) {
            return Center(child: Text('Error: ${provider.errorMessage}'));
          }

          final teams = provider.activeTeams
              .where((team) =>
                  team.category.toLowerCase() == widget.category.toLowerCase())
              .toList();

          if (teams.isEmpty) {
            return Center(
                child: Text('No upcoming events for ${widget.category} yet.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: teams.length,
            itemBuilder: (context, index) {
              final team = teams[index];
              return _buildTeamCard(context, team);
            },
          );
        },
      ),
    );
  }

  Widget _buildTeamCard(BuildContext context, GroupActivityTeam team) {
    final formattedDate =
        DateFormat('EEE, MMM d, yyyy - hh:mm a').format(team.dateAndTime);
    final isFull = team.currentPlayersCount >= team.playersNeeded;
    final spotsLeft = team.playersNeeded - team.currentPlayersCount;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      color: AppColors.secondary,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => TeamDetailsScreen(team: team),
          ));
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: team.photoUrl != null && team.photoUrl!.isNotEmpty
                    ? Image.network(
                        '${AppConstants.baseUrl}${team.photoUrl}',
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                            width: 80,
                            height: 80,
                            color: Colors.grey,
                            child:
                                const Icon(Icons.group, color: Colors.white)),
                      )
                    : Container(
                        width: 80,
                        height: 80,
                        color: Colors.grey,
                        child: const Icon(Icons.group, color: Colors.white)),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(team.name,
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 4),
                    Text(team.location,
                        style: const TextStyle(color: AppColors.textTertiary)),
                    const SizedBox(height: 4),
                    Text(formattedDate,
                        style: const TextStyle(color: AppColors.textTertiary)),
                    const SizedBox(height: 8),
                    Chip(
                      backgroundColor:
                          isFull ? Colors.red.shade900 : AppColors.primary,
                      label: Text(
                        isFull ? 'Full' : '$spotsLeft spots left',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

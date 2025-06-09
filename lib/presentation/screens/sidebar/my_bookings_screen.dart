import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportify_app/providers/group_activity_provider.dart';
import 'package:sportify_app/models/group_activity_team.dart';
import 'package:sportify_app/providers/auth_provider.dart';
import 'package:sportify_app/presentation/screens/activity/team_details_screen.dart';
import 'package:sportify_app/utils/app_colors.dart';
import 'package:intl/intl.dart';
import 'package:sportify_app/utils/constants.dart';

class MyBookingsScreen extends StatefulWidget {
  const MyBookingsScreen({super.key});

  @override
  State<MyBookingsScreen> createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider =
          Provider.of<GroupActivityProvider>(context, listen: false);
      provider.fetchUserBookings();
      provider.fetchActiveTeams(); // Also fetch all teams to find created ones
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bookings & Activities'),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: Consumer2<GroupActivityProvider, AuthProvider>(
        builder: (context, provider, authProvider, child) {
          if (provider.isLoading ||
              authProvider.user == null ||
              (provider.bookedTeams.isEmpty && provider.activeTeams.isEmpty)) {
            return const Center(child: CircularProgressIndicator());
          }
          if (provider.errorMessage != null) {
            return Center(child: Text('Error: ${provider.errorMessage}'));
          }

          final bookedTeams = provider.bookedTeams;
          final createdTeams = provider.activeTeams
              .where((team) => team.listerId == authProvider.user!.userId)
              .toList();

          // Combine and remove duplicates
          final allUserActivities =
              <GroupActivityTeam>{...bookedTeams, ...createdTeams}.toList();

          if (allUserActivities.isEmpty) {
            return const Center(
                child: Text('You have no booked or created activities yet.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: allUserActivities.length,
            itemBuilder: (context, index) {
              final team = allUserActivities[index];
              final bool isOwner = team.listerId == authProvider.user!.userId;
              return _buildBookingCard(context, team, isOwner);
            },
          );
        },
      ),
    );
  }

  Widget _buildBookingCard(
      BuildContext context, GroupActivityTeam team, bool isOwner) {
    final formattedDate =
        DateFormat('EEE, MMM d, yyyy - hh:mm a').format(team.dateAndTime);

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: team.photoUrl != null && team.photoUrl!.isNotEmpty
                        ? Image.network(
                            '${AppConstants.baseUrl}${team.photoUrl}',
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                                    width: 80,
                                    height: 80,
                                    color: Colors.grey,
                                    child: const Icon(Icons.group,
                                        color: Colors.white)),
                          )
                        : Container(
                            width: 80,
                            height: 80,
                            color: Colors.grey,
                            child:
                                const Icon(Icons.group, color: Colors.white)),
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
                            style:
                                const TextStyle(color: AppColors.textTertiary)),
                        const SizedBox(height: 4),
                        Text(formattedDate,
                            style:
                                const TextStyle(color: AppColors.textTertiary)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: Chip(
                  backgroundColor: isOwner
                      ? AppColors.primary.withOpacity(0.7)
                      : Colors.blue.shade900,
                  label: Text(
                    isOwner ? 'Created by you' : 'Booked',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sportify_app/models/group_activity_team.dart';
import 'package:sportify_app/providers/auth_provider.dart';
import 'package:sportify_app/providers/group_activity_provider.dart';
import 'package:sportify_app/presentation/screens/activity/edit_team_screen.dart';
import 'package:sportify_app/utils/app_colors.dart';
import 'package:sportify_app/utils/constants.dart';

class TeamDetailsScreen extends StatefulWidget {
  final GroupActivityTeam team;
  final bool isNewlyCreated;

  const TeamDetailsScreen(
      {super.key, required this.team, this.isNewlyCreated = false});

  @override
  State<TeamDetailsScreen> createState() => _TeamDetailsScreenState();
}

class _TeamDetailsScreenState extends State<TeamDetailsScreen> {
  late GroupActivityTeam _currentTeam;

  @override
  void initState() {
    super.initState();
    _currentTeam = widget.team;
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final bool isOwner = authProvider.isLoggedIn &&
        authProvider.user!.userId == _currentTeam.listerId;

    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.isNewlyCreated
                ? "Team Created\nSuccessfully !"
                : _currentTeam.name,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: widget.isNewlyCreated ? 28 : 22,
                height: 1.2)),
        backgroundColor: AppColors.primary,
        elevation: 0,
        toolbarHeight: widget.isNewlyCreated ? 150 : kToolbarHeight,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTeamCard(context),
            const SizedBox(height: 20),
            Text(
              _currentTeam.description,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            const Spacer(),
            if (isOwner) ...[
              ElevatedButton(
                onPressed: () async {
                  final updatedTeam =
                      await Navigator.of(context).push<GroupActivityTeam>(
                    MaterialPageRoute(
                      builder: (_) => EditTeamScreen(team: _currentTeam),
                    ),
                  );
                  if (updatedTeam != null) {
                    setState(() {
                      _currentTeam = updatedTeam;
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Edit'),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () =>
                    _showDeleteConfirmation(context, _currentTeam.teamId),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[800],
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Delete'),
              ),
            ] else ...[
              ElevatedButton(
                onPressed: () async {
                  final provider = Provider.of<GroupActivityProvider>(context,
                      listen: false);
                  final success = await provider.bookTeam(_currentTeam.teamId);
                  if (success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Successfully booked your spot!')),
                    );
                    Navigator.of(context).pop(); // Go back after booking
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(
                              'Failed to book: ${provider.errorMessage ?? 'Please try again'}')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Book Now'),
              )
            ],
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Future<void> _showDeleteConfirmation(
      BuildContext context, String teamId) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to delete this team?'),
                Text('This action cannot be undone.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
              onPressed: () async {
                final provider =
                    Provider.of<GroupActivityProvider>(context, listen: false);
                final success = await provider.deleteTeam(teamId);
                Navigator.of(context).pop(); // Close dialog
                if (success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Team deleted successfully.')),
                  );
                  Navigator.of(context).pop(); // Go back from details screen
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                            'Failed to delete team: ${provider.errorMessage}')),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildTeamCard(BuildContext context) {
    final formattedDate =
        DateFormat('EEE, MMM d').format(_currentTeam.dateAndTime);
    final formattedTime = DateFormat('h:mm a').format(_currentTeam.dateAndTime);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            if (_currentTeam.photoUrl != null &&
                _currentTeam.photoUrl!.isNotEmpty)
              Image.network(
                '${AppConstants.baseUrl}${_currentTeam.photoUrl}',
                height: 100,
                width: 100,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.group_work, size: 100),
              )
            else
              const Icon(Icons.group_work, size: 100),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_currentTeam.name,
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8),
                  _buildInfoRow(Icons.location_on, _currentTeam.location),
                  _buildInfoRow(
                      Icons.calendar_today, '$formattedDate - $formattedTime'),
                  _buildInfoRow(
                      Icons.group, 'Ages ${_currentTeam.ageRange ?? "Any"}'),
                  _buildInfoRow(Icons.person_add,
                      '${_currentTeam.playersNeeded - _currentTeam.currentPlayersCount} more needed'),
                  _buildInfoRow(Icons.phone, _currentTeam.contactInformation),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Icon(icon, size: 16, color: AppColors.primary),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 12))),
        ],
      ),
    );
  }
}

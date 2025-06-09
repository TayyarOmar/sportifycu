import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sportify_app/providers/auth_provider.dart';
import 'package:sportify_app/utils/app_colors.dart';
import 'package:sportify_app/models/user.dart'; // To get ActivityLog type
import 'dart:math';
import 'package:sportify_app/presentation/screens/sidebar/leaderboard_screen.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  double _getActivityValueForToday(
      List<dynamic> activities, String type, String unit) {
    final today = DateUtils.dateOnly(DateTime.now());
    final activity = activities.cast<Map<String, dynamic>>().firstWhere(
        (act) =>
            act['activity_type'] == type &&
            act['unit'] == unit &&
            DateUtils.dateOnly(DateTime.parse(act['date'])) == today,
        orElse: () => {'value': 0.0});
    return (activity['value'] as num).toDouble();
  }

  Future<void> _showLogActivityDialog(BuildContext context,
      AuthProvider authProvider, String activityType, String unit) async {
    final controller = TextEditingController();
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.secondary,
        title: Text('Log ${toBeginningOfSentenceCase(activityType)}'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          autofocus: true,
          decoration: InputDecoration(
            labelText: 'Value in $unit',
          ),
        ),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.of(ctx).pop(),
          ),
          ElevatedButton(
            child: const Text('Save'),
            onPressed: () {
              final value = double.tryParse(controller.text);
              if (value != null && value > 0) {
                authProvider.logActivity(activityType, value);
                Navigator.of(ctx).pop();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Please enter a valid positive number.')),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity'),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          if (authProvider.isLoading && authProvider.user == null) {
            return const Center(child: CircularProgressIndicator());
          }
          if (authProvider.user == null) {
            return const Center(child: Text('Could not load user data.'));
          }

          final user = authProvider.user!;
          final activities = user.trackedActivities;

          final steps = _getActivityValueForToday(activities, 'steps', 'steps');
          final gymTime =
              _getActivityValueForToday(activities, 'gym_time', 'minutes');
          final running =
              _getActivityValueForToday(activities, 'running', 'km');

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildActivityGrid(
                    context, authProvider, steps, gymTime, running),
                const SizedBox(height: 24),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => const LeaderboardScreen(),
                    ));
                  },
                  child: _buildScoreCard(user),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildActivityGrid(BuildContext context, AuthProvider authProvider,
      double steps, double gymTime, double running) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 0.9,
      children: [
        _ActivityCard(
          title: 'Steps',
          value: steps.toStringAsFixed(0),
          unit: 'steps',
          icon: Icons.directions_walk,
          color: AppColors.primary,
          onTap: () =>
              _showLogActivityDialog(context, authProvider, 'steps', 'steps'),
        ),
        _ActivityCard(
          title: 'Gym',
          value: gymTime.toStringAsFixed(0),
          unit: 'minutes',
          icon: Icons.fitness_center,
          color: Colors.orange,
          onTap: () => _showLogActivityDialog(
              context, authProvider, 'gym_time', 'minutes'),
        ),
        _ActivityCard(
          title: 'Run',
          value: running.toStringAsFixed(1),
          unit: 'km',
          icon: Icons.directions_run,
          color: Colors.blue,
          onTap: () =>
              _showLogActivityDialog(context, authProvider, 'running', 'km'),
        ),
        _ActivityCard(
          title: 'Calories',
          value: '0', // Placeholder
          unit: 'kcal',
          icon: Icons.local_fire_department,
          color: Colors.red,
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Calorie tracking coming soon!')),
            );
          },
        ),
      ],
    );
  }

  Widget _buildScoreCard(User user) {
    // This logic should exist on the backend, but for a quick UI representation, we can do a simple calc.
    // Let's use the fetched user's score if possible or calculate it.
    // The backend calculates the score. We need to get it from a user endpoint.
    // The `/api/v1/users/me/activity-tracking` endpoint returns the score.
    // Let's assume we need to add this to the `user` model or fetch it separately.
    // For now, let's do a mock calculation.
    double score = 0;
    user.trackedActivities.forEach((act) {
      if (act['activity_type'] == 'steps')
        score += (act['value'] as num) * 0.01;
      if (act['activity_type'] == 'gym_time')
        score += (act['value'] as num) * 1.5;
      if (act['activity_type'] == 'running')
        score += (act['value'] as num) * 10;
    });

    return Card(
      color: AppColors.secondary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Your Score',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text('Based on your activity',
                    style: TextStyle(color: AppColors.textTertiary)),
              ],
            ),
            Text(score.toStringAsFixed(0),
                style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary)),
          ],
        ),
      ),
    );
  }
}

class _ActivityCard extends StatelessWidget {
  final String title;
  final String value;
  final String unit;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _ActivityCard({
    required this.title,
    required this.value,
    required this.unit,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Card(
        color: AppColors.secondary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundColor: color.withOpacity(0.2),
                child: Icon(icon, color: color, size: 28),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500)),
                  Text(
                    value,
                    style: const TextStyle(
                        fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  Text(unit, style: TextStyle(color: AppColors.textTertiary)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

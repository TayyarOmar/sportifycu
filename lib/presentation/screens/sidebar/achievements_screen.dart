import 'package:flutter/material.dart';
import 'package:sportify_app/utils/app_colors.dart';

class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Achievements'),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          _MainAchievement(),
          SizedBox(height: 20),
          _AchievementItem(
            icon: Icons.run_circle_outlined,
            title: 'First 5K',
            subtitle: 'Complete your first 5-kilometer run/walk.',
            progress: 1.0,
            progressText: '5.00/5.00',
            isCompleted: true,
          ),
          _AchievementItem(
            // TODO: Use a better icon or image
            icon: Icons.fitness_center,
            title: 'Weekly Warrior',
            subtitle: 'Work out every day for a full week.',
            progress: 1.0,
            progressText: '7/7 Days',
            isCompleted: true,
          ),
          _AchievementItem(
            // TODO: Use a better icon or image
            icon: Icons.directions_bike,
            title: '100 KM Club',
            subtitle: 'Run, bike, or swim a total of 100 kilometers.',
            progress: 0.81,
            progressText: '81/100 KM',
            isCompleted: false,
          ),
        ],
      ),
    );
  }
}

class _MainAchievement extends StatelessWidget {
  const _MainAchievement();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Icon(Icons.emoji_events, size: 100, color: AppColors.primary),
        SizedBox(height: 8),
        Text('Achievements', style: TextStyle(fontSize: 24)),
      ],
    );
  }
}

class _AchievementItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final double progress;
  final String progressText;
  final bool isCompleted;

  const _AchievementItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.progress,
    required this.progressText,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.secondary,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Icon(icon, size: 40, color: AppColors.primary),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: Theme.of(context).textTheme.titleLarge),
                      Text(subtitle,
                          style:
                              const TextStyle(color: AppColors.textTertiary)),
                    ],
                  ),
                ),
                if (isCompleted)
                  const Icon(Icons.check_box, color: AppColors.primary)
                else
                  const Icon(Icons.check_box_outline_blank,
                      color: AppColors.textTertiary),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey[700],
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: 12),
                Text(progressText,
                    style: const TextStyle(color: AppColors.textTertiary)),
              ],
            )
          ],
        ),
      ),
    );
  }
}

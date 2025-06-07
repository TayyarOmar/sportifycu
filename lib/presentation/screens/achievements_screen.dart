import 'package:flutter/material.dart';

class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1E),
      appBar: AppBar(
        title:
            const Text('Achievements', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset(
              'assets/images/AchivmintsLogo.png',
              height: 150,
            ),
            const SizedBox(height: 30),
            _buildAchievementCard(
              context,
              icon: Icons.run_circle_outlined,
              iconBackgroundColor: const Color(0xFFFFEADD),
              iconColor: const Color(0xFFEF6A2A),
              title: 'First 5K',
              progressText: '5.00/5.00',
              description: 'Complete your first 5-kilometer run/walk.',
              progress: 1.0,
              isCompleted: true,
            ),
            _buildAchievementCard(
              context,
              icon: Icons.shield,
              iconBackgroundColor: const Color(0xFFE3F2FD),
              iconColor: Colors.blue,
              title: 'Weekly Warrior',
              progressText: '7/7 Days',
              description: 'Work out every day for a full week.',
              progress: 1.0,
              isCompleted: true,
            ),
            _buildAchievementCard(
              context,
              icon: Icons.emoji_events,
              iconBackgroundColor: const Color(0xFFE8F5E9),
              iconColor: Colors.green,
              title: '100 KM Club',
              progressText: '81/100 KM',
              description: 'Run, bike, or swim a total of 100 kilometers.',
              progress: 0.81,
              isCompleted: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAchievementCard(
    BuildContext context, {
    IconData? icon,
    String? imagePath,
    Color iconBackgroundColor = Colors.grey,
    Color iconColor = Colors.white,
    required String title,
    required String progressText,
    required String description,
    required double progress,
    required bool isCompleted,
  }) {
    return Card(
      color: const Color(0xFF2C2C2E),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            if (imagePath != null)
              Image.asset(
                imagePath,
                width: 50,
                height: 50,
                errorBuilder: (context, error, stackTrace) => CircleAvatar(
                  radius: 25,
                  backgroundColor: iconBackgroundColor,
                  child: Icon(icon, color: iconColor, size: 30),
                ),
              )
            else
              CircleAvatar(
                radius: 25,
                backgroundColor: iconBackgroundColor,
                child: Icon(icon, color: iconColor, size: 30),
              ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white)),
                      Text(progressText,
                          style: const TextStyle(
                              fontSize: 12, color: Colors.white70)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(description,
                      style:
                          const TextStyle(fontSize: 12, color: Colors.white70)),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.white.withOpacity(0.3),
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Color(0xFFEF6A2A)),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            if (isCompleted)
              const Icon(Icons.check_box, color: Color(0xFFEF6A2A))
            else
              const Icon(Icons.check_box_outline_blank, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

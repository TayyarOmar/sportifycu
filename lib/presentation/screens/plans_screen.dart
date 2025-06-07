import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_routes.dart';

class PlansScreen extends StatefulWidget {
  const PlansScreen({Key? key}) : super(key: key);

  @override
  _PlansScreenState createState() => _PlansScreenState();
}

class _PlansScreenState extends State<PlansScreen> {
  // State variables for user-editable values
  double _runValue = 6.2;
  int _stepsValue = 1200;
  int _gymHours = 2;
  int _caloriesValue = 2300;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1E),
      appBar: AppBar(
        title: const Text('Plans', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Activity Tracking',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Chip(
                    label: Text('Plan: weight lose'),
                    backgroundColor: Color(0xFFEF6A2A),
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Activity Score : 914',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => context.goNamed(AppRoutes.activityLeaderboard),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 7, 2, 0),
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: const Text('Activity Leaderboard'),
            ),
            const SizedBox(height: 20),
            _buildActivityCard(
              icon: Icons.run_circle_outlined,
              title: 'Run',
              progressText: '$_runValue/10 KM',
              progress: _runValue / 10,
              color: const Color(0xFFFFEADD),
              iconColor: const Color(0xFFEF6A2A),
              onTap: () => _showInputDialog(
                title: 'Update Run',
                initialValue: _runValue.toString(),
                isDecimal: true,
                onSave: (value) => setState(
                    () => _runValue = double.tryParse(value) ?? _runValue),
              ),
            ),
            _buildActivityCard(
              icon: Icons.directions_walk,
              title: 'Step',
              progressText: '$_stepsValue/8000 steps',
              progress: _stepsValue / 8000,
              color: const Color(0xFFFCE4EC),
              iconColor: Colors.pink,
              onTap: () => _showInputDialog(
                title: 'Update Steps',
                initialValue: _stepsValue.toString(),
                onSave: (value) => setState(
                    () => _stepsValue = int.tryParse(value) ?? _stepsValue),
              ),
            ),
            _buildActivityCard(
              icon: Icons.fitness_center,
              title: 'Gym',
              progressText: '$_gymHours/4 hours',
              progress: _gymHours / 4,
              color: const Color(0xFFE3F2FD),
              iconColor: Colors.blue,
              onTap: () => _showInputDialog(
                title: 'Update Gym Hours',
                initialValue: _gymHours.toString(),
                onSave: (value) => setState(
                    () => _gymHours = int.tryParse(value) ?? _gymHours),
              ),
            ),
            _buildActivityCard(
              icon: Icons.local_fire_department,
              title: 'Calories',
              progressText: '$_caloriesValue/5000 kcal',
              progress: _caloriesValue / 5000,
              color: Colors.orange.shade100,
              iconColor: Colors.orange,
              onTap: () => _showInputDialog(
                title: 'Update Calories',
                initialValue: _caloriesValue.toString(),
                onSave: (value) => setState(() =>
                    _caloriesValue = int.tryParse(value) ?? _caloriesValue),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showInputDialog({
    required String title,
    required String initialValue,
    required Function(String) onSave,
    bool isDecimal = false,
  }) async {
    final controller = TextEditingController(text: initialValue);
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF2C2C2E),
          title: Text(title, style: const TextStyle(color: Colors.white)),
          content: TextField(
            controller: controller,
            style: const TextStyle(color: Colors.white),
            keyboardType: isDecimal
                ? const TextInputType.numberWithOptions(decimal: true)
                : TextInputType.number,
            decoration: const InputDecoration(
              labelStyle: TextStyle(color: Colors.white70),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white54),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFEF6A2A)),
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child:
                  const Text('Cancel', style: TextStyle(color: Colors.white70)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Save',
                  style: TextStyle(color: Color(0xFFEF6A2A))),
              onPressed: () {
                onSave(controller.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildActivityCard({
    required IconData icon,
    required String title,
    required String progressText,
    required double progress,
    required Color color,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: const Color(0xFF2C2C2E),
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: color,
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
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.white.withOpacity(0.3),
                      valueColor: AlwaysStoppedAnimation<Color>(iconColor),
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

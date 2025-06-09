import 'package:flutter/material.dart';
import 'package:sportify_app/utils/app_colors.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool _isToggled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: AppColors.background,
        elevation: 0,
        actions: [
          Switch(
            value: _isToggled,
            onChanged: (value) {
              setState(() {
                _isToggled = value;
              });
            },
            activeColor: AppColors.primary,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          _NotificationItem(
            title: 'New Update',
            subtitle: 'Update Available',
          ),
          _NotificationItem(
            title: 'Reminder',
            subtitle: 'Class starts at 9:00 am',
          ),
          _NotificationItem(
            title: 'Class Booked',
            subtitle: 'Class booking confirmed',
          ),
          _NotificationItem(
            title: 'Notification',
            subtitle: '1 New Notification',
          ),
          _NotificationItem(
            title: 'Confirmation',
            subtitle: 'Please confirm you email',
          ),
        ],
      ),
    );
  }
}

class _NotificationItem extends StatelessWidget {
  final String title;
  final String subtitle;

  const _NotificationItem({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.secondary,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle,
            style: const TextStyle(color: AppColors.textTertiary)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          // TODO: Handle notification tap
        },
      ),
    );
  }
}

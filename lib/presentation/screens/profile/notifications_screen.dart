import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportify_app/providers/notification_provider.dart';
import 'package:sportify_app/models/app_notification.dart';
import 'package:sportify_app/utils/app_colors.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationProvider>(
      builder: (context, notifProvider, child) {
        final notifications = notifProvider.notifications;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Notifications'),
            backgroundColor: AppColors.background,
            elevation: 0,
            actions: [
              Switch(
                value: notifProvider.notificationsEnabled,
                onChanged: (value) {
                  notifProvider.toggleNotifications(value);
                },
                activeColor: AppColors.primary,
              ),
            ],
          ),
          body: notifications.isEmpty
              ? const Center(child: Text('No notifications yet.'))
              : ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    final n = notifications[index];
                    return _NotificationItem(
                      notification: n,
                    );
                  },
                ),
        );
      },
    );
  }
}

class _NotificationItem extends StatefulWidget {
  final AppNotification notification;
  const _NotificationItem({required this.notification});

  @override
  State<_NotificationItem> createState() => _NotificationItemState();
}

class _NotificationItemState extends State<_NotificationItem> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final notifProvider =
        Provider.of<NotificationProvider>(context, listen: false);
    final n = widget.notification;
    return Card(
      color: AppColors.secondary,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          ListTile(
            title: Text(n.title,
                style: TextStyle(
                    fontWeight:
                        n.isRead ? FontWeight.normal : FontWeight.bold)),
            subtitle: Text(n.message,
                style: const TextStyle(color: AppColors.textTertiary)),
            trailing: Icon(
                _expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                size: 20),
            onTap: () {
              setState(() {
                _expanded = !_expanded;
              });
              if (!n.isRead) notifProvider.markAsRead(n.id);
            },
          ),
          if (_expanded)
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.shade800),
                      onPressed: () {
                        notifProvider.removeNotification(n.id);
                      },
                      child: const Text('Remove'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        notifProvider.postponeNotification(
                            n.id, const Duration(hours: 1));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Notification postponed 1 hour.')),
                        );
                      },
                      child: const Text('Postpone'),
                    ),
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
}

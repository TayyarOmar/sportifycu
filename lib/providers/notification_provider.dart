import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../models/app_notification.dart';

class NotificationProvider with ChangeNotifier {
  final List<AppNotification> _notifications = [];
  bool _notificationsEnabled = true;

  // Local notifications plugin
  final FlutterLocalNotificationsPlugin _localPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationProvider() {
    _initializeLocalPlugin();
  }

  Future<void> _initializeLocalPlugin() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initSettings =
        InitializationSettings(android: androidSettings);
    await _localPlugin.initialize(initSettings);
  }

  List<AppNotification> get notifications =>
      List.unmodifiable(_notifications.reversed);

  bool get notificationsEnabled => _notificationsEnabled;

  int get unreadCount => _notifications.where((n) => !n.isRead).length;

  void addNotification(String title, String message) {
    if (!_notificationsEnabled) return;
    final notif = AppNotification(
      id: const Uuid().v4(),
      title: title,
      message: message,
      timestamp: DateTime.now(),
    );
    _notifications.add(notif);
    _showLocalNotification(notif);
    notifyListeners();
  }

  Future<void> _showLocalNotification(AppNotification n) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'sportify_channel',
      'Sportify Notifications',
      channelDescription: 'In-app notifications',
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
    );
    const NotificationDetails details =
        NotificationDetails(android: androidDetails);
    await _localPlugin.show(0, n.title, n.message, details);
  }

  void markAsRead(String id) {
    final idx = _notifications.indexWhere((n) => n.id == id);
    if (idx != -1) {
      _notifications[idx] = _notifications[idx].copyWith(isRead: true);
      notifyListeners();
    }
  }

  void removeNotification(String id) {
    _notifications.removeWhere((n) => n.id == id);
    notifyListeners();
  }

  void postponeNotification(String id, Duration by) {
    final idx = _notifications.indexWhere((n) => n.id == id);
    if (idx != -1) {
      final n = _notifications[idx];
      _notifications[idx] = n.copyWith(timestamp: n.timestamp.add(by));
      notifyListeners();
    }
  }

  void clear() {
    _notifications.clear();
    notifyListeners();
  }

  void toggleNotifications(bool value) {
    _notificationsEnabled = value;
    notifyListeners();
  }
}

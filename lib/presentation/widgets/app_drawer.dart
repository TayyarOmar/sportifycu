import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/auth_state_provider.dart';

import '../../core/constants/app_routes.dart';

class AppDrawer extends ConsumerWidget {
  const AppDrawer({super.key});

  void _navigateTo(BuildContext context, String route) {
    Navigator.of(context).pop();
    context.pushNamed(route);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFFEF6A2A),
            ),
            child: Text(
              'Sportify',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.fitness_center),
            title: const Text('Gyms'),
            onTap: () => _navigateTo(context, AppRoutes.gyms),
          ),
          ListTile(
            leading: const Icon(Icons.assignment),
            title: const Text('Plans'),
            onTap: () => _navigateTo(context, AppRoutes.plans),
          ),
          ListTile(
            leading: const Icon(Icons.group),
            title: const Text('Group Activities'),
            onTap: () => _navigateTo(context, AppRoutes.groupActivities),
          ),
          ListTile(
            leading: const Icon(Icons.leaderboard),
            title: const Text('Activity Leaderboard'),
            onTap: () => _navigateTo(context, AppRoutes.activityLeaderboard),
          ),
          ListTile(
            leading: const Icon(Icons.bookmark),
            title: const Text('My Bookings'),
            onTap: () {
              // TODO: Implement navigation to My Bookings
            },
          ),
          ListTile(
            leading: const Icon(Icons.emoji_events),
            title: const Text('Achievements'),
            onTap: () => _navigateTo(context, AppRoutes.achievements),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () => _navigateTo(context, AppRoutes.settings),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () async {
              await ref.read(authNotifierProvider.notifier).logout();
              // ignore: use_build_context_synchronously
              if (context.mounted) {
                context.goNamed(AppRoutes.authOptions);
              }
            },
          ),
        ],
      ),
    );
  }
}

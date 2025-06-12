import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportify_app/providers/auth_provider.dart';
import 'package:sportify_app/presentation/screens/sidebar/achievements_screen.dart';
import 'package:sportify_app/presentation/screens/sidebar/activity_screen.dart';
import 'package:sportify_app/presentation/screens/sidebar/faq_screen.dart';
import 'package:sportify_app/presentation/screens/sidebar/my_bookings_screen.dart';
import 'package:sportify_app/utils/app_colors.dart';
import 'package:sportify_app/presentation/screens/search_screen.dart';
import 'package:sportify_app/presentation/screens/profile/profile_screen.dart';
import 'package:sportify_app/presentation/screens/sidebar/leaderboard_screen.dart';
import 'package:sportify_app/presentation/screens/activity/group_activities_screen.dart';
import 'package:sportify_app/presentation/screens/sidebar/ai_coach_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.background,
      child: Column(
        children: [
          _buildDrawerHeader(context),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _DrawerItem(
                  icon: Icons.fitness_center,
                  title: 'Gyms',
                  onTap: () {
                    Navigator.pop(context); // Close drawer
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => const SearchScreen(),
                    ));
                  },
                ),
                _DrawerItem(
                  icon: Icons.directions_run,
                  title: 'Activities',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => const ActivityScreen(),
                    ));
                  },
                ),
                _DrawerItem(
                  icon: Icons.groups,
                  title: 'Group Activities',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => const GroupActivitiesScreen(),
                    ));
                  },
                ),
                _DrawerItem(
                  icon: Icons.chat_bubble_outline,
                  title: 'AI Coach',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => const AiCoachScreen(),
                    ));
                  },
                ),
                _DrawerItem(
                  icon: Icons.book_online,
                  title: 'My bookings',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => const MyBookingsScreen(),
                    ));
                  },
                ),
                _DrawerItem(
                  icon: Icons.emoji_events,
                  title: 'Achievements',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => const AchievementsScreen(),
                    ));
                  },
                ),
              ],
            ),
          ),
          const Divider(color: AppColors.textTertiary),
          _DrawerItem(
            title: 'Need help?',
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => const FaqScreen(),
              ));
            },
          ),
          _DrawerItem(
            title: 'Log out',
            onTap: () async {
              // Close the drawer first to avoid UI issues
              Navigator.of(context).pop();
              // Perform logout
              await Provider.of<AuthProvider>(context, listen: false).logout();
              // Navigate to welcome screen and remove all previous routes
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/welcome', (route) => false);
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildDrawerHeader(BuildContext context) {
    // This is a placeholder header.
    // The design shows the hamburger menu on a screen that already has a user context.
    return const SizedBox(height: 60);
  }
}

class _DrawerItem extends StatelessWidget {
  final String title;
  final IconData? icon;
  final VoidCallback onTap;

  const _DrawerItem({required this.title, this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon != null ? Icon(icon, color: Colors.white) : null,
      title: Text(title,
          style: const TextStyle(color: Colors.white, fontSize: 16)),
      onTap: onTap,
    );
  }
}

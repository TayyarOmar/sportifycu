import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportify_app/providers/auth_provider.dart';
import 'package:sportify_app/utils/app_colors.dart';
import 'package:sportify_app/presentation/screens/profile/notifications_screen.dart';
import 'package:sportify_app/presentation/screens/profile/favorite_facilities_screen.dart';
import 'package:sportify_app/presentation/screens/profile/edit_profile_screen.dart';
import 'package:sportify_app/presentation/screens/profile/settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          final user = authProvider.user;
          return ListView(
            padding: EdgeInsets.zero,
            children: [
              _buildProfileHeader(context, user?.name ?? 'Guest'),
              const SizedBox(height: 20),
              _buildSection(
                context,
                title: 'Your account',
                items: [
                  _ProfileMenuItem(
                    icon: Icons.person_outline,
                    title: 'Personal Information',
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => const EditProfileScreen(),
                      ));
                    },
                  ),
                  _ProfileMenuItem(
                    icon: Icons.notifications_none,
                    title: 'Notifications',
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => const NotificationsScreen(),
                      ));
                    },
                  ),
                  _ProfileMenuItem(
                    icon: Icons.bookmark_border,
                    title: 'Favorite Facilities',
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => const FavoriteFacilitiesScreen(),
                      ));
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _buildSection(
                context,
                title: 'Preferences',
                items: [
                  _ProfileMenuItem(
                    icon: Icons.settings_outlined,
                    title: 'Settings',
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => const SettingsScreen(),
                      ));
                    },
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, String name) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 60, 24, 24),
      color: AppColors.primary,
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            child: Icon(Icons.person,
                size: 40, color: Theme.of(context).colorScheme.secondary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: Colors.white70),
                ),
                Text(
                  name,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => const EditProfileScreen(),
              ));
            },
          )
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context,
      {required String title, required List<Widget> items}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: items
                  .map((item) => Column(
                        children: [
                          item,
                          if (item != items.last)
                            const Divider(height: 1, indent: 16, endIndent: 16)
                        ],
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _ProfileMenuItem(
      {required this.icon, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}

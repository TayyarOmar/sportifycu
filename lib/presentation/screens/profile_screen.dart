import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_routes.dart';
import '../../presentation/providers/user_profile_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final userProfile = ref.watch(userProfileProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1E), // Dark background color
      body: userProfile.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error) => Center(child: Text('Error: $error')),
        loaded: (user) => _buildProfileView(context, theme, user),
        initial: () => _buildProfileView(context, theme, null),
      ),
    );
  }

  Widget _buildProfileView(
      BuildContext context, ThemeData theme, dynamic user) {
    final String name = user?.name ?? 'Guest';
    final bool isGuest = user == null;

    return Column(
      children: [
        _buildProfileHeader(context, theme, name, isGuest),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              _buildSectionTitle(theme, 'Your account'),
              const SizedBox(height: 10),
              _buildProfileOption(
                context,
                icon: Icons.person_outline,
                title: 'Personal Information',
                onTap: () => context.goNamed(AppRoutes.personalInfo),
              ),
              _buildProfileOption(
                context,
                icon: Icons.notifications_none,
                title: 'Notifications',
                onTap: () => context.goNamed(AppRoutes.notifications),
              ),
              _buildProfileOption(
                context,
                icon: Icons.favorite_border,
                title: 'Favorite Facilities',
                onTap: () => context.goNamed(AppRoutes.favorites),
              ),
              const SizedBox(height: 30),
              _buildSectionTitle(theme, 'Settings'),
              const SizedBox(height: 10),
              _buildProfileOption(
                context,
                icon: Icons.settings_outlined,
                title: 'Settings',
                onTap: () => context.goNamed(AppRoutes.settings),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildProfileHeader(
      BuildContext context, ThemeData theme, String name, bool isGuest) {
    return Container(
      padding: const EdgeInsets.only(top: 60, bottom: 30, left: 20, right: 20),
      decoration: BoxDecoration(
        color: theme.primaryColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 35,
            backgroundColor: Colors.white,
            child: Icon(Icons.person, size: 40, color: Colors.grey),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome $name',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                if (!isGuest)
                  TextButton(
                    onPressed: () {
                      // TODO: Navigate to an edit profile screen
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      alignment: Alignment.centerLeft,
                    ),
                    child: const Text(
                      'Edit',
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                  ),
                if (isGuest)
                  const Text(
                    'Login to access your account',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSectionTitle(ThemeData theme, String title) {
    return Text(
      title,
      style: theme.textTheme.titleMedium?.copyWith(
        color: Colors.grey[400],
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildProfileOption(BuildContext context,
      {required IconData icon,
      required String title,
      required VoidCallback onTap}) {
    final theme = Theme.of(context);
    return Card(
      color: const Color(0xFF2C2C2E),
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: Icon(icon, color: theme.primaryColor),
        title: Text(title, style: const TextStyle(color: Colors.white)),
        trailing:
            const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
        onTap: onTap,
      ),
    );
  }
}

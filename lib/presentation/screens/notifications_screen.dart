import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_state_provider.dart';
import '../providers/user_profile_provider.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final userProfileState = ref.watch(userProfileProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        leading: BackButton(color: theme.primaryColor),
      ),
      body: userProfileState.when(
        initial: () => const Center(child: Text('No profile data.')),
        loading: () => const Center(child: CircularProgressIndicator()),
        loaded: (user) {
          return ListView(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            children: [
              SwitchListTile(
                title: const Text('Enable All Notifications'),
                subtitle: const Text('Receive alerts for bookings and updates'),
                value: user.notificationSetting,
                onChanged: (bool value) {
                  ref
                      .read(authNotifierProvider.notifier)
                      .updateNotificationSetting(value);
                },
                activeColor: theme.primaryColor,
                secondary: const Icon(Icons.notifications_active_outlined),
              ),
            ],
          );
        },
        error: (message) => Center(child: Text(message)),
      ),
    );
  }
}

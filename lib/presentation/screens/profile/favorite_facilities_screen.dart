import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportify_app/providers/auth_provider.dart';
import 'package:sportify_app/providers/gym_provider.dart';
import 'package:sportify_app/models/gym.dart';
import 'package:sportify_app/presentation/screens/gym_details_screen.dart';
import 'package:sportify_app/utils/app_colors.dart';

class FavoriteFacilitiesScreen extends StatefulWidget {
  const FavoriteFacilitiesScreen({super.key});

  @override
  State<FavoriteFacilitiesScreen> createState() =>
      _FavoriteFacilitiesScreenState();
}

class _FavoriteFacilitiesScreenState extends State<FavoriteFacilitiesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GymProvider>(context, listen: false).fetchAllGyms();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Facilities'),
        backgroundColor: AppColors.background,
      ),
      body: Consumer2<AuthProvider, GymProvider>(
        builder: (context, authProvider, gymProvider, child) {
          // State 1: User data is not available yet.
          if (authProvider.user == null) {
            return const Center(child: CircularProgressIndicator());
          }

          // State 2: Gyms are being fetched.
          if (gymProvider.isLoadingAll) {
            return const Center(child: CircularProgressIndicator());
          }

          // State 3: Error fetching gyms.
          if (gymProvider.errorMessage != null) {
            return Center(child: Text('Error: ${gymProvider.errorMessage}'));
          }

          final favoriteGymIds = authProvider.user!.favourites;

          // State 4: User has no favorites.
          if (favoriteGymIds.isEmpty) {
            return const Center(child: Text('You have no favorite gyms yet.'));
          }

          final favoriteGyms = gymProvider.allGyms
              .where((gym) => favoriteGymIds.contains(gym.gymId))
              .toList();

          // State 5: User has favorites, but gym list hasn't loaded them yet
          // or they don't exist in the allGyms list for some reason.
          if (favoriteGyms.isEmpty) {
            // This can happen if allGyms is empty or doesn't contain the favorited gym.
            // It could be a transient state or an data consistency issue.
            return const Center(
                child: Text("Could not find details for your favorite gyms."));
          }

          // State 6: Display the list of favorite gyms.
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: favoriteGyms.length,
            itemBuilder: (context, index) {
              final gym = favoriteGyms[index];
              return _GymListItem(gym: gym);
            },
          );
        },
      ),
    );
  }
}

class _GymListItem extends StatelessWidget {
  final Gym gym;
  const _GymListItem({required this.gym});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.secondary,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(gym.name),
        subtitle: Text(gym.location),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => GymDetailsScreen(gym: gym),
          ));
        },
      ),
    );
  }
}

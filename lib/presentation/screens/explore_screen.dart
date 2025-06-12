import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sportify_app/models/gym.dart';
import 'package:sportify_app/presentation/screens/gym_details_screen.dart';
import 'package:sportify_app/utils/app_colors.dart';
import 'package:sportify_app/utils/dummy_data.dart'; // To get gym coordinates
import 'package:provider/provider.dart';
import 'package:sportify_app/providers/gym_provider.dart';
import 'package:sportify_app/providers/auth_provider.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  // Center of Amman, Jordan as a default location
  static const LatLng _ammanCenter = LatLng(31.9539, 35.9106);

  final Set<Marker> _markers = {};

  final List<_StaticGym> _staticGyms = [
    _StaticGym(
      gymId: '3', // Gold's Gym ID
      name: 'Gold\'s Gym',
      location: 'Amman',
      imagePath: 'assets/images/GoldsGymExplore.png',
      coords: LatLng(
        getDummyGymData('3')['location']['lat'],
        getDummyGymData('3')['location']['lon'],
      ),
    ),
    _StaticGym(
      gymId: '1', // Grams Gym ID
      name: 'Grams Gym 24/7',
      location: 'Amman',
      imagePath: 'assets/images/GramsGymExplore.png',
      coords: LatLng(
        getDummyGymData('1')['location']['lat'],
        getDummyGymData('1')['location']['lon'],
      ),
    ),
    _StaticGym(
      gymId: '2', // X Gym ID
      name: 'X Gym',
      location: 'Amman',
      imagePath: 'assets/images/Xgymcover.jpg',
      coords: LatLng(
        getDummyGymData('2')['location']['lat'],
        getDummyGymData('2')['location']['lon'],
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _createMarkers();
  }

  void _createMarkers() {
    for (final gym in _staticGyms) {
      _markers.add(
        Marker(
          markerId: MarkerId(gym.gymId),
          position: gym.coords,
          infoWindow: InfoWindow(title: gym.name),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Explore Gyms'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildMap(),
            _buildGymList(),
          ],
        ),
      ),
    );
  }

  Widget _buildMap() {
    return SizedBox(
      height: 300,
      child: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: _ammanCenter,
          zoom: 11.5,
        ),
        markers: _markers,
        myLocationButtonEnabled: false,
      ),
    );
  }

  Widget _buildGymList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16.0),
      itemCount: _staticGyms.length,
      itemBuilder: (context, index) {
        final gym = _staticGyms[index];
        return _GymCard(gym: gym);
      },
    );
  }
}

class _StaticGym {
  final String gymId;
  final String name;
  final String location;
  final String imagePath;
  final LatLng coords;

  _StaticGym({
    required this.gymId,
    required this.name,
    required this.location,
    required this.imagePath,
    required this.coords,
  });
}

class _GymCard extends StatelessWidget {
  final _StaticGym gym;

  const _GymCard({required this.gym});

  @override
  Widget build(BuildContext context) {
    String? _resolveBackendGymId(BuildContext ctx) {
      final allGyms = Provider.of<GymProvider>(ctx, listen: false).allGyms;
      final staticLower = gym.name.toLowerCase();
      for (final g in allGyms) {
        final dbLower = g.name.toLowerCase();
        if (dbLower.contains(staticLower) || staticLower.contains(dbLower)) {
          return g.gymId;
        }
      }
      return null;
    }

    void _toggleFavourite(BuildContext ctx) async {
      final authProvider = Provider.of<AuthProvider>(ctx, listen: false);
      if (!authProvider.isLoggedIn) {
        ScaffoldMessenger.of(ctx).showSnackBar(
          const SnackBar(content: Text('Please log in to add favourites.')),
        );
        return;
      }

      final gymProvider = Provider.of<GymProvider>(ctx, listen: false);
      if (gymProvider.allGyms.isEmpty) {
        await gymProvider.fetchAllGyms();
      }

      String? backendId = _resolveBackendGymId(ctx);
      if (backendId == null) {
        ScaffoldMessenger.of(ctx).showSnackBar(
          const SnackBar(content: Text('Gym not found on server.')),
        );
        return;
      }

      final isFav = authProvider.user!.favourites.contains(backendId);
      if (isFav) {
        await authProvider.removeFavorite(backendId);
        ScaffoldMessenger.of(ctx).showSnackBar(
            const SnackBar(content: Text('Removed from favourites.')));
      } else {
        await authProvider.addFavorite(backendId);
        ScaffoldMessenger.of(ctx).showSnackBar(
            const SnackBar(content: Text('Added to favourites!')));
      }
    }

    return Consumer2<AuthProvider, GymProvider>(
      builder: (context, authProvider, gymProvider, child) {
        final backendId = _resolveBackendGymId(context);
        final isFavorite = backendId != null &&
            authProvider.user?.favourites.contains(backendId) == true;

        return GestureDetector(
          onTap: () {
            final gymForNav = Gym(
              gymId: gym.gymId,
              name: gym.name,
              location: gym.location,
              services: [],
              gendersAccepted: [],
              subscriptions: [],
            );
            Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => GymDetailsScreen(gym: gymForNav),
            ));
          },
          child: Card(
            margin: const EdgeInsets.only(bottom: 24.0),
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: SizedBox(
              height: 250,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    gym.imagePath,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.0),
                          Colors.black.withOpacity(0.8),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () => _toggleFavourite(context),
                      child: CircleAvatar(
                        backgroundColor: Colors.black54,
                        child: Icon(
                          isFavorite ? Icons.bookmark : Icons.bookmark_border,
                          color: isFavorite ? AppColors.primary : Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    right: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            gym.name,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(Icons.location_on,
                                color: Colors.white, size: 18),
                            const SizedBox(width: 4),
                            Text(
                              gym.location,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

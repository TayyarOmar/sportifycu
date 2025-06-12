import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportify_app/providers/auth_provider.dart';
import 'package:sportify_app/providers/gym_provider.dart';
import 'package:sportify_app/presentation/screens/search_screen.dart';
import 'package:sportify_app/utils/app_colors.dart';
import 'package:sportify_app/models/gym.dart';
import 'package:sportify_app/presentation/screens/gym_details_screen.dart';
import 'package:sportify_app/presentation/screens/profile/notifications_screen.dart';
import 'package:sportify_app/providers/notification_provider.dart';
import 'package:sportify_app/presentation/screens/sidebar/ai_coach_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final gymProv = Provider.of<GymProvider>(context, listen: false);
      if (gymProv.allGyms.isEmpty) {
        gymProv.fetchAllGyms();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => const SearchScreen()));
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.secondary,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                const Icon(Icons.search, color: AppColors.textTertiary),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Gyms, Services & Activities',
                    style:
                        TextStyle(color: AppColors.textTertiary, fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          Consumer<NotificationProvider>(
            builder: (context, notifProv, _) {
              return Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.notifications_none),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => const NotificationsScreen(),
                      ));
                    },
                  ),
                  if (notifProv.unreadCount > 0)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        constraints:
                            const BoxConstraints(minWidth: 16, minHeight: 16),
                        child: Text(
                          notifProv.unreadCount > 9
                              ? '9+'
                              : notifProv.unreadCount.toString(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 10),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                _buildAdsCarousel(),
                const SizedBox(height: 24),
                const _SectionTitle(title: 'Around you'),
                const SizedBox(height: 16),
                _buildStaticNearbyGyms(),
                const SizedBox(height: 24),
                const _SectionTitle(title: 'Activities'),
                const SizedBox(height: 16),
                _buildActivitiesSection(),
                const SizedBox(height: 24),
              ],
            ),
          ),
          Positioned(
            bottom: 32,
            right: 24,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const AiCoachScreen()),
                );
              },
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Material(
                    elevation: 6,
                    shape: const CircleBorder(),
                    color: AppColors.primary,
                    child: Container(
                      width: 56,
                      height: 56,
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.smart_toy, // AI/robot icon
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 60,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 6,
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                      child: const Text(
                        'AI Coach Chat',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdsCarousel() {
    // TODO: Replace with dynamic ads from an API
    final List<String> adImages = [
      'assets/images/GoldsGymHomePageAdd.png',
      'assets/images/GramsGymHomePageAdd.png',
    ];

    return CarouselSlider(
      options: CarouselOptions(
        height: 200.0,
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 16 / 9,
        viewportFraction: 0.9,
      ),
      items: adImages.map((imagePath) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildStaticNearbyGyms() {
    final staticGyms = [
      _StaticGym(
          gymId: '2',
          name: 'X Gym',
          location: 'Aqaba',
          imagePath: 'assets/images/Xgymcover.jpg'),
      _StaticGym(
          gymId: '3',
          name: 'Gold\'s Gym',
          location: 'Amman',
          imagePath: 'assets/images/GoldsGymExplore.png'),
      _StaticGym(
          gymId: '1',
          name: 'Grams Gym',
          location: 'Irbid',
          imagePath: 'assets/images/GramsGymExplore.png'),
    ];

    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: staticGyms.length,
        itemBuilder: (context, index) {
          final gym = staticGyms[index];
          return _GymCard(gym: gym);
        },
      ),
    );
  }

  Widget _buildActivitiesSection() {
    // TODO: Replace with dynamic activities from API
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: const DecorationImage(
            image: AssetImage('assets/images/ActivitiesHomePage.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .titleLarge
            ?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _StaticGym {
  final String gymId;
  final String name;
  final String location;
  final String imagePath;

  _StaticGym(
      {required this.gymId,
      required this.name,
      required this.location,
      required this.imagePath});
}

class _GymCard extends StatelessWidget {
  final _StaticGym gym;

  const _GymCard({required this.gym});

  @override
  Widget build(BuildContext context) {
    // Helper to resolve backend gymId by name
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
      final notifProvider =
          Provider.of<NotificationProvider>(ctx, listen: false);

      if (isFav) {
        await authProvider.removeFavorite(backendId);
        notifProvider.addNotification(
            'Gym Unfavorited', '${gym.name} removed from your favourites');
        ScaffoldMessenger.of(ctx).showSnackBar(
            const SnackBar(content: Text('Removed from favourites.')));
      } else {
        await authProvider.addFavorite(backendId);
        notifProvider.addNotification(
            'Gym Favorited', '${gym.name} added to your favourites');
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
            clipBehavior: Clip.antiAlias,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: SizedBox(
              width: 250,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    gym.imagePath,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.7),
                          Colors.transparent,
                          Colors.black.withOpacity(0.7)
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  // Favourite icon
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
                  // Name and location overlay
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(gym.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(color: Colors.white)),
                          Text(gym.location,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(color: Colors.white70)),
                        ],
                      ),
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

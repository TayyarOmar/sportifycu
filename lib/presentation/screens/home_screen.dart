// lib/presentation/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
// For navigation

// Placeholder data models
class AdBanner {
  final String imagePath;
  AdBanner(this.imagePath);
}

class Gym {
  final String id;
  final String name;
  final String imagePath;
  final String location; // e.g., "Amman"
  Gym(
      {required this.id,
      required this.name,
      required this.imagePath,
      required this.location});
}

class Activity {
  final String name;
  final String imagePath;
  final String details; // e.g., "Amman/Aqaba"
  Activity(
      {required this.name, required this.imagePath, required this.details});
}

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  final double _carouselImageHeight = 200.0;
  final double _aroundYouImageHeight = 150.0;
  final double _activityImageHeight = 180.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final Color primaryColor = theme.primaryColor; // Use theme's primary color

    // Placeholder data
    final List<AdBanner> adBanners = [
      AdBanner('assets/images/GoldsGymHomePageAdd.png'),
      AdBanner('assets/images/GramsGymHomePageAdd.png'),
    ];

    final List<Gym> aroundYouGyms = [
      Gym(
          id: 'grams_gym',
          name: 'Grams Gym',
          imagePath: 'assets/images/GramsGymExplore.png',
          location: 'Amman'),
      Gym(
          id: 'x_gym',
          name: 'X Gym',
          imagePath: 'assets/images/XGymNearYou.png',
          location: 'Amman'),
      Gym(
          id: 'golds_gym',
          name: 'Gold\'s Gym',
          imagePath: 'assets/images/GoldsGymHomePageAdd.png',
          location: 'Amman'),
      // Add more gyms if available
    ];

    final List<Activity> activities = [
      Activity(
          name: 'RUN JORDAN',
          imagePath: 'assets/images/ActivitiesHomePage.png',
          details: 'Amman/Aqaba'),
      // Add more activities
    ];

    return Container(
      color: const Color(0xFF222222), // Dark background
      child: ListView(
        children: [
          // Top Ad Carousel
          if (adBanners.isNotEmpty)
            CarouselSlider(
              options: CarouselOptions(
                height: _carouselImageHeight,
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 16 / 9, // Common aspect ratio
                viewportFraction: 0.9, // Show parts of adjacent images
                onPageChanged: (index, reason) {
                  // Optional: handle page change
                },
              ),
              items: adBanners.map((banner) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 5.0, vertical: 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        image: DecorationImage(
                          image: AssetImage(banner.imagePath),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),

          // Dots indicator for Carousel (simple implementation)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(adBanners.length, (index) {
              // This needs to be tied to the CarouselController's current page for dynamic updates
              // For simplicity, it's static now.
              return Container(
                width: 8.0,
                height: 8.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : primaryColor)
                      .withOpacity(
                          0.4), // Placeholder, update with active state
                ),
              );
            }),
          ),

          // "Around you" Section
          _buildSectionTitle(context, 'Around you'),
          SizedBox(
            height: _aroundYouImageHeight + 60, // Image height + text + padding
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: aroundYouGyms.length,
              itemBuilder: (context, index) {
                final gym = aroundYouGyms[index];
                return _buildGymCard(context, gym);
              },
            ),
          ),

          // "Activities" Section
          _buildSectionTitle(context, 'Activities'),
          SizedBox(
            height: _activityImageHeight + 60, // Image height + text + padding
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount:
                  activities.length, // Assuming you have an activities list
              itemBuilder: (context, index) {
                final activity = activities[index];
                return _buildActivityCard(context, activity);
              },
            ),
          ),
          const SizedBox(height: 20), // Padding at the bottom
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).primaryColor, // Orange color
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  Widget _buildGymCard(BuildContext context, Gym gym) {
    return GestureDetector(
      onTap: () {
        context.go('/gyms/details/${gym.id}');
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.6, // Adjust card width
        margin: const EdgeInsets.only(right: 12.0),
        decoration: BoxDecoration(
          color: const Color(0xFF2C2C2C), // Slightly lighter than background
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(15.0)),
                child: Image.asset(
                  gym.imagePath,
                  height: _aroundYouImageHeight,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Center(
                      child: Icon(Icons.image_not_supported,
                          color: Colors.grey, size: 50)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    gym.name,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined,
                          color: Colors.grey[400], size: 14),
                      const SizedBox(width: 4),
                      Text(
                        gym.location,
                        style: TextStyle(color: Colors.grey[400], fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityCard(BuildContext context, Activity activity) {
    return GestureDetector(
      onTap: () {
        // TODO: Navigate to Activity Details page
        print('Tapped on ${activity.name}');
      },
      child: Container(
        width: MediaQuery.of(context).size.width *
            0.8, // Wider cards for activities
        margin: const EdgeInsets.only(right: 12.0),
        decoration: BoxDecoration(
          color: const Color(0xFF2C2C2C),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(15.0)),
                child: Image.asset(
                  activity.imagePath,
                  height: _activityImageHeight,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Center(
                      child: Icon(Icons.image_not_supported,
                          color: Colors.grey, size: 50)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    activity.name,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    activity.details,
                    style: TextStyle(color: Colors.grey[400], fontSize: 12),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportify_app/providers/auth_provider.dart';
import 'package:sportify_app/providers/gym_provider.dart';
import 'package:sportify_app/presentation/screens/search_screen.dart';
import 'package:sportify_app/utils/app_colors.dart';
import 'package:sportify_app/models/gym.dart';
import 'package:sportify_app/presentation/screens/gym_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // No longer fetching data on init
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
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {
              // TODO: Implement notifications screen
            },
          ),
        ],
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: SingleChildScrollView(
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
          location: 'Amman',
          imagePath: 'assets/images/Xgymcover.jpg'),
      _StaticGym(
          gymId: '3',
          name: 'Gold\'s Gym',
          location: 'Amman',
          imagePath: 'assets/images/GoldsGymExplore.png'),
      _StaticGym(
          gymId: '1',
          name: 'Grams Gym',
          location: 'Amman',
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
    return GestureDetector(
      onTap: () {
        // Create a full Gym object to pass to the details screen.
        // The details screen primarily uses the gymId from this object.
        final gymForNav = Gym(
          gymId: gym.gymId,
          name: gym.name,
          location: gym.location,
          services: [], // Dummy data, not used on details screen
          gendersAccepted: [], // Dummy data
          subscriptions: [], // Dummy data
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
  }
}

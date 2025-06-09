import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportify_app/models/gym.dart';
import 'package:sportify_app/presentation/screens/gym_details_screen.dart';
import 'package:sportify_app/providers/gym_provider.dart';
import 'package:sportify_app/utils/app_colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  List<Gym> _searchResults = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final gymProvider = Provider.of<GymProvider>(context, listen: false);
      if (gymProvider.allGyms.isEmpty) {
        gymProvider.fetchAllGyms().then((_) {
          if (mounted) {
            setState(() {
              _searchResults = gymProvider.allGyms;
            });
          }
        });
      } else {
        setState(() {
          _searchResults = gymProvider.allGyms;
        });
      }
    });

    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    // This now filters a static list since the provider is no longer used for the list
    final allGyms = _getStaticGyms();
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _searchResults = allGyms;
      } else {
        _searchResults = allGyms
            .where((gym) => gym.name.toLowerCase().contains(query))
            .toList();
      }
    });
  }

  List<Gym> _getStaticGyms() {
    return [
      Gym(
        gymId: '1',
        name: 'Grams Gym',
        location: 'Amman',
        services: ['Weightlifting', 'Cardio'],
        gendersAccepted: ['Male', 'Female'],
        subscriptions: [],
      ),
      Gym(
        gymId: '2',
        name: 'X Gym',
        location: 'Amman',
        services: ['Crossfit', 'Yoga'],
        gendersAccepted: ['Male', 'Female'],
        subscriptions: [],
      ),
      Gym(
        gymId: '3',
        name: 'Gold\'s Gym',
        location: 'Amman',
        services: ['All services'],
        gendersAccepted: ['Male', 'Female'],
        subscriptions: [],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // Initialize search results on first build
    if (_searchResults.isEmpty && _searchController.text.isEmpty) {
      _searchResults = _getStaticGyms();
    }

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Search for gyms...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: AppColors.textTertiary),
          ),
          style: const TextStyle(color: AppColors.text),
        ),
        backgroundColor: AppColors.background,
      ),
      body: _searchResults.isEmpty && _searchController.text.isNotEmpty
          ? const Center(child: Text('No gyms found.'))
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.8,
              ),
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final gym = _searchResults[index];
                return _SearchResultCard(gym: gym);
              },
            ),
    );
  }
}

class _SearchResultCard extends StatelessWidget {
  final Gym gym;

  const _SearchResultCard({required this.gym});

  String _getLogoForGym(String gymName) {
    if (gymName.contains('Gold')) {
      return 'assets/images/GoldsLogo.png';
    } else if (gymName.contains('Grams')) {
      return 'assets/images/GramsLogo.png';
    } else if (gymName.contains('X Gym')) {
      return 'assets/images/XLogo.png';
    }
    return 'assets/images/LOGO.png'; // Fallback
  }

  @override
  Widget build(BuildContext context) {
    final imagePath = _getLogoForGym(gym.name);

    return Card(
      color: AppColors.secondary,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => GymDetailsScreen(gym: gym),
          ));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                gym.name,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              child: ElevatedButton(
                child: const Text('See Detail'),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => GymDetailsScreen(gym: gym),
                  ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

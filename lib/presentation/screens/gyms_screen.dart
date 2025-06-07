import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sportify_flutter/core/constants/app_routes.dart';

// TODO: Replace with actual Gym data model and provider
final allGyms = [
  {
    'name': 'Grams Gym',
    'subtitle': 'Each Gram Matters',
    'logo': 'assets/images/GramsLogo.png',
    'id': 'grams_gym'
  },
  {
    'name': 'X Gym',
    'subtitle': 'STRONGER TOGETHER',
    'logo': 'assets/images/XLogo.png',
    'id': 'x_gym'
  },
  {
    'name': "Gold's Gym",
    'subtitle': 'Serious. Strong.',
    'logo': 'assets/images/GoldsLogo.png',
    'id': 'golds_gym'
  },
];

class GymsScreen extends StatefulWidget {
  const GymsScreen({Key? key}) : super(key: key);

  @override
  _GymsScreenState createState() => _GymsScreenState();
}

class _GymsScreenState extends State<GymsScreen> {
  List<Map<String, String>> _filteredGyms = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredGyms = allGyms;
    _searchController.addListener(_filterGyms);
  }

  void _filterGyms() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredGyms = allGyms.where((gym) {
        return gym['name']!.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2C2C2C),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2C2C2C),
        elevation: 0,
        title: const Text('Gyms', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search Gyms...',
                hintStyle: TextStyle(color: Colors.grey[400]),
                prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                        },
                      )
                    : null,
                filled: true,
                fillColor: const Color(0xFF3A3A3C),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.75,
        ),
        itemCount: _filteredGyms.length,
        itemBuilder: (context, index) {
          final gym = _filteredGyms[index];
          return GymGridCard(
            name: gym['name']!,
            subtitle: gym['subtitle']!,
            logoPath: gym['logo']!,
            onDetailsTap: () {
              final gymId = gym['id']!;
              context
                  .goNamed(AppRoutes.gymDetails, pathParameters: {'id': gymId});
            },
          );
        },
      ),
    );
  }
}

class GymGridCard extends StatelessWidget {
  final String name;
  final String subtitle;
  final String logoPath;
  final VoidCallback onDetailsTap;

  const GymGridCard({
    Key? key,
    required this.name,
    required this.subtitle,
    required this.logoPath,
    required this.onDetailsTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onDetailsTap,
      child: Card(
        color: const Color(0xFF3A3A3C),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Image.asset(
                  logoPath,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.error, size: 40, color: Colors.white),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: onDetailsTap,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFEF6A2A),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                ),
                child: const Text('See Detail'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

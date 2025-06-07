import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// --- Mock Data Structures ---
class Gym {
  final String id;
  final String name;
  final String imagePath;
  final List<String> amenities;
  final List<String> services;
  final List<Subscription> subscriptions;
  final List<GymClass> classes;
  final String websiteUrl;
  final String phone;
  final String directionsUrl;

  const Gym({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.amenities,
    required this.services,
    required this.subscriptions,
    required this.classes,
    required this.websiteUrl,
    required this.phone,
    required this.directionsUrl,
  });
}

class Subscription {
  final String text;
  final bool isSpecial;
  const Subscription(this.text, {this.isSpecial = false});
}

class GymClass {
  final String title;
  final String instructor;
  final String time;
  const GymClass(this.title, this.instructor, this.time);
}

// --- Mock Data ---
final Map<String, Gym> _gymData = {
  'grams_gym': const Gym(
    id: 'grams_gym',
    name: 'Grams Gym',
    imagePath: 'assets/images/GramsGymExplore.png',
    websiteUrl: 'https://www.instagram.com/gramsgym/',
    phone: 'tel:+962799006646',
    directionsUrl:
        'https://www.google.com/maps/search/?api=1&query=31.946436,35.846189',
    amenities: [
      'Shower rooms',
      'Locker rooms',
      'Free WIFI',
      'Free Parking',
      'Cardio Sessions',
      'Free Trial'
    ],
    services: ['Sauna', 'Personal Trainer'],
    subscriptions: [
      Subscription('1 Month: 50 JD'),
      Subscription('Special Offer: 45 JD/60Days', isSpecial: true),
      Subscription('6 months: 200 JD'),
    ],
    classes: [
      GymClass('BOOTS - 55 MINS', 'Brooke Sam', '9:00 AM'),
      GymClass('ZUMBA - 55 MINS', 'Jack Jhon', '9:00 AM'),
      GymClass('YOGA - 55 MINS', 'Marie Ann', '8:00 AM'),
    ],
  ),
  'x_gym': const Gym(
    id: 'x_gym',
    name: 'X Gym',
    imagePath: 'assets/images/Xgymcover.jpg',
    websiteUrl: 'https://www.instagram.com/xgym_jo/',
    phone: 'tel:+962799006646',
    directionsUrl:
        'https://www.google.com/maps/search/?api=1&query=31.956843,35.853281',
    amenities: [
      'Shower rooms',
      'Locker rooms',
      'Free WIFI',
      'Free Parking',
      'Cardio Sessions',
      'Free Trial'
    ],
    services: ['Sauna', 'Personal Trainer', 'Swimming Pool'],
    subscriptions: [
      Subscription('1 Month: 35 JD'),
      Subscription('Special Offer: 100 JD/150Days', isSpecial: true),
      Subscription('6 months: 235 JD'),
    ],
    classes: [
      GymClass('REFORMER PILATES - 55 MINS', 'Adam Ali', '9:00 AM'),
      GymClass('KICKBOXING - 55 MINS', 'Matt Rife', '10:00 AM'),
      GymClass('INDOOR CYCLING - 55 MINS', 'Jomana Moore', '8:00 AM'),
    ],
  ),
  'golds_gym': const Gym(
    id: 'golds_gym',
    name: 'Gold\'s Gym',
    imagePath: 'assets/images/GoldsGymExplore.png',
    websiteUrl: 'https://www.goldsgym.com/',
    phone: 'tel:+18009946537',
    directionsUrl:
        'https://www.google.com/maps/search/?api=1&query=31.963158,35.930359',
    amenities: [
      'Shower rooms',
      'Free Parking',
      'Locker rooms',
      'Cardio Sessions',
      'Free WiFi',
      'Free Trial',
      'Special Needs Accessible'
    ],
    services: ['Sauna', 'Personal Trainer', 'Swimming Pool'],
    subscriptions: [
      Subscription('1 month: 65 JD'),
      Subscription('Special Offer: 100 JD/100Days', isSpecial: true),
      Subscription('6 months: 250 JD'),
    ],
    classes: [
      GymClass('REFORMER PILATES - 55 MINS', 'KELLY BROOKE', '9:00 AM'),
      GymClass('BOXING - 55 MINS', 'SASHA, MOLLY', '10:00 AM'),
      GymClass('CYCLING - 55 MINS', 'RYAN JOHNSON', '8:00 AM'),
    ],
  )
};
// --- End Mock Data ---

class GymDetailsScreen extends StatefulWidget {
  final String gymId;

  const GymDetailsScreen({Key? key, required this.gymId}) : super(key: key);

  @override
  State<GymDetailsScreen> createState() => _GymDetailsScreenState();
}

class _GymDetailsScreenState extends State<GymDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Gym? _gym;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _gym = _gymData[widget.gymId];
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_gym == null) {
      return Scaffold(
          backgroundColor: const Color(0xFF1C1C1E),
          appBar: AppBar(),
          body: const Center(
              child: Text('Gym not found',
                  style: TextStyle(color: Colors.white))));
    }

    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1E),
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(_gym!),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(_gym!),
                  const SizedBox(height: 16),
                  _buildActionButtons(_gym!),
                  const SizedBox(height: 16),
                  _buildTabBar(),
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildOverviewTab(_gym!),
                _buildClassesTab(_gym!),
              ],
            ),
          ),
        ],
      ),
    );
  }

  SliverAppBar _buildSliverAppBar(Gym gym) {
    return SliverAppBar(
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      backgroundColor: const Color(0xFF1C1C1E),
      leading: const BackButton(color: Colors.white),
      flexibleSpace: FlexibleSpaceBar(
        background: Image.asset(gym.imagePath, fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildHeader(Gym gym) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          gym.name,
          style: const TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          children: List.generate(
              5,
              (index) =>
                  const Icon(Icons.star, color: Color(0xFFEF6A2A), size: 20)),
        ),
      ],
    );
  }

  Widget _buildActionButtons(Gym gym) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _actionButton(
            Icons.language, 'Website', () => _launchUrl(gym.websiteUrl)),
        _actionButton(Icons.directions, 'Directions',
            () => _launchUrl(gym.directionsUrl)),
        _actionButton(Icons.call, 'Call', () => _launchUrl(gym.phone)),
      ],
    );
  }

  Widget _actionButton(IconData icon, String label, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: const Color(0xFFEF6A2A)),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(color: Colors.white70)),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      controller: _tabController,
      indicatorColor: const Color(0xFFEF6A2A),
      labelColor: const Color(0xFFEF6A2A),
      unselectedLabelColor: Colors.white70,
      tabs: const [
        Tab(text: 'Overview'),
        Tab(text: 'Classes'),
      ],
    );
  }

  Widget _buildOverviewTab(Gym gym) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ..._buildAmenityRows(gym.amenities),
          const SizedBox(height: 24),
          const Text('Services',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children:
                gym.services.map((service) => _serviceItem(service)).toList(),
          ),
          const SizedBox(height: 24),
          const Text('Subscriptions',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          ...gym.subscriptions.map(
              (sub) => _subscriptionButton(sub.text, isSpecial: sub.isSpecial))
        ],
      ),
    );
  }

  List<Widget> _buildAmenityRows(List<String> amenities) {
    List<Widget> rows = [];
    for (var i = 0; i < amenities.length; i += 2) {
      rows.add(Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Row(
          children: [
            Expanded(child: _amenityItem(amenities[i])),
            if (i + 1 < amenities.length)
              Expanded(child: _amenityItem(amenities[i + 1])),
          ],
        ),
      ));
    }
    return rows;
  }

  Widget _amenityItem(String text) {
    return Row(
      children: [
        const Icon(Icons.check_circle, color: Color(0xFFEF6A2A), size: 20),
        const SizedBox(width: 8),
        Expanded(
            child: Text(text, style: const TextStyle(color: Colors.white))),
      ],
    );
  }

  // Helper to get specific icons for services
  IconData _getServiceIcon(String serviceName) {
    switch (serviceName.toLowerCase()) {
      case 'sauna':
        return Icons.hot_tub;
      case 'personal trainer':
        return Icons.fitness_center;
      case 'swimming pool':
        return Icons.pool;
      default:
        return Icons.miscellaneous_services; // A default icon
    }
  }

  Widget _serviceItem(String text) {
    return Column(
      children: [
        Icon(_getServiceIcon(text), color: Colors.white, size: 30),
        const SizedBox(height: 8),
        Text(text, style: const TextStyle(color: Colors.white))
      ],
    );
  }

  Widget _subscriptionButton(String text, {bool isSpecial = false}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
            backgroundColor:
                isSpecial ? const Color(0xFFEF6A2A) : const Color(0xFF3A3A3C),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            padding: const EdgeInsets.symmetric(vertical: 16)),
        child: Text(text, style: const TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _buildClassesTab(Gym gym) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _buildDateSelector(),
        const SizedBox(height: 16),
        ...gym.classes
            .map((c) => _classCard(c.title, c.instructor, c.time))
            .toList(),
      ],
    );
  }

  Widget _buildDateSelector() {
    final days = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];
    final dates = ['14', '15', '16', '17', '18', '19', '20'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(7, (index) {
        final isSelected = index == 1;
        return Column(
          children: [
            Text(dates[index],
                style: TextStyle(
                    color: isSelected ? const Color(0xFFEF6A2A) : Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            Text(days[index],
                style: TextStyle(
                    color:
                        isSelected ? const Color(0xFFEF6A2A) : Colors.white70,
                    fontSize: 12)),
          ],
        );
      }),
    );
  }

  Widget _classCard(String title, String instructor, String time) {
    return Card(
      color: const Color(0xFF2C2C2E),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Colors.grey,
          child: Icon(Icons.person, color: Colors.white),
        ),
        title: Text(title,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold)),
        subtitle: Text('$instructor\n$time',
            style: const TextStyle(color: Colors.white70)),
        trailing: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFEF6A2A),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
          child: const Text('Reserve'),
        ),
        isThreeLine: true,
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not launch $url')),
        );
      }
    }
  }
}

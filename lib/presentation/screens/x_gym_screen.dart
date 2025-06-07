import 'package:flutter/material.dart';

class XGymScreen extends StatefulWidget {
  const XGymScreen({Key? key}) : super(key: key);

  @override
  _XGymScreenState createState() => _XGymScreenState();
}

class _XGymScreenState extends State<XGymScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1E),
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 16),
                  _buildActionButtons(),
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
                _buildOverviewTab(),
                _buildClassesTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  SliverAppBar _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      backgroundColor: const Color(0xFF1C1C1E),
      leading: const BackButton(color: Colors.white),
      flexibleSpace: FlexibleSpaceBar(
        background: Image.asset(
          'assets/images/Xgymcover.jpg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'X Gym',
          style: TextStyle(
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

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _actionButton(Icons.language, 'Website'),
        _actionButton(Icons.directions, 'Directions'),
        _actionButton(Icons.call, 'Call'),
      ],
    );
  }

  Widget _actionButton(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: const Color(0xFFEF6A2A)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.white70)),
      ],
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

  Widget _buildOverviewTab() {
    // Mock data from the image
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAmenityRow([
            _amenityItem('Shower rooms'),
            _amenityItem('Locker rooms'),
            _amenityItem('Free WIFI'),
          ]),
          const SizedBox(height: 16),
          _buildAmenityRow([
            _amenityItem('Free Parking'),
            _amenityItem('Cardio Sessions'),
            _amenityItem('Free Trial'),
          ]),
          const SizedBox(height: 24),
          const Text('Services',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _serviceItem('Sauna'),
              _serviceItem('Personal Trainer'),
              _serviceItem('Swimming Pool'),
            ],
          ),
          const SizedBox(height: 24),
          const Text('Subscriptions',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _subscriptionButton('1 Month: 35 JD'),
          _subscriptionButton('Special Offer: 100 JD/150Days', isSpecial: true),
          _subscriptionButton('6 months: 235 JD'),
        ],
      ),
    );
  }

  Widget _buildAmenityRow(List<Widget> items) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: items.map((item) => Expanded(child: item)).toList(),
    );
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

  Widget _serviceItem(String text) {
    return Column(
      children: [
        const Icon(Icons.pool,
            color: Colors.white, size: 30), // Placeholder icon
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

  Widget _buildClassesTab() {
    // Mock data from the image
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _buildDateSelector(),
        const SizedBox(height: 16),
        _classCard('REFORMER PILATES - 55 MINS', 'Adam Ali', '9:00 AM'),
        _classCard('KICKBOXING - 55 MINS', 'Matt Rife', '10:00 AM'),
        _classCard('INDOOR CYCLING - 55 MINS', 'Jomana Moore', '8:00 AM'),
      ],
    );
  }

  Widget _buildDateSelector() {
    final days = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];
    final dates = ['14', '15', '16', '17', '18', '19', '20'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(7, (index) {
        final isSelected = index == 1; // Tuesday is selected
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
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sportify_flutter/core/constants/app_routes.dart';

class GroupActivitiesScreen extends StatefulWidget {
  const GroupActivitiesScreen({Key? key}) : super(key: key);

  @override
  _GroupActivitiesScreenState createState() => _GroupActivitiesScreenState();
}

class _GroupActivitiesScreenState extends State<GroupActivitiesScreen> {
  String? _expandedSport;

  void _toggleExpand(String sport) {
    setState(() {
      if (_expandedSport == sport) {
        _expandedSport = null;
      } else {
        _expandedSport = sport;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1E),
      appBar: AppBar(
        title: const Text('Group Activities'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(onPressed: () => context.pop()),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSportCategory(
              'Tennis',
              isExpanded: _expandedSport == 'Tennis',
              onTap: () => _toggleExpand('Tennis'),
            ),
            _buildSportCategory(
              'Football',
              isExpanded: _expandedSport == 'Football',
              onTap: () => _toggleExpand('Football'),
            ),
            _buildSportCategory(
              'Basketball',
              isExpanded: _expandedSport == 'Basketball',
              onTap: () => _toggleExpand('Basketball'),
            ),
            _buildSportCategory(
              'Other',
              isExpanded: _expandedSport == 'Other',
              onTap: () => _toggleExpand('Other'),
            ),
            const SizedBox(height: 40),
            const Text(
              'Upcoming Activities',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildUpcomingActivities(),
          ],
        ),
      ),
    );
  }

  Widget _buildSportCategory(String title,
      {required bool isExpanded, required VoidCallback onTap}) {
    final bool isOther = title == 'Other';
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Column(
        children: [
          _buildCategoryButton(title, isExpanded, onTap),
          if (isExpanded)
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: isOther
                  ? _buildSubCategoryButton('Special Needs', () {})
                  : Column(
                      children: [
                        _buildSubCategoryButton('Create Team', () {
                          context.goNamed(AppRoutes.createTeam,
                              pathParameters: {'sport': title.toLowerCase()});
                        }),
                        const SizedBox(height: 10),
                        _buildSubCategoryButton('Upcoming Events', () {
                          // TODO: Navigate to upcoming events for this sport
                        }),
                      ],
                    ),
            ),
        ],
      ),
    );
  }

  Widget _buildCategoryButton(
      String title, bool isExpanded, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: const LinearGradient(
            colors: [Color(0xFFEF6A2A), Color(0xFFE64A19)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            Icon(
              isExpanded
                  ? Icons.keyboard_arrow_down
                  : Icons.keyboard_arrow_right,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubCategoryButton(String title, VoidCallback onPressed) {
    return SizedBox(
      width: 200,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFEF6A2A),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        child: Text(title,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500)),
      ),
    );
  }

  Widget _buildUpcomingActivities() {
    // Mock data for upcoming activities
    return SizedBox(
      height: 180,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildActivityCard(
            title: 'Amman Marathon',
            location: 'Dead sea',
            imagePath: 'assets/images/run_jo.jpeg',
            onTap: () {},
          ),
          const SizedBox(width: 15),
          // Add other activity cards here
        ],
      ),
    );
  }

  Widget _buildActivityCard(
      {required String title,
      required String location,
      required String imagePath,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 250,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(15)),
              child: Image.asset(
                imagePath,
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (ctx, err, st) => Container(
                  height: 100,
                  color: Colors.grey,
                  child: const Center(child: Icon(Icons.error)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(Icons.location_on,
                          color: Colors.orange, size: 16),
                      const SizedBox(width: 5),
                      Text(location, style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

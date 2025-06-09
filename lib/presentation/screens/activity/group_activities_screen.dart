import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportify_app/models/group_activity_team.dart';
import 'package:sportify_app/providers/group_activity_provider.dart';
import 'package:sportify_app/presentation/screens/activity/create_team_screen.dart';
import 'package:sportify_app/presentation/screens/activity/upcoming_events_screen.dart';
import 'package:sportify_app/utils/app_colors.dart';

class GroupActivitiesScreen extends StatefulWidget {
  const GroupActivitiesScreen({super.key});

  @override
  State<GroupActivitiesScreen> createState() => _GroupActivitiesScreenState();
}

class _GroupActivitiesScreenState extends State<GroupActivitiesScreen> {
  int _expandedIndex = -1; // -1 means all are collapsed
  int _currentPage = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _toggleExpand(int index) {
    setState(() {
      if (_expandedIndex == index) {
        _expandedIndex = -1; // Collapse if already expanded
      } else {
        _expandedIndex = index; // Expand new one
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Group Activities'),
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildExpandableCategoryItem(0, 'Tennis'),
            _buildExpandableCategoryItem(1, 'Football'),
            _buildExpandableCategoryItem(2, 'Basketball'),
            _buildExpandableCategoryItem(3, 'Other'),
            const SizedBox(height: 20),
            Center(child: _buildChip('Special Needs', onTap: () {})),
            const SizedBox(height: 30),
            Text(
              'Upcoming activities',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildUpcomingActivitiesSlider(),
            _buildPageIndicator(),
          ],
        ),
      ),
    );
  }

  Widget _buildExpandableCategoryItem(int index, String title) {
    final isExpanded = _expandedIndex == index;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          ListTile(
            title: Text(title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white)),
            trailing: Icon(
              isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              color: Colors.white,
            ),
            onTap: () => _toggleExpand(index),
          ),
          if (isExpanded)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)
                  .copyWith(top: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: _buildChip('Create Team', onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => CreateTeamScreen(category: title),
                      ));
                    }),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildChip('Upcoming Events', onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => UpcomingEventsScreen(category: title),
                      ));
                    }),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildChip(String label, {required VoidCallback onTap}) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black.withOpacity(0.6),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      child: Text(label, textAlign: TextAlign.center),
    );
  }

  Widget _buildUpcomingActivitiesSlider() {
    // Static data for the slider based on the image
    final upcomingActivities = [
      {
        'imagePath':
            'assets/images/run_jordan.png', // This will fail if asset not present
        'title': 'Amman Marathon',
        'location': 'Dead sea',
        'organizer': 'Each Gram Masters',
      },
      // Add more static activities if needed
    ];

    return SizedBox(
      height: 220,
      child: PageView.builder(
        controller: _pageController,
        itemCount: upcomingActivities.length,
        onPageChanged: (int page) {
          setState(() {
            _currentPage = page;
          });
        },
        itemBuilder: (context, index) {
          final activity = upcomingActivities[index];
          return _UpcomingActivityCard(
            imagePath: activity['imagePath']!,
            title: activity['title']!,
            location: activity['location']!,
            organizer: activity['organizer']!,
          );
        },
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(1, (index) {
        // Hardcoded for 1 item
        return Container(
          width: 8.0,
          height: 8.0,
          margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentPage == index
                ? AppColors.primary
                : Colors.grey.withOpacity(0.5),
          ),
        );
      }),
    );
  }
}

class _UpcomingActivityCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String location;
  final String organizer;

  const _UpcomingActivityCard({
    required this.imagePath,
    required this.title,
    required this.location,
    required this.organizer,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Using a placeholder for the image since the asset is not available
          Container(
            height: 120,
            color: Colors.grey.shade300,
            child: const Center(
              child: Icon(Icons.image, size: 50, color: Colors.grey),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 14, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(location, style: const TextStyle(color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 4),
                Text(organizer, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

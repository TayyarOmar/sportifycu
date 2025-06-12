import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportify_app/models/gym.dart';
import 'package:sportify_app/models/user.dart';
import 'package:sportify_app/providers/auth_provider.dart';
import 'package:sportify_app/providers/gym_provider.dart';
import 'package:sportify_app/utils/app_colors.dart';
import 'package:sportify_app/utils/dummy_data.dart';
import 'package:url_launcher/url_launcher.dart';

class GymDetailsScreen extends StatefulWidget {
  final Gym gym;
  const GymDetailsScreen({super.key, required this.gym});

  @override
  State<GymDetailsScreen> createState() => _GymDetailsScreenState();
}

class _GymDetailsScreenState extends State<GymDetailsScreen>
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

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      // TODO: Show a proper error to the user
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _launchMaps(double lat, double lon) async {
    final String googleMapsUrl =
        'https://www.google.com/maps/search/?api=1&query=$lat,$lon';
    await _launchUrl(googleMapsUrl);
  }

  @override
  Widget build(BuildContext context) {
    final gymData = getDummyGymData(widget.gym.gymId);

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            _buildSliverAppBar(context, gymData),
          ];
        },
        body: Column(
          children: [
            TabBar(
              controller: _tabController,
              labelColor: AppColors.primary,
              unselectedLabelColor: AppColors.textTertiary,
              indicatorColor: AppColors.primary,
              tabs: const [
                Tab(text: 'Overview'),
                Tab(text: 'Classes'),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildOverviewTab(gymData),
                  _buildClassesTab(gymData),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  SliverAppBar _buildSliverAppBar(
      BuildContext context, Map<String, dynamic> gymData) {
    return SliverAppBar(
      expandedHeight: 250.0,
      floating: false,
      pinned: true,
      backgroundColor: AppColors.background,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(widget.gym.name,
          style: const TextStyle(color: Colors.white, fontSize: 20.0)),
      actions: [
        Consumer<AuthProvider>(
          builder: (context, authProvider, child) {
            final isFavorite =
                authProvider.user?.favourites.contains(widget.gym.gymId) ??
                    false;
            String? _resolveBackendGymId() {
              final allGyms =
                  Provider.of<GymProvider>(context, listen: false).allGyms;
              for (final g in allGyms) {
                final s1 = g.name.toLowerCase();
                final s2 = widget.gym.name.toLowerCase();
                if (s1.contains(s2) || s2.contains(s1)) return g.gymId;
              }
              return null;
            }

            return IconButton(
              icon: Icon(
                isFavorite ? Icons.bookmark : Icons.bookmark_border,
                color: isFavorite ? AppColors.primary : Colors.white,
              ),
              onPressed: () async {
                final backendId = _resolveBackendGymId();
                if (backendId == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Gym not found on server.')),
                  );
                  return;
                }
                bool success = true;
                if (isFavorite) {
                  try {
                    await authProvider.removeFavorite(backendId);
                  } catch (e) {
                    success = false;
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(success
                            ? 'Removed from favorites!'
                            : 'Failed to remove favorite.')),
                  );
                } else {
                  try {
                    await authProvider.addFavorite(backendId);
                  } catch (e) {
                    success = false;
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(success
                            ? 'Added to favorites!'
                            : 'Failed to add favorite.')),
                  );
                }
              },
            );
          },
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              gymData['image'],
              fit: BoxFit.cover,
            ),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                    Color(0x90000000),
                    Color(0x00000000),
                    Color(0x90000000),
                  ],
                  stops: [0.0, 0.5, 1.0],
                ),
              ),
            ),
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: List.generate(
                            5,
                            (index) => Icon(
                                  Icons.star,
                                  color: index < gymData['rating']
                                      ? AppColors.primary
                                      : Colors.grey,
                                )),
                      ),
                      _TokenChip(
                          tokens: (widget.gym.tokenPerVisit ?? 0)
                              .toStringAsFixed(0))
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _ActionButton(
                          icon: Icons.language,
                          label: 'Website',
                          onTap: () => _launchUrl(gymData['website'])),
                      _ActionButton(
                          icon: Icons.directions,
                          label: 'Directions',
                          onTap: () => _launchMaps(gymData['location']['lat'],
                              gymData['location']['lon'])),
                      _ActionButton(
                          icon: Icons.call,
                          label: 'Call',
                          onTap: () => _launchUrl(gymData['phone'])),
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

  Widget _buildOverviewTab(Map<String, dynamic> gymData) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionGrid(gymData['amenities']),
          const SizedBox(height: 24),
          _SectionHeader(title: 'Services'),
          const SizedBox(height: 16),
          _buildServicesRow(gymData['services']),
          const SizedBox(height: 24),
          _SectionHeader(title: 'Subscriptions'),
          const SizedBox(height: 16),
          ..._buildSubscriptionButtons(gymData['subscriptions']),
        ],
      ),
    );
  }

  Widget _buildClassesTab(Map<String, dynamic> gymData) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        // TODO: Implement a dynamic date selector
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children:
              (gymData['schedule'] as List<Map<String, String>>).map((day) {
            return Column(
              children: [
                Text(day['dayNum']!,
                    style: const TextStyle(color: Colors.white)),
                Text(day['dayName']!,
                    style: const TextStyle(color: AppColors.textTertiary)),
              ],
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
        ...gymData['classes'].map<Widget>((cls) {
          return Card(
            color: AppColors.secondary,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.grey,
                child: Icon(Icons.person, color: Colors.white),
              ),
              title: Text(cls['name']),
              subtitle: Text("${cls['instructor']}\n${cls['time']}"),
              trailing: ElevatedButton(
                onPressed: () {},
                child: const Text('Reserve'),
              ),
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildSectionGrid(List<String> items) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 5,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        return Row(
          children: [
            const Icon(Icons.check_circle_outline,
                color: AppColors.primary, size: 20),
            const SizedBox(width: 8),
            Expanded(child: Text(items[index])),
          ],
        );
      },
    );
  }

  Widget _buildServicesRow(List<Map<String, dynamic>> services) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: services.map((service) {
        return Column(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: AppColors.secondary,
              child: Icon(service['icon'],
                  color: AppColors.textTertiary, size: 24),
            ),
            const SizedBox(height: 8),
            Text(service['name'],
                style: const TextStyle(color: AppColors.textTertiary)),
          ],
        );
      }).toList(),
    );
  }

  List<Widget> _buildSubscriptionButtons(List<Map<String, String>> subs) {
    return subs.map((sub) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                backgroundColor: sub['label']!.contains('Special')
                    ? AppColors.primary
                    : AppColors.secondary,
                side: sub['label']!.contains('Special')
                    ? BorderSide.none
                    : const BorderSide(color: AppColors.primary)),
            child: Text(sub['label']!),
          ),
        ),
      );
    }).toList();
  }
}

class _TokenChip extends StatelessWidget {
  final String tokens;
  const _TokenChip({required this.tokens});

  @override
  Widget build(BuildContext context) {
    // TODO: Use the actual token icon when available
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.token, color: AppColors.primary, size: 16),
          const SizedBox(width: 4),
          Text('Tokens',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Colors.white)),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionButton(
      {required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: ElevatedButton.icon(
          onPressed: onTap,
          icon: Icon(icon, size: 16),
          label: Text(label),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF3A3A3C),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}

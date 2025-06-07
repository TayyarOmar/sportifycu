import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:go_router/go_router.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(31.963158, 35.930359), // Amman, Jordan
    zoom: 12,
  );

  // TODO: Replace with actual gym data from a provider
  final _gyms = [
    {
      'id': 'grams_gym',
      'name': 'Grams Gym 24/7',
      'location': 'Amman',
      'image': 'assets/images/GramsGymExplore.png'
    },
    {
      'id': 'x_gym',
      'name': "X Gym",
      'location': 'Amman',
      'image': 'assets/images/Xgymcover.jpg'
    },
    {
      'id': 'golds_gym',
      'name': "Gold's Gym",
      'location': 'Amman',
      'image': 'assets/images/GoldsGymExplore.png'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
          child: GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: _gyms.length,
            itemBuilder: (context, index) {
              final gym = _gyms[index];
              return _buildGymCard(
                  gym['name']!, gym['location']!, gym['image']!, () {
                final gymId = gym['id']!;
                context.go('/gyms/details/$gymId');
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildGymCard(
      String name, String location, String imagePath, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: const Color(0xFF3A3A3A),
        margin: const EdgeInsets.only(bottom: 20),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              imagePath,
              height: 180,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 180,
                  color: Colors.grey[800],
                  child: const Icon(Icons.error, color: Colors.white, size: 50),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        location,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.location_on,
                          color: Color(0xFFEF6A2A), size: 20),
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
}

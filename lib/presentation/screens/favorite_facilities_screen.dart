import 'package:flutter/material.dart';

class FavoriteFacilitiesScreen extends StatelessWidget {
  const FavoriteFacilitiesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Facilities'),
      ),
      body: const Center(
        child: Text('Favorite Facilities Screen'),
      ),
    );
  }
}

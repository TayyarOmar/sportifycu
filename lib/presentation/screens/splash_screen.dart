import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sportify_flutter/core/constants/app_routes.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Allow time for the auth state to be checked, then navigate.
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        // Navigate to auth options, the router's redirect will handle the rest.
        context.go(AppRoutes.authOptions);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor =
        Color(0xFFEF6A2A); // Using direct color for consistency
    const Color backgroundColor =
        Color(0xFF2C2C2C); // Dark grey, adjust as needed

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/LOGO.PNG', // Using the specified logo
              width: 150, // Adjust width as needed
              height: 150, // Adjust height as needed
              // Optional: add errorBuilder for robustness
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.sports_soccer,
                    size: 120, color: primaryColor); // Fallback icon
              },
            ),
            const SizedBox(height: 24),
            const Text(
              'SportiFy',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: primaryColor,
                // Consider adding a custom font here if needed
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Discover your favorite sport',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
            const Spacer(), // Pushes footer to the bottom
            const Padding(
              padding: EdgeInsets.only(bottom: 30.0),
              child: Text(
                '© 2025 SportiFy - All Rights Reserved.',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white54,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

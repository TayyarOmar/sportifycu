import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_routes.dart';

class AuthOptionsScreen extends StatelessWidget {
  const AuthOptionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFFEF6A2A); // Use the direct color
    const Color backgroundColor = Color(0xFF2C2C2C); // Dark grey

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Spacer(flex: 2),
              Image.asset(
                'assets/images/LOGO.PNG', // Using the specified logo
                height: 120, // Adjust height as needed
                // Optional: add errorBuilder for robustness
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.sports_soccer,
                      size: 100, color: primaryColor); // Fallback icon
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'SportiFy',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(12), // More rounded corners
                  ),
                ),
                onPressed: () {
                  context.pushNamed(AppRoutes
                      .login); // Use pushNamed to allow back navigation if desired
                },
                child:
                    const Text('Login', style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(12), // More rounded corners
                  ),
                ),
                onPressed: () {
                  context.pushNamed(AppRoutes.signup);
                },
                child: const Text('Sign Up',
                    style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  context.goNamed(AppRoutes.home);
                },
                child: const Text(
                  'Continue as Guest',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'Discover your favorite sport',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
              const Spacer(flex: 3),
              const Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Text(
                  '© 2025 SportiFy - All Rights Reserved.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white54,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

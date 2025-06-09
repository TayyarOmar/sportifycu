import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(flex: 2),
              // TODO: Make sure you have the logo at 'assets/images/LOGO.png'
              Image.asset(
                'assets/images/LOGO.png',
                height: 150,
              ),
              const SizedBox(height: 20),
              Text(
                'SportiFy',
                textAlign: TextAlign.center,
                style: textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(flex: 3),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/login');
                },
                child: const Text('Login'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/signup');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.surface,
                ),
                child: const Text('Sign Up'),
              ),
              const SizedBox(height: 30),
              Text(
                'Discover your favorite sport',
                textAlign: TextAlign.center,
                style: textTheme.titleMedium,
              ),
              const Spacer(flex: 1),
              Text(
                '© 2025 Sportify - All Rights Reserved.',
                textAlign: TextAlign.center,
                style: textTheme.bodySmall,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

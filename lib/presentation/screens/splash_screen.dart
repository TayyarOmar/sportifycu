import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportify_app/providers/auth_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  void _navigateToNext() {
    Future.delayed(const Duration(seconds: 2), () async {
      if (mounted) {
        final authProvider = Provider.of<AuthProvider>(context, listen: false);
        final isLoggedIn = await authProvider.tryAutoLogin();
        if (isLoggedIn) {
          Navigator.of(context).pushReplacementNamed('/home');
        } else {
          Navigator.of(context).pushReplacementNamed('/welcome');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // TODO: Make sure you have the logo at 'assets/images/LOGO.png'
            Image.asset('assets/images/LOGO.png', width: 150),
            const SizedBox(height: 20),
            Text(
              'SportiFy',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: 10),
            Text(
              'Discover your favorite sport',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}

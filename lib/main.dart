import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportify_app/providers/auth_provider.dart';
import 'package:sportify_app/presentation/screens/splash_screen.dart';
import 'package:sportify_app/presentation/theme/app_theme.dart';
import 'package:sportify_app/presentation/screens/auth/welcome_screen.dart';
import 'package:sportify_app/presentation/screens/auth/login_screen.dart';
import 'package:sportify_app/presentation/screens/auth/signup_screen.dart';
import 'package:sportify_app/presentation/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        title: 'SportiFy',
        theme: AppTheme.theme,
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/welcome': (context) => const WelcomeScreen(),
          '/login': (context) => const LoginScreen(),
          '/signup': (context) => const SignupScreen(),
          '/home': (context) => const HomeScreen(),
          // The 2FA screen will be pushed dynamically, so it doesn't need a named route here.
        },
      ),
    );
  }
}

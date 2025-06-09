import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportify_app/providers/auth_provider.dart';
import 'package:sportify_app/providers/gym_provider.dart';
import 'package:sportify_app/providers/group_activity_provider.dart';
import 'package:sportify_app/providers/leaderboard_provider.dart';
import 'package:sportify_app/providers/theme_provider.dart';
import 'package:sportify_app/presentation/screens/splash_screen.dart';
import 'package:sportify_app/presentation/theme/app_theme.dart';
import 'package:sportify_app/presentation/screens/auth/welcome_screen.dart';
import 'package:sportify_app/presentation/screens/auth/login_screen.dart';
import 'package:sportify_app/presentation/screens/auth/signup_screen.dart';
import 'package:sportify_app/presentation/screens/home_screen.dart';
import 'package:sportify_app/presentation/screens/main_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => GymProvider()),
        ChangeNotifierProvider(create: (_) => GroupActivityProvider()),
        ChangeNotifierProvider(create: (_) => LeaderboardProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'SportiFy',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.currentTheme,
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            routes: {
              '/': (context) => const SplashScreen(),
              '/welcome': (context) => const WelcomeScreen(),
              '/login': (context) => const LoginScreen(),
              '/signup': (context) => const SignupScreen(),
              '/home': (context) => const MainScreen(),
              // The 2FA screen will be pushed dynamically, so it doesn't need a named route here.
            },
          );
        },
      ),
    );
  }
}

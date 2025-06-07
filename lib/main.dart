// lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'presentation/providers/theme_provider.dart';

import 'core/constants/app_routes.dart';
import 'presentation/providers/auth_state_provider.dart';
import 'presentation/screens/login_screen.dart';
import 'presentation/screens/signup_screen.dart';
import 'presentation/screens/personalize_gender_age_screen.dart';
import 'presentation/screens/personalize_fitness_goals_screen.dart';
import 'presentation/screens/home_screen.dart';
import 'presentation/screens/explore_screen.dart';
import 'presentation/screens/scan_qr_screen.dart';
import 'presentation/screens/profile_screen.dart';
import 'presentation/screens/personal_information_screen.dart';
import 'presentation/screens/settings_screen.dart';
import 'presentation/screens/notifications_screen.dart';
import 'presentation/widgets/scaffold_with_bottom_nav_bar.dart';
import 'presentation/screens/reset_password_screen.dart';
import 'presentation/screens/team_created_success_screen.dart';
import 'presentation/screens/activities_screen.dart';
import 'presentation/screens/faq_screen.dart';
import 'presentation/screens/splash_screen.dart';
import 'presentation/screens/auth_options_screen.dart';
import 'presentation/screens/confirm_reset_screen.dart';
import 'presentation/screens/qr_scanner_view.dart';
import 'presentation/screens/gyms_screen.dart';
import 'presentation/screens/plans_screen.dart';
import 'presentation/screens/activity_leaderboard_screen.dart';
import 'presentation/screens/favorite_facilities_screen.dart';
import 'presentation/screens/gym_details_screen.dart';
import 'presentation/screens/auth/verify_2fa_screen.dart';
import 'presentation/screens/group_activities_screen.dart';
import 'presentation/screens/create_team_screen.dart';
import 'presentation/screens/achievements_screen.dart';

void main() {
  usePathUrlStrategy();
  runApp(const ProviderScope(child: SportifyApp()));
}

final goRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authNotifierProvider);

  return GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true,
    redirect: (BuildContext context, GoRouterState state) {
      final currentLocation = state.uri.toString();
      final authStateValue = ref.watch(authNotifierProvider);

      final isAuthenticated = authStateValue.maybeWhen(
        authenticated: (_) => true,
        orElse: () => false,
      );

      final isLoading = authStateValue.maybeWhen(
        loading: () => true,
        initial: () => true,
        orElse: () => false,
      );

      if (isLoading) {
        return AppRoutes.splash;
      }

      if (isAuthenticated) {
        final publicRoutes = [
          AppRoutes.authOptions,
          AppRoutes.login,
          AppRoutes.signup,
          AppRoutes.resetPassword,
          AppRoutes.confirmReset,
          AppRoutes.splash,
        ];
        if (publicRoutes.contains(currentLocation) ||
            currentLocation.startsWith(AppRoutes.signup) ||
            currentLocation.startsWith(AppRoutes.resetPassword)) {
          return AppRoutes.home;
        }
        return null;
      }

      // Allow guest access, do not redirect away from any page if unauthenticated.
      // The user can freely explore. If an action requires auth, that screen/widget can prompt login.

      return null;
    },
    routes: [
      GoRoute(
        name: AppRoutes.splash,
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        name: AppRoutes.authOptions,
        path: AppRoutes.authOptions,
        builder: (context, state) => const AuthOptionsScreen(),
      ),
      GoRoute(
        name: AppRoutes.login,
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
          name: AppRoutes.signup,
          path: AppRoutes.signup,
          builder: (context, state) => const SignUpScreen(),
          routes: [
            GoRoute(
                name: AppRoutes.personalizeGenderAge,
                path: AppRoutes.personalizeGenderAge,
                builder: (context, state) =>
                    const PersonalizeGenderAgeScreen()),
            GoRoute(
                name: AppRoutes.personalizeFitnessGoals,
                path: AppRoutes.personalizeFitnessGoals,
                builder: (context, state) =>
                    const PersonalizeFitnessGoalsScreen()),
          ]),
      GoRoute(
        name: AppRoutes.verify2FA,
        path: AppRoutes.verify2FA,
        builder: (context, state) =>
            Verify2FAScreen(email: (state.extra as String?) ?? ''),
      ),
      GoRoute(
          name: AppRoutes.resetPassword,
          path: AppRoutes.resetPassword,
          builder: (context, state) => const ResetPasswordScreen(),
          routes: [
            GoRoute(
              name: AppRoutes.confirmReset,
              path: AppRoutes.confirmReset,
              builder: (context, state) => const ConfirmResetScreen(),
            )
          ]),
      ShellRoute(
        builder: (context, state, child) {
          return ScaffoldWithBottomNavBar(child: child);
        },
        routes: [
          GoRoute(
            name: AppRoutes.home,
            path: AppRoutes.home,
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            name: AppRoutes.explore,
            path: AppRoutes.explore,
            builder: (context, state) => const ExploreScreen(),
          ),
          GoRoute(
            name: AppRoutes.scanQR,
            path: AppRoutes.scanQR,
            builder: (context, state) => const ScanQRScreen(),
            routes: [
              GoRoute(
                name: AppRoutes.qrScanner,
                path: AppRoutes.qrScanner,
                builder: (context, state) => const QRScannerView(),
              ),
            ],
          ),
          GoRoute(
              name: AppRoutes.profile,
              path: AppRoutes.profile,
              builder: (context, state) => const ProfileScreen(),
              routes: [
                GoRoute(
                    name: AppRoutes.personalInfo,
                    path: AppRoutes.personalInfo,
                    builder: (context, state) =>
                        const PersonalInformationScreen()),
                GoRoute(
                    name: AppRoutes.favoriteFacilities,
                    path: AppRoutes.favoriteFacilities,
                    builder: (context, state) =>
                        const FavoriteFacilitiesScreen()),
                GoRoute(
                    name: AppRoutes.settings,
                    path: AppRoutes.settings,
                    builder: (context, state) => const SettingsScreen()),
                GoRoute(
                    name: AppRoutes.notifications,
                    path: AppRoutes.notifications,
                    builder: (context, state) => const NotificationsScreen())
              ]),
          GoRoute(
            name: AppRoutes.gyms,
            path: AppRoutes.gyms,
            builder: (context, state) => const GymsScreen(),
            routes: [
              GoRoute(
                name: AppRoutes.gymDetails,
                path: 'details/:id',
                builder: (context, state) => GymDetailsScreen(
                  gymId: state.pathParameters['id']!,
                ),
              ),
            ],
          ),
          GoRoute(
            name: AppRoutes.activities,
            path: AppRoutes.activities,
            builder: (context, state) => const ActivitiesScreen(),
          ),
          GoRoute(
            name: AppRoutes.faq,
            path: AppRoutes.faq,
            builder: (context, state) => const FaqScreen(),
          ),
          GoRoute(
            name: AppRoutes.plans,
            path: AppRoutes.plans,
            builder: (context, state) => const PlansScreen(),
          ),
          GoRoute(
            name: AppRoutes.activityLeaderboard,
            path: AppRoutes.activityLeaderboard,
            builder: (context, state) => const ActivityLeaderboardScreen(),
          ),
          GoRoute(
            name: AppRoutes.achievements,
            path: AppRoutes.achievements,
            builder: (context, state) => const AchievementsScreen(),
          ),
          GoRoute(
            name: AppRoutes.groupActivities,
            path: AppRoutes.groupActivities,
            builder: (context, state) => const GroupActivitiesScreen(),
            routes: [
              GoRoute(
                name: AppRoutes.createTeam,
                path: 'create/:sport', // e.g. /group-activities/create/football
                builder: (context, state) => CreateTeamScreen(
                  sportType: state.pathParameters['sport']!,
                ),
              ),
              GoRoute(
                name: AppRoutes.teamCreatedSuccess,
                path: 'success/:teamId', // e.g. /group-activities/success/123
                builder: (context, state) => TeamCreatedSuccessScreen(
                  teamId: state.pathParameters['teamId']!,
                ),
              ),
            ],
          ),
        ],
      )
    ],
  );
});

class SportifyApp extends ConsumerWidget {
  const SportifyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);
    final themeMode = ref.watch(themeProvider);

    const Color primaryColor = Color(0xFFEF6A2A);

    final darkTheme = ThemeData(
      brightness: Brightness.dark,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: const Color(0xFF1C1C1E),
      colorScheme: const ColorScheme.dark(
        primary: primaryColor,
        secondary: primaryColor,
        surface: Color(0xFF2C2C2E),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF1C1C1E),
        elevation: 0,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF2C2C2E),
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.white70,
        type: BottomNavigationBarType.fixed,
      ),
      cardColor: const Color(0xFF2C2C2E),
    );

    final lightTheme = ThemeData(
      brightness: Brightness.light,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: const Color(0xFFF2F2F7),
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        secondary: primaryColor,
        surface: Colors.white,
      ),
      appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF2F2F7),
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey[600],
        type: BottomNavigationBarType.fixed,
      ),
      cardColor: Colors.white,
    );

    return MaterialApp.router(
      title: 'Sportify',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      routerConfig: router,
    );
  }
}

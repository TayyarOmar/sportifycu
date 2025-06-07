import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'app_drawer.dart';

import '../../core/constants/app_routes.dart';

class ScaffoldWithBottomNavBar extends StatelessWidget {
  final Widget child;
  const ScaffoldWithBottomNavBar({Key? key, required this.child})
      : super(key: key);

  static const _navBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      activeIcon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.explore_outlined),
      activeIcon: Icon(Icons.explore),
      label: 'Explore',
    ),
    // TODO: Uncomment when ScanQR page is ready
    BottomNavigationBarItem(
      icon: Icon(Icons.qr_code_scanner),
      activeIcon: Icon(Icons.qr_code),
      label: 'ScanQR',
    ),
    // TODO: Uncomment when Profile page is ready
    BottomNavigationBarItem(
      icon: Icon(Icons.person_outline),
      activeIcon: Icon(Icons.person),
      label: 'Profile',
    ),
  ];

  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    if (location.startsWith(AppRoutes.home)) {
      return 0;
    }
    if (location.startsWith(AppRoutes.explore)) {
      return 1;
    }
    if (location.startsWith(AppRoutes.scanQR)) {
      return 2;
    }
    if (location.startsWith(AppRoutes.profile)) {
      return 3;
    }
    return 0;
  }

  void _onTap(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.goNamed(AppRoutes.home);
        break;
      case 1:
        context.goNamed(AppRoutes.explore);
        break;
      case 2:
        context.goNamed(AppRoutes.scanQR);
        break;
      case 3:
        context.goNamed(AppRoutes.profile);
        break;
    }
  }

  String _getTitle(BuildContext context) {
    final GoRouterState state = GoRouterState.of(context);
    final String location = state.uri.toString();
    final String? name = state.name;

    if (name == AppRoutes.activityLeaderboard) {
      return 'Activity Leaderboard';
    } else if (name == AppRoutes.plans) {
      return 'Plans';
    } else if (location.startsWith(AppRoutes.home)) {
      return 'Home';
    } else if (location.startsWith(AppRoutes.explore)) {
      return 'Explore';
    } else if (location.startsWith(AppRoutes.scanQR)) {
      return 'Scan QR';
    } else if (location.startsWith(AppRoutes.profile)) {
      return 'Profile';
    } else if (location.startsWith(AppRoutes.gyms)) {
      return 'Gyms';
    }
    return 'Sportify';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getTitle(context)),
        automaticallyImplyLeading: false,
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            ),
          ),
        ],
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      endDrawer: const AppDrawer(),
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        items: _navBarItems,
        currentIndex: _calculateSelectedIndex(context),
        onTap: (index) => _onTap(index, context),
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF2C2C2C),
        selectedItemColor: const Color(0xFFEF6A2A),
        unselectedItemColor: Colors.white70,
        showSelectedLabels: true,
        showUnselectedLabels: true,
      ),
    );
  }
}

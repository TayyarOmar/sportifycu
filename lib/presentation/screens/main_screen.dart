import 'package:flutter/material.dart';
import 'package:sportify_app/providers/gym_provider.dart';
import 'package:sportify_app/presentation/screens/explore_screen.dart';
import 'package:sportify_app/presentation/screens/home_screen.dart';
import 'package:sportify_app/presentation/screens/profile/profile_screen.dart';
import 'package:sportify_app/presentation/screens/scan_qr_screen.dart';
import 'package:sportify_app/utils/app_colors.dart';
import 'package:sportify_app/presentation/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  static const List<Widget> _screens = <Widget>[
    HomeScreen(),
    ExploreScreen(),
    ScanQRScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // _pageController.jumpToPage(index);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/LOGO.png',
          height: 40,
        ),
        centerTitle: false,
        backgroundColor: AppColors.background,
        elevation: 0,
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
            ),
          ),
        ],
      ),
      endDrawer: const AppDrawer(),
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
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
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner),
            activeIcon: Icon(Icons.qr_code),
            label: 'ScanQR',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textTertiary,
        onTap: _onItemTapped,
        backgroundColor: AppColors.background,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
      ),
    );
  }
}

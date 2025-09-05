// lib/main_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_application_donation/browse_screen.dart';
import 'package:flutter_application_donation/donate_screen.dart';
import 'package:flutter_application_donation/messages_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final _browseNavigatorKey = GlobalKey<NavigatorState>();
  final _donateNavigatorKey = GlobalKey<NavigatorState>();
  final _messagesNavigatorKey = GlobalKey<NavigatorState>();
  final _myDevicesNavigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildNavigator(_browseNavigatorKey, const BrowseScreen()),
          _buildNavigator(_donateNavigatorKey, const DonateScreen()),
          _buildNavigator(_messagesNavigatorKey, const MessagesScreen()),
          _buildNavigator(_myDevicesNavigatorKey, const Center(child: Text('My Devices'))),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Browse',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: 'Upload',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.device_hub),
            label: 'My Devices',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF4CAF50),
        unselectedItemColor: Colors.grey[600],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  Widget _buildNavigator(GlobalKey<NavigatorState> navigatorKey, Widget root) {
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (context) => root,
        );
      },
    );
  }
}

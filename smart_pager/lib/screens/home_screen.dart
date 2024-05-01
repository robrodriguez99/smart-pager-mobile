import 'package:flutter/material.dart';
import 'package:smart_pager/config/cellules/bottom_nav.dart';
import 'package:smart_pager/screens/tabs/home_view.dart';
import 'package:smart_pager/screens/tabs/notifications_view.dart';
import 'package:smart_pager/screens/tabs/profile_view.dart';
import 'package:smart_pager/screens/tabs/current_queue_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    const HomeView(),
    const CurrentQueueView(),
    const NotificationsView(),
    const ProfileView(),
    // Agrega aquí tus otras vistas
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Center(
            child: Image.asset(
              'assets/images/black_logo.png',
              width: 50,
              height: 50,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: _widgetOptions,
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNav(
        _onItemTapped,
        _selectedIndex,
        key: UniqueKey(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:smart_pager/config/cellules/bottom_nav.dart';
import 'package:smart_pager/screens/tabs/home_view.dart';
import 'package:smart_pager/screens/tabs/notifications_view.dart';
import 'package:smart_pager/screens/tabs/profile_view.dart';
import 'package:smart_pager/screens/tabs/current_queue_view.dart';

class CurrentQueueScreen extends StatefulWidget {
  const CurrentQueueScreen({super.key});

  @override
  _CurrentQueueScreenState createState() => _CurrentQueueScreenState();
}

class _CurrentQueueScreenState extends State<CurrentQueueScreen> {
  int _selectedIndex = 1;
  final List<Widget> _widgetOptions = <Widget>[
    const HomeView(),
    const CurrentQueueView(
      isInQueue: true,
    ),
    const NotificationsView(),
    const ProfileView(),
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
          const SizedBox(height: 50),
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

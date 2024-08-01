import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_pager/config/cellules/bottom_nav.dart';
import 'package:smart_pager/providers/Future/current_queue_provider.dart';
import 'package:smart_pager/screens/tabs/home_view.dart';
import 'package:smart_pager/screens/tabs/notifications_view.dart';
import 'package:smart_pager/screens/tabs/profile_view.dart';
import 'package:smart_pager/screens/tabs/current_queue_view.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    const HomeView(),
    const CurrentQueueView(),
    const NotificationsView(),
    const ProfileView(),
  ];

  int _homeIndex = 0;
  int _queueIndex = 1;
  int _notificationsIndex = 2;
  int _profileIndex = 3;


  void _onItemTapped(int index) async{
      if (index == _queueIndex) {
        print('fetching queue');
        await ref.read(currentQueueProvider.notifier).fetchQueue().then((value) => 
          setState(() {
            _selectedIndex = index;
          })
        );
      } else {
        setState(() {
          _selectedIndex = index;
        });
      }
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

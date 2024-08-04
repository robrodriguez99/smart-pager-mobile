import 'package:flutter/material.dart';
import 'package:smart_pager/config/cellules/bottom_nav.dart';
import 'package:smart_pager/providers/Future/current_queue_provider.dart';
import 'package:smart_pager/screens/tabs/home_view.dart';
import 'package:smart_pager/screens/tabs/notifications_view.dart';
import 'package:smart_pager/screens/tabs/profile_view.dart';
import 'package:smart_pager/screens/tabs/current_queue_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CurrentQueueScreen extends ConsumerStatefulWidget {
  const CurrentQueueScreen({super.key});

  @override
  _CurrentQueueScreenState createState() => _CurrentQueueScreenState();
}

class _CurrentQueueScreenState extends ConsumerState<CurrentQueueScreen> {
  int _selectedIndex = 1;
  int _queueIndex = 1;

  final List<Widget> _widgetOptions = <Widget>[
    const HomeView(),
    const CurrentQueueView(),
    const NotificationsView(),
    const ProfileView(),
  ];

  void _onItemTapped(int index) async {
    if (index == _queueIndex) {
      print('fetching queue');
      await ref
          .read(currentQueueProvider.notifier)
          .fetchQueue()
          .then((value) => setState(() {
                _selectedIndex = index;
              }));
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

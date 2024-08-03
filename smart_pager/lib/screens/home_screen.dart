import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_pager/config/cellules/bottom_nav.dart';
import 'package:smart_pager/providers/Future/current_queue_provider.dart';
import 'package:smart_pager/screens/tabs/home_view.dart';
import 'package:smart_pager/screens/tabs/notifications_view.dart';
import 'package:smart_pager/screens/tabs/profile_view.dart';
import 'package:smart_pager/screens/tabs/current_queue_view.dart';

class HomeScreen extends ConsumerStatefulWidget {
  final int initialIndex;

  const HomeScreen({super.key, this.initialIndex = 0});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late int _selectedIndex;
  final List<Widget> _widgetOptions = <Widget>[
    const HomeView(),
    const CurrentQueueView(),
    const NotificationsView(),
    const ProfileView(),
  ];

  int _queueIndex = 1;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

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

import 'package:flutter/material.dart';
import 'package:smart_pager/config/cellules/bottom_nav.dart';



class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Stack(
          children: [
            Text('Home Screen'),
            BottomNav()
          ]
        )
        
      ),
    );
  }
}
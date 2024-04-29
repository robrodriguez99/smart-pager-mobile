import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smart_pager/config/cellules/bottom_nav.dart';
import 'package:smart_pager/config/tokens/sp_colors.dart';
import 'package:smart_pager/config/tokens/sp_custom_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                    child: Image.asset('assets/images/black_logo.png',
                    width: 80, height: 80, fit: BoxFit.contain,
                    ),
                ),
                const SizedBox(height: 20),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: CustomText(
                      text: 'Restaurantes destacados',
                      color: SPColors.heading,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            BottomNav()
          ],
        ),
      ),
    );
  }
}

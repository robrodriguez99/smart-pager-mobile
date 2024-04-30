import 'package:flutter/material.dart';
import 'package:smart_pager/config/cellules/restaurant_card.dart';
import 'package:smart_pager/config/tokens/sp_colors.dart';
import 'package:smart_pager/config/tokens/sp_custom_text.dart';


class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
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
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: RestaurantCard(
                    restaurantName: 'El Bulli',
                    location: 'Barcelona, España',
                    estimatedWaitTime: '30 minutos',
                  )
                    )
                  ),
                  
              ],
            ),
            
          ],
          
        ),
      );
  }
}
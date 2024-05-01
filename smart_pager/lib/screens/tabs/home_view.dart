import 'package:flutter/material.dart';
import 'package:smart_pager/config/cellules/cards/restaurant_card.dart';
import 'package:smart_pager/config/tokens/sp_colors.dart';
import 'package:smart_pager/config/tokens/sp_custom_text.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CustomText(
              text: 'Restaurantes Destacados',
              color: SPColors.heading,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 10),
            RestaurantCard(
                restaurantName: 'El Bulli',
                category: 'Cocina Japonesa',
                estimatedWaitTime: '30 minutos',
                isPromoted: true),
            SizedBox(height: 10),
            RestaurantCard(
                restaurantName: 'El Bulli',
                category: 'Cocina Japonesa',
                estimatedWaitTime: '30 minutos',
                isPromoted: true),
            SizedBox(height: 10),
            RestaurantCard(
                restaurantName: 'El Bulli',
                category: 'Cocina Japonesa',
                estimatedWaitTime: '30 minutos',
                isPromoted: false),
            SizedBox(height: 10),
            RestaurantCard(
                restaurantName: 'El Bulli',
                category: 'Cocina Japonesa',
                estimatedWaitTime: '30 minutos',
                isPromoted: false),
          ],
        ),
      ),
    );
  }
}

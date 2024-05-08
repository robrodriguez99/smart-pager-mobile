import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_pager/config/cellules/cards/restaurant_card.dart';
import 'package:smart_pager/config/tokens/sp_colors.dart';
import 'package:smart_pager/config/tokens/sp_custom_text.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: SPColors.lightGray,
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextFormField(
                readOnly: true,
                decoration: const InputDecoration(
                  hintText: 'Buscar restaurantes',
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
                onTap: () {
                  GoRouter.of(context).push('/search');
                },
              ),
            ),
            const SizedBox(height: 20),
            const CustomText(
              text: 'Restaurantes Destacados',
              color: SPColors.heading,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 10),
            const RestaurantCard(
              restaurantName: 'El Bulli',
              category: 'Cocina Japonesa',
              estimatedWaitTime: '30 minutos',
              isPromoted: true,
              isClosed: false,
            ),
            const SizedBox(height: 10),
            const RestaurantCard(
              restaurantName: 'El Bulli',
              category: 'Cocina Japonesa',
              estimatedWaitTime: '30 minutos',
              isPromoted: true,
              isClosed: false,
            ),
            const SizedBox(height: 10),
            const RestaurantCard(
              restaurantName: 'El Bulli',
              category: 'Cocina Japonesa',
              estimatedWaitTime: '30 minutos',
              isPromoted: false,
              isClosed: false,
            ),
            const SizedBox(height: 10),
            const RestaurantCard(
              restaurantName: 'El Bulli',
              category: 'Cocina Japonesa',
              estimatedWaitTime: '30 minutos',
              isPromoted: false,
              isClosed: true,
            ),
          ],
        ),
      ),
    );
  }
}

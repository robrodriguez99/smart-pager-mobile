import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_pager/config/cellules/cards/restaurant_card.dart';
import 'package:smart_pager/config/tokens/sp_colors.dart';
import 'package:smart_pager/config/tokens/sp_custom_text.dart';

class SearchResultsScreen extends StatelessWidget {
  const SearchResultsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            size: 30,
          ),
          onPressed: () {
            GoRouter.of(context).pop();
          },
        ),
        title: const CustomText(
          text: 'Resultados',
          color: SPColors.heading,
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SingleChildScrollView(
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
                text: 'Restaurantes',
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
              ),
              const SizedBox(height: 10),
              const RestaurantCard(
                restaurantName: 'El Bulli',
                category: 'Cocina Japonesa',
                estimatedWaitTime: '30 minutos',
                isPromoted: true,
              ),
              const SizedBox(height: 10),
              const RestaurantCard(
                restaurantName: 'El Bulli',
                category: 'Cocina Japonesa',
                estimatedWaitTime: '30 minutos',
                isPromoted: false,
              ),
              const SizedBox(height: 10),
              const RestaurantCard(
                restaurantName: 'El Bulli',
                category: 'Cocina Japonesa',
                estimatedWaitTime: '30 minutos',
                isPromoted: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
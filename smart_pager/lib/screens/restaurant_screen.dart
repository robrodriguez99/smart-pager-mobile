import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_pager/config/molecules/buttons/gradient_button.dart';
import 'package:smart_pager/config/tokens/sp_colors.dart';
import 'package:smart_pager/config/tokens/sp_custom_text.dart';

class RestaurantScreen extends StatefulWidget {
  const RestaurantScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {

  

 @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => GoRouter.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back,
            color: SPColors.activeBlack,
            size: 30,
          ),
        ),
        title: const CustomText(
          text: 'El Bulli',
          fontSize: 35,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                // Wrap the Image.asset with Center widget
                child: Image.asset(
                  'assets/images/black_logo.png', // Path to your restaurant image asset
                  width: 200, // Adjust size as needed
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 30),
              const Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: SPColors.activeBlack,
                    size: 16,
                  ),
                  SizedBox(width: 4),
                  CustomText(
                    text: 'Barcelona, España',
                    fontSize: 20,
                    color: SPColors.activeBlack,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Row(
                children: [
                  Icon(
                    Icons.restaurant,
                    color: SPColors.activeBlack,
                    size: 16,
                  ),
                  SizedBox(width: 4),
                  CustomText(
                    text: 'Comida japonesa',
                    fontSize: 20,
                    color: SPColors.activeBlack,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Row(
                children: [
                  Icon(
                    Icons.access_time,
                    color: SPColors.activeBlack,
                    size: 16,
                  ),
                  SizedBox(width: 4),
                  CustomText(
                    text: '30 minutos',
                    fontSize: 20,
                    color: SPColors.activeBlack,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              GradientButton(
                icon: Icons.restaurant_menu,
                text: 'Ver menú',
                gradientColors: const [SPColors.primary, SPColors.primary],
                onPressed: () {
                  GoRouter.of(context).push('/menu');
                },
              ),
              const SizedBox(height: 16),
              GradientButton(
                icon: Icons.access_time,
               text: "Anotarse en la lista de espera",
                gradientColors: [SPColors.secondary, SPColors.secondary2],
                onPressed: () {
                    GoRouter.of(context).push('/queue');
                  },
              )
            ],
          ),
        ),
      ),
    );
  }
}

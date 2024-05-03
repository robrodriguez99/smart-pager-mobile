import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_pager/config/molecules/buttons/gradient_button.dart';
import 'package:smart_pager/config/tokens/sp_colors.dart';
import 'package:smart_pager/config/tokens/sp_custom_text.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';

class RestaurantScreen extends StatefulWidget  {
  const RestaurantScreen({Key? key}) : super(key: key);
  
  @override
  State<StatefulWidget> createState() => _RestaurantScreenState();
  

   
  }

class _RestaurantScreenState extends State<RestaurantScreen> {

  

 @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(
                  Icons.arrow_back,
                  color: SPColors.activeBlack,
                  size: 30,
                ),
              ),
              const CustomText(
                text: 'El Bulli',
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 8),
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
              const CustomText(
                text: 'Descripción',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 8),
              const CustomText(
                text:
                    'El Bulli fue un restaurante de alta cocina situado en la localidad de Montjoi, en la Costa Brava, en Cataluña, España. Fundado por Ferran Adrià y Juli Soler en 1961 como chiringuito, en 1983 se convirtió en un restaurante de alta cocina.​',
                fontSize: 16,
                color: SPColors.activeBlack,
                overflow: TextOverflow.visible,
              ),

              const SizedBox(height: 16),
              GradientButton(
                icon: Icons.restaurant_menu,
                text: 'Ver menú',
                gradientColors: const [SPColors.primary, SPColors.primaryGradient],
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


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_pager/config/molecules/buttons/gradient_button.dart';
import 'package:smart_pager/config/tokens/sp_colors.dart';
import 'package:smart_pager/config/tokens/sp_custom_text.dart';
import 'package:smart_pager/providers/controllers/restaurant_controller.dart';

class RestaurantScreen extends ConsumerStatefulWidget{
  final bool closed = false; //TODO:
  final String restaurantSlug;

  const RestaurantScreen({Key? key, required this.restaurantSlug }) : super(key: key);

  @override
  ConsumerState<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends ConsumerState<RestaurantScreen> {
  bool showOpeningTimes = false; // State to toggle opening times

  @override
  Widget build(BuildContext context) {
    // Get the restaurant data from the controller and set the current restaurant
    final futureRestaurant = ref.watch(restaurantControllerProvider.notifier).getRestaurant(widget.restaurantSlug);

    return FutureBuilder(
      future: futureRestaurant,
      builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        // Mientras se obtienen los datos, puedes mostrar un indicador de carga
        return const Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        // Manejar errores si los hay
        return Center(child: Text('Error al cargar los datos del restaurante'));
      } else if (!snapshot.hasData) {
        // Si no hay datos, puedes mostrar un mensaje apropiado
        return Center(child: Text('No se encontraron datos del restaurante'));
      }

      final restaurant = snapshot.data!;

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
        title: CustomText(
          text: restaurant.name, //restaurant name
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
                  'assets/images/black_logo.png', // Path to your restaurant image asset //TODO: image
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
                    text: 'Barcelona, España', //TODO: location
                    fontSize: 20,
                    color: SPColors.activeBlack,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(
                    Icons.restaurant,
                    color: SPColors.activeBlack,
                    size: 16,
                  ),
                  SizedBox(width: 4),
                  CustomText(
                    text: restaurant.type,
                    fontSize: 20,
                    color: SPColors.activeBlack,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(
                    Icons.access_time,
                    color: SPColors.activeBlack,
                    size: 16,
                  ),
                  SizedBox(width: 4),
                  CustomText(
                    text: "${restaurant.avgTimePerTable} ' de espera", 
                    fontSize: 20,
                    color: SPColors.activeBlack,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Opening times section
              Center(
                // Center the toggle text and icon
                child: InkWell(
                  onTap: () {
                    setState(() {
                      showOpeningTimes = !showOpeningTimes;
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Add space between text and icon
                      if (!widget.closed) ...[
                        const Icon(
                          Icons.access_alarm,
                          color: SPColors.activeBlack,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        const CustomText(
                          text: 'Horarios de apertura', //TODO: opening times
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: SPColors.activeBlack,
                        ),
                      ] else ...[
                        const Icon(
                          Icons.access_alarm,
                          color: SPColors.red,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        const Center(
                          child: CustomText(
                            text: 'Cerrado',
                            fontSize: 20,
                            color: SPColors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                      const SizedBox(
                          width: 8), // Add space between text and icon
                      Icon(
                        showOpeningTimes
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        size: 30,
                        color: SPColors.activeBlack,
                      ),
                    ],
                  ),
                ),
              ),
              if (showOpeningTimes) ...[
                const SizedBox(height: 8),
                // Center the opening times horizontally
                Center(
                  child: _buildOpeningTimes(),
                ),
              ],
              const SizedBox(height: 16),
              if (!widget.closed) ...[
                // Display the "Anotarse en la cola" button if the restaurant is not closed
                GradientButton(
                  icon: Icons.wb_twilight,
                  text: "Anotarse en la cola",
                  gradientColors: [SPColors.secondary, SPColors.secondary],
                  onPressed: () {
                    GoRouter.of(context).push('/queue');
                  },
                ),
              ],
              const SizedBox(height: 16),
              // Buttons
              GradientButton(
                icon: Icons.restaurant_menu,
                text: 'Ver menú',
                gradientColors: const [SPColors.primary, SPColors.primary],
                onPressed: () {
                  GoRouter.of(context).push('/menu'); //TODO: menu
                },
              ),
            ],
          ),
        ),
      ),
   
    );
      }
    );

  }

  Widget _buildOpeningTimes() {
    // Define your opening times data here
    final List<String> openingTimes = [
      'Lunes: 10:00 - 20:00',
      'Martes: 10:00 - 20:00',
      'Miércoles: 10:00 - 20:00',
      'Jueves: 10:00 - 20:00',
      'Viernes: 10:00 - 20:00',
      'Sábado: Cerrado',
      'Domingo: 10:00 - 18:00',
    ];

    // Create a list of text widgets to display opening times
    final List<Widget> openingTimeWidgets = openingTimes
        .map(
          (time) => CustomText(
            text: time,
            fontSize: 20,
            color: SPColors.activeBlack,
          ),
        )
        .toList();

    // Return a column containing the opening time widgets
    return Column(
      children: openingTimeWidgets,
    );
  }
}

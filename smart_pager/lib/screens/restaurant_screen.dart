import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_pager/config/molecules/buttons/gradient_button.dart';
import 'package:smart_pager/config/tokens/sp_colors.dart';
import 'package:smart_pager/config/tokens/sp_custom_text.dart';
import 'package:smart_pager/data/models/operating_hours_model.dart';
import 'package:smart_pager/providers/controllers/restaurant_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class RestaurantScreen extends ConsumerStatefulWidget {
  final bool closed = false; //TODO:
  final String restaurantSlug;

  const RestaurantScreen({Key? key, required this.restaurantSlug})
      : super(key: key);

  @override
  ConsumerState<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends ConsumerState<RestaurantScreen> {
  bool showOpeningTimes = true; // State to toggle opening times
  @override
  Widget build(BuildContext context) {
    // Get the restaurant data from the controller and set the current restaurant
    final futureRestaurant = ref
        .watch(restaurantControllerProvider.notifier)
        .getRestaurant(widget.restaurantSlug);

    return FutureBuilder(
        future: futureRestaurant,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Mientras se obtienen los datos, puedes mostrar un indicador de carga
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Manejar errores si los hay
            return const Center(
                child: Text('Error al cargar los datos del restaurante'));
          } else if (!snapshot.hasData) {
            // Si no hay datos, puedes mostrar un mensaje apropiado
            return const Center(
                child: Text('No se encontraron datos del restaurante'));
          }

          final restaurant = snapshot.data!;
          String restaurantAddress = 'Ubicación no disponible';

          if (restaurant.location != 'no_location') {
            restaurantAddress = restaurant.location['address'];
          }

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
              title: Flexible(
                child: CustomText(
                  text: restaurant.name, // restaurant name
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.visible,
                  maxLines: null, // Allow text to wrap to multiple lines
                ),
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
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (restaurant.location != null &&
                                restaurantAddress !=
                                    'Ubicación no disponible') {
                              _launchMapsUrl(restaurant.location['latitude'],
                                  restaurant.location['longitude']);
                            }
                          },
                          child: Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: SPColors.activeBlack,
                                size: 20,
                              ),
                              const SizedBox(width: 10),
                              CustomText(
                                text: extractAddress(
                                    restaurantAddress), // Ubicación del restaurante
                                fontSize: 20,
                                color: SPColors.activeBlack,
                                textDecoration: restaurantAddress !=
                                        'Ubicación no disponible'
                                    ? TextDecoration.underline
                                    : TextDecoration.none,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.restaurant,
                          color: SPColors.activeBlack,
                          size: 20,
                        ),
                        SizedBox(width: 10),
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
                          size: 20,
                        ),
                        SizedBox(width: 10),
                        CustomText(
                          text: "${restaurant.avgTimePerTable}' de espera",
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
                            // showOpeningTimes = !showOpeningTimes;
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
                                text:
                                    'Horarios de apertura', //TODO: opening times
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
                        child: _buildOpeningTimes(restaurant.operatingHours!),
                      ),
                    ],
                    const SizedBox(height: 16),
                    if (!widget.closed) ...[
                      // Display the "Anotarse en la cola" button if the restaurant is not closed
                      GradientButton(
                        icon: Icons.wb_twilight,
                        text: "Anotarse en la cola",
                        gradientColors: [
                          SPColors.secondary,
                          SPColors.secondary
                        ],
                        onPressed: () {
                          GoRouter.of(context).push('/queue');
                        },
                      ),
                    ],
                    const SizedBox(height: 16),
                    // Buttons
                    restaurant.menu != 'no_menu'
                        ? GradientButton(
                            icon: Icons.restaurant_menu,
                            text: 'Ver menú',
                            gradientColors: const [
                              SPColors.primary,
                              SPColors.primary
                            ],
                            onPressed: () {
                              GoRouter.of(context).pushNamed(
                                //TODO: CHECKEAR ESTO EN EL CELULAR PQ EN EL EMULADOR NO FUNCIONA
                                'menu',
                                pathParameters: {'menu': restaurant.menu},
                              );
                            },
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget _buildOpeningTimes(RestaurantOperatingHours operatingHours) {
    
    final List<Widget> openingTimesWidgets = operatingHours.days.entries
        .map((day) {
          final dayName = day.key;
          final dayData = day.value;
          final isOpen = dayData.isOpen;
          final intervals = dayData.intervals;

          if (!isOpen) {
            return CustomText(
              text: '$dayName: Cerrado',
              fontSize: 20,
              color: SPColors.red,
            );
          }

          final openingTimes = intervals
              .map((interval) =>
                  '${interval.openingTime} - ${interval.closingTime}')
              .toList();

          return Column(
            children: [
              CustomText(
                text: '$dayName: ${openingTimes.join(', ')}',
                fontSize: 20,
                color: SPColors.activeBlack,
              ),
              const SizedBox(height: 8),
            ],
          );
        })
        .toList();

    // Return a column containing the opening time widgets
    return Column(
      children: openingTimesWidgets,
    );
  }

  void _launchMapsUrl(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunchUrl(Uri.parse(googleUrl))) {
      await launchUrl(Uri.parse(googleUrl));
    } else {
      throw 'Could not launch $googleUrl';
    }
  }

  String extractAddress(String fullAddress) {
    List<String> parts = fullAddress.split(',');
    return parts[0].trim();
  }
}

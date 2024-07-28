// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:smart_pager/config/molecules/buttons/gradient_button.dart';
import 'package:smart_pager/config/tokens/sp_colors.dart';
import 'package:smart_pager/config/tokens/sp_custom_text.dart';
import 'package:smart_pager/data/models/operating_hours_model.dart';
import 'package:smart_pager/providers/controllers/restaurant_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class RestaurantScreen extends ConsumerStatefulWidget {
  final String restaurantSlug;

  const RestaurantScreen({Key? key, required this.restaurantSlug})
      : super(key: key);

  @override
  ConsumerState<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends ConsumerState<RestaurantScreen> {
  bool showOpeningTimes = false; // State to toggle opening times
  bool closed = false; // State to indicate if the restaurant is closed

  @override
  void initState() {
    super.initState();
    _checkIfRestaurantIsClosed();
  }

  @override
  Widget build(BuildContext context) {
    // Get the restaurant data from the controller and set the current restaurant
    final futureRestaurant = ref
        .watch(restaurantControllerProvider.notifier)
        .getRestaurant(widget.restaurantSlug);

    return FutureBuilder(
        future: futureRestaurant,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting &&
              !snapshot.hasData) {
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
              title: CustomText(
                text: restaurant.name, // restaurant name
                fontSize: 25,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.visible,
                maxLines: null, // Allow text to wrap to multiple lines
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
                      child: restaurant.picture != 'no_picture'
                          ? Image.network(
                              restaurant
                                  .picture, // Path to your restaurant image asset //TODO: image
                              width: 200, // Adjust size as needed
                              height: 200,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
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
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                    maxWidth: MediaQuery.of(context)
                                            .size
                                            .width -
                                        80), // Adjust the maxWidth as needed
                                child: CustomText(
                                  textAlign: TextAlign.left,
                                  text: extractAddress(
                                      restaurantAddress), // Ubicación del restaurante
                                  fontSize: 20,
                                  color: SPColors.activeBlack,
                                  textDecoration: restaurantAddress !=
                                          'Ubicación no disponible'
                                      ? TextDecoration.underline
                                      : TextDecoration.none,
                                  overflow: TextOverflow.visible,
                                ),
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
                        const SizedBox(width: 10),
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
                        const SizedBox(width: 10),
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
                            showOpeningTimes = !showOpeningTimes;
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.access_alarm,
                              color: SPColors.activeBlack,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            const CustomText(
                              text: 'Horarios de apertura',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: SPColors.activeBlack,
                            ),
                            const SizedBox(width: 8),
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
                    if (!closed) ...[
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
                    if (closed) ...[
                      Center(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          margin: const EdgeInsets.symmetric(vertical: 16),
                          width: double
                              .infinity, // Ensures the container takes the full width
                          decoration: BoxDecoration(
                            color: SPColors.red.withOpacity(0.1),
                            border: Border.all(color: SPColors.red),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              CustomText(
                                text: 'Cerrado',
                                fontSize: 24,
                                color: SPColors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],

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

  void _checkIfRestaurantIsClosed() {
    // Get the current time in GMT-3
    DateTime now = DateTime.now().toUtc().subtract(const Duration(hours: 3));

    final futureRestaurant = ref
        .read(restaurantControllerProvider.notifier)
        .getRestaurant(widget.restaurantSlug);

    futureRestaurant.then((restaurant) {
      if (restaurant.operatingHours == null) {
        setState(() {
          closed = false;
        });
        return;
      }

      // Get the current day of the week
      String currentDay = _getDayOfWeek(now.weekday);

      // Get the operating hours for the current day
      final dayData = restaurant.operatingHours!.days[currentDay];

      print(dayData?.isOpen);
      if (dayData == null) {
        setState(() {
          closed = false;
        });
        return;
      }
      if (!dayData.isOpen) {
        setState(() {
          closed = true;
        });
        return;
      } else {
        setState(() {
          closed = false;
        });
        return;
      }
    });
  }

  String _getDayOfWeek(int weekday) {
    switch (weekday) {
      case 1:
        return 'Lunes';
      case 2:
        return 'Martes';
      case 3:
        return 'Miércoles';
      case 4:
        return 'Jueves';
      case 5:
        return 'Viernes';
      case 6:
        return 'Sábado';
      case 7:
        return 'Domingo';
      default:
        return '';
    }
  }

  DateTime _getDateTimeFromTimeString(
      String timeString, DateTime referenceDate) {
    List<String> parts = timeString.split(':');
    int hours = int.parse(parts[0]);
    int minutes = int.parse(parts[1]);

    return DateTime(referenceDate.year, referenceDate.month, referenceDate.day,
        hours, minutes);
  }

  Widget _buildOpeningTimes(RestaurantOperatingHours operatingHours) {
    // Define the days of the week in the desired order
    final List<String> orderedDays = [
      'Lunes',
      'Martes',
      'Miércoles',
      'Jueves',
      'Viernes',
      'Sábado',
      'Domingo'
    ];

    // Create a list of widgets based on the ordered days
    final List<Widget> openingTimesWidgets = orderedDays.map((dayName) {
      final dayData = operatingHours.days[dayName];
      final isOpen = dayData?.isOpen ?? false;
      final intervals = dayData?.intervals ?? [];

      final openingTimes = intervals
          .map(
              (interval) => '${interval.openingTime} - ${interval.closingTime}')
          .join(', ');

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  isOpen ? Icons.access_alarm : Icons.close,
                  color: isOpen ? SPColors.activeBlack : SPColors.red,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '$dayName: ',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: isOpen ? SPColors.activeBlack : SPColors.red,
                          ),
                        ),
                        TextSpan(
                          text: isOpen ? openingTimes : 'Cerrado',
                          style: TextStyle(
                            fontSize: 20,
                            color: isOpen ? SPColors.activeBlack : SPColors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const Divider(
              color: SPColors.darkGray,
              thickness: 1,
            ),
          ],
        ),
      );
    }).toList();

    // Return a column containing the opening time widgets
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: openingTimesWidgets,
    );
  }

  void _launchMapsUrl(double latitude, double longitude) async {
    MapsLauncher.launchCoordinates(latitude, longitude);
  }

  String extractAddress(String fullAddress) {
    List<String> parts = fullAddress.split(',');
    return parts[0].trim();
  }
}

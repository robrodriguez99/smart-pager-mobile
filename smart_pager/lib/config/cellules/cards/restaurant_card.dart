import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_pager/config/tokens/sp_colors.dart';
import 'package:smart_pager/config/tokens/sp_custom_text.dart';
import 'package:smart_pager/data/models/operating_hours_model.dart';
import 'package:smart_pager/data/models/restaurant_model.dart';
import 'package:smart_pager/providers/controllers/restaurant_controller.dart';

class RestaurantCard extends StatefulWidget {
  final SmartPagerRestaurant restaurant;

  const RestaurantCard({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  @override
  _RestaurantCardState createState() => _RestaurantCardState();
}

class _RestaurantCardState extends State<RestaurantCard> {
  bool closed = false;

  @override
  void initState() {
    super.initState();
    _checkIfRestaurantIsClosed(widget.restaurant);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => GoRouter.of(context).pushNamed(
        'restaurant',
        pathParameters: {'slug': widget.restaurant.slug},
      ),
      child: Card(
        elevation: 2,
        color: SPColors.primary2,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Image
                  DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.black, // Border color
                        width: 2, // Border width
                      ),
                    ),
                    child: SizedBox(
                      width: 60, // Adjust the width as needed
                      height: 60, // Adjust the height as needed
                      child: Center(
                        child: SizedBox(
                          width: 50, // Adjust the width as needed
                          height: 50, // Adjust the height as needed
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  8), // Adjust border radius to match the inner image
                              image: const DecorationImage(
                                image:
                                    AssetImage('assets/images/black_logo.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16), // Spacer between image and details
                  // Details Column
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          constraints: widget.restaurant.isPromoted
                              ? const BoxConstraints(maxWidth: 144)
                              : closed
                                  ? const BoxConstraints(maxWidth: 180)
                                  : null,
                          alignment: Alignment.centerLeft,
                          child: CustomText(
                            height: 1.2,
                            text: widget.restaurant.name,
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.visible,
                            textAlign: TextAlign.left,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: <Widget>[
                            const Icon(
                              Icons.restaurant,
                              color: SPColors.activeBlack,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            CustomText(
                              text: widget.restaurant.type,
                              fontSize: 16,
                              color: SPColors.activeBlack,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: <Widget>[
                            const Icon(
                              Icons.access_time,
                              color: SPColors.activeBlack,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            CustomText(
                              text:
                                  "${widget.restaurant.avgTimePerTable}' de espera",
                              fontSize: 16,
                              color: SPColors.activeBlack,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // Display either "Patrocinado" or "Cerrado" tag based on conditions
              if (closed)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    child: const CustomText(
                      text: 'Cerrado',
                      fontSize: 13,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              else if (widget.restaurant.isPromoted)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: const BoxDecoration(
                      color: SPColors.primary,
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    child: const CustomText(
                      text: 'Patrocinado',
                      fontSize: 13,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _checkIfRestaurantIsClosed(SmartPagerRestaurant restaurant) {
    // Get the current time in GMT-3
    DateTime now = DateTime.now().toUtc().subtract(const Duration(hours: 3));

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

    // Check if the current time falls within any of the intervals
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
}

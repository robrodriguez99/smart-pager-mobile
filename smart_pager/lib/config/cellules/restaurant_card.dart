import 'package:flutter/material.dart';
import 'package:smart_pager/config/tokens/sp_colors.dart';
import 'package:smart_pager/config/tokens/sp_custom_text.dart';

class RestaurantCard extends StatelessWidget {
  final String restaurantName;
  final String location;
  final String estimatedWaitTime;

  const RestaurantCard({
    Key? key,
    required this.restaurantName,
    required this.location,
    required this.estimatedWaitTime,
  }) : super(key: key);

  @override
Widget build(BuildContext context) {
  return Card(
    color: SPColors.primary2,
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CustomText(
            text: restaurantName,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 8),
          Row(
            children: <Widget>[
              const Icon(
                Icons.location_on,
                color: SPColors.activeBlack,
                size: 16,
              ),
              const SizedBox(width: 4),
              CustomText(
                text: location,
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
                text: estimatedWaitTime,
                fontSize: 16,
                color: SPColors.activeBlack,
              ),
            ],
          ),          
         
        ],
      ),
    ),
  );
}
}

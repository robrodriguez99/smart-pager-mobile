import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_pager/config/tokens/sp_colors.dart';
import 'package:smart_pager/config/tokens/sp_custom_text.dart';

class RestaurantCard extends StatelessWidget {
  final String restaurantName;
  final String category;
  final String estimatedWaitTime;
  final bool isPromoted;

  const RestaurantCard({
    Key? key,
    required this.restaurantName,
    required this.category,
    required this.estimatedWaitTime,
    required this.isPromoted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => GoRouter.of(context).push('/restaurant'),
      child: Card(
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
                        CustomText(
                          text: restaurantName,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
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
                              text: category,
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
                ],
              ),
              if (isPromoted)
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
}

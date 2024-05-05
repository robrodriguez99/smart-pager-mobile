import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_pager/config/molecules/buttons/gradient_button.dart';
import 'package:smart_pager/config/tokens/sp_colors.dart';
import 'package:smart_pager/config/tokens/sp_custom_text.dart';

class CurrentQueueView extends StatelessWidget {
  final bool isInQueue;

  const CurrentQueueView({super.key, required this.isInQueue});
  @override
  Widget build(BuildContext context) {
    if (isInQueue) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Flexible(
              child: CustomText(
                text: 'Actualmente estás en la cola de:',
                color: SPColors.heading,
                fontSize: 20,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 20),
            const Flexible(
              child: CustomText(
                text: 'El Bulli',
                color: SPColors.heading,
                fontSize: 25,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              height: 220, // Adjust this height as needed
              child: Center(
                // Wrap the Image.asset with Center widget
                child: Image.asset(
                  'assets/images/black_logo.png', // Path to your restaurant image asset
                  width: 200, // Adjust size as needed
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 15),
            const Flexible(
              child: CustomText(
                text: 'Tiempo estimado de espera:',
                color: SPColors.activeBlack,
                fontSize: 20,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.access_time_filled,
                  color: SPColors.activeBlack,
                  size: 16,
                ),
                Flexible(
                  child: CustomText(
                    text: ' 20 minutos',
                    color: SPColors.darkGray,
                    fontSize: 20,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Flexible(
              child: CustomText(
                text: 'Te avisaremos cuando tu mesa esté lista',
                color: SPColors.darkGray,
                fontSize: 18,
                overflow: TextOverflow.visible,
              ),
            ),
            const SizedBox(height: 30),
            Container(
              margin: const EdgeInsets.symmetric(
                  horizontal: 20), // Add left and right margin here
              child: GradientButton(
                icon: Icons.restaurant_menu,
                text: 'Ver menú',
                gradientColors: const [SPColors.primary, SPColors.primary],
                onPressed: () {
                  GoRouter.of(context).push('/menu');
                },
              ),
            ),
            const Spacer(),
            const CustomText(
              text: 'Si cambias de opinión podés retirarte de la cola',
              color: SPColors.darkGray,
              fontSize: 16,
              overflow: TextOverflow.visible,
            ),
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.symmetric(
                  horizontal: 20), // Add left and right margin here
              child: GradientButton(
                icon: Icons.cancel,
                text: "Cancelar turno",
                gradientColors: const [SPColors.red, SPColors.red],
                onPressed: () {
                  //
                },
              ),
            ),
          ],
        ),
      );
    } else {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png', // Path to your placeholder image asset
              width: 200, // Adjust size as needed
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            const Flexible(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: CustomText(
                  text: 'No estás anotado en ninguna cola actualmente',
                  color: SPColors.heading,
                  fontSize: 22,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.visible,
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Flexible(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: CustomText(
                  text: '¡Te ayudamos a ver donde comer!',
                  color: SPColors.heading,
                  fontSize: 22,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.visible,
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 250, // Make the button as wide as its parent
              height: 50, // Set the desired height
              child: Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: 10), // Add left and right margin here
                child: GradientButton(
                  icon: Icons.search,
                  text: "Buscar",
                  gradientColors: const [SPColors.primary, SPColors.primary],
                  onPressed: () {
                    GoRouter.of(context).push('/search');
                  },
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}

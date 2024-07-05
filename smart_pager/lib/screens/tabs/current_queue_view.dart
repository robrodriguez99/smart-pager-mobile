import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rxdart/rxdart.dart';
import 'package:smart_pager/config/molecules/buttons/gradient_button.dart';
import 'package:smart_pager/config/tokens/sp_colors.dart';
import 'package:smart_pager/config/tokens/sp_custom_text.dart';
import 'package:smart_pager/data/models/current_queue_model.dart';
import 'package:smart_pager/providers/Future/current_queue_provider.dart';
import 'package:smart_pager/providers/api_provider.dart';
import 'package:smart_pager/providers/repository_provider.dart';
import 'package:smart_pager/providers/user_provider.dart';

class CurrentQueueView extends ConsumerStatefulWidget {

  const CurrentQueueView({super.key});

  @override
  ConsumerState<CurrentQueueView> createState() => _CurrentQueueViewState();
  
}

class _CurrentQueueViewState extends ConsumerState<CurrentQueueView> {
  bool isInQueue = false;

  @override
  Widget build(BuildContext context) {
    ref.read(currentQueueProvider.notifier).refresh();
    final futureQueue = ref.watch(currentQueueProvider);
    print('futureQueue: $futureQueue');
    
    
    if (futureQueue!=null) {
      isInQueue = true;
    } else {
      isInQueue = false;
    }
    if (isInQueue) {
      return Container(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
                const CustomText(
                  text: 'Actualmente estás en la cola de:',
                  color: SPColors.heading,
                  fontSize: 20,
                  overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 20),
              CustomText(
                  text: futureQueue!.restaurant.name,
                  color: SPColors.heading,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
                
              SizedBox(
                height: 150, // Adjust this height as needed
                child: Center(
                  // Wrap the Image.asset with Center widget
                  child: Image.asset(
                    'assets/images/black_logo.png', // Path to your restaurant image asset
                    width: 150, // Adjust size as needed
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
                const CustomText(
                  text: 'Tiempo estimado de espera:',
                  color: SPColors.activeBlack,
                  fontSize: 20,
                  overflow: TextOverflow.ellipsis,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.access_time_filled,
                    color: SPColors.activeBlack,
                    size: 16,
                  ),
                  Flexible(
                    child: CustomText(
                      text: ' ${futureQueue.waitingTime} minutos',
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

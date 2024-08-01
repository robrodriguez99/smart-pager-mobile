// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_pager/config/molecules/buttons/gradient_button.dart';
import 'package:smart_pager/config/tokens/sp_colors.dart';
import 'package:smart_pager/config/tokens/sp_custom_text.dart';
import 'package:smart_pager/providers/Future/current_queue_provider.dart';
import 'package:smart_pager/providers/api_provider.dart';

class CurrentQueueView extends ConsumerStatefulWidget {
  const CurrentQueueView({super.key});

  @override
  ConsumerState<CurrentQueueView> createState() => _CurrentQueueViewState();
}

class _CurrentQueueViewState extends ConsumerState<CurrentQueueView> {
  bool isInQueue = false;
  bool isCalled = false;

  @override
  Widget build(BuildContext context) {
    ref.read(currentQueueProvider.notifier).refresh();
    final futureQueue = ref.watch(currentQueueProvider);

    if (futureQueue != null) {
      isInQueue = true;
      isCalled = futureQueue.isCalled;
    } else {
      isInQueue = false;
      isCalled = false;
    }
    if (isInQueue) {
      if (isCalled) {
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
                const SizedBox(height: 10),
                SizedBox(
                  height: 200, // Adjust this height as needed
                  child: Center(
                    // Wrap the Image.asset with Center widget
                    child: futureQueue.restaurant.picture != 'no_picture'
                        ? Image.network(
                            futureQueue.restaurant
                                .picture, // Path to your restaurant image asset
                            width: 200, // Adjust size as needed
                            height: 200,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            'assets/images/black_logo.png', // Path to your restaurant image asset
                            width: 200, // Adjust size as needed
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                const SizedBox(height: 15),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Center(
                      child: Container(
                        // padding: const EdgeInsets.all(16),
                        // margin: const EdgeInsets.symmetric(vertical: 16),
                        // width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          color: SPColors.primary.withOpacity(0.1),
                          border: Border.all(color: SPColors.primary),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              text: '¡Es tu turno!',
                              fontSize: 24,
                              color: SPColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const Flexible(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: CustomText(
                      text:
                          '¡Hora de comer una rica comida, acercate al mostrador!',
                      color: SPColors.darkGray,
                      fontSize: 20,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                futureQueue.restaurant.menu != 'no_menu'
                    ? Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20), // Add left and right margin here
                        child: GradientButton(
                          icon: Icons.restaurant_menu,
                          text: 'Ver menú',
                          gradientColors: const [
                            SPColors.primary,
                            SPColors.primary
                          ],
                          onPressed: () {
                            GoRouter.of(context).pushNamed(
                              'menu',
                              pathParameters: {
                                'menu': futureQueue.restaurant.menu
                              },
                            );
                          },
                        ),
                      )
                    : const SizedBox.shrink(),
                const SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 20), // Add left and right margin here
                  child: GradientButton(
                    icon: Icons.cancel,
                    text: "Cancelar turno",
                    gradientColors: const [SPColors.red, SPColors.red],
                    onPressed: () async {
                      final confirm = await showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Confirmar cancelación'),
                            content: const Text(
                                '¿Estás seguro de que querés cancelar tu turno?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(false);
                                },
                                child: const Text('No'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  await ref
                                      .read(apiServiceProvider)
                                      .cancelQueue(futureQueue.email)
                                      .then((value) => {
                                            Navigator.of(context).pop(false),
                                            ref
                                                .read(currentQueueProvider
                                                    .notifier)
                                                .clear(),
                                            ref
                                                .read(currentQueueProvider
                                                    .notifier)
                                                .fetchQueue(),
                                          });
                                },
                                child: const Text('Sí'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      } else {
        return SingleChildScrollView(
          child: Container(
            height: 600,
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
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 200, // Adjust this height as needed
                    child: Center(
                      // Wrap the Image.asset with Center widget
                      child: futureQueue.restaurant.picture != 'no_picture'
                          ? Image.network(
                              futureQueue.restaurant
                                  .picture, // Path to your restaurant image asset
                              width: 200, // Adjust size as needed
                              height: 200,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              'assets/images/black_logo.png', // Path to your restaurant image asset
                              width: 200, // Adjust size as needed
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  const SizedBox(height: 15),
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
                          text: futureQueue.waitingTime <= 1
                              ? ' ¡Ya casi es tu turno!'
                              : ' ${futureQueue.waitingTime} minutos',
                          color: SPColors.darkGray,
                          fontSize: 20,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Flexible(
                    child: CustomText(
                      text: 'Te avisaremos cuando tu mesa esté lista',
                      color: SPColors.darkGray,
                      fontSize: 18,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                  const SizedBox(height: 20),
                  futureQueue.restaurant.menu != 'no_menu'
                      ? Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20), // Add left and right margin here
                          child: GradientButton(
                            icon: Icons.restaurant_menu,
                            text: 'Ver menú',
                            gradientColors: const [
                              SPColors.primary,
                              SPColors.primary
                            ],
                            onPressed: () {
                              GoRouter.of(context).pushNamed(
                                'menu',
                                pathParameters: {
                                  'menu': futureQueue.restaurant.menu
                                },
                              );
                            },
                          ),
                        )
                      : const SizedBox.shrink(),
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
                      onPressed: () async {
                        final confirm = await showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Confirmar cancelación'),
                              content: const Text(
                                  '¿Estás seguro de que querés cancelar tu turno?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                  child: const Text('No'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    await ref
                                        .read(apiServiceProvider)
                                        .cancelQueue(futureQueue.email)
                                        .then((value) => {
                                              Navigator.of(context).pop(false),
                                              ref
                                                  .read(currentQueueProvider
                                                      .notifier)
                                                  .clear(),
                                              ref
                                                  .read(currentQueueProvider
                                                      .notifier)
                                                  .fetchQueue(),
                                            });
                                  },
                                  child: const Text('Sí'),
                                ),
                              ],
                            );
                          },
                        );

                        if (confirm == true) {
                          ref
                              .read(apiServiceProvider)
                              .cancelQueue(futureQueue.email);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
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
                  text: 'No estás anotado en ninguna cola actualmente.',
                  color: SPColors.darkGray,
                  fontWeight: FontWeight.bold,
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
                  color: SPColors.darkGray,
                  fontSize: 22,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.visible,
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 250, // Make the button as wide as its parent
              height: 50, // Set the desired height
              child: Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: 10), // Add left and right margin here
                child: Center(
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
            ),
          ],
        ),
      );
    }
  }
}

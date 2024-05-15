import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_pager/config/molecules/buttons/gradient_button.dart';
import 'package:smart_pager/config/tokens/sp_colors.dart';
import 'package:smart_pager/config/tokens/sp_custom_text.dart';
import 'package:smart_pager/providers/auth_provider.dart';
import 'package:smart_pager/providers/user_provider.dart';

class ProfileView extends ConsumerWidget {
  

  const ProfileView({super.key});

  String formatPhoneNumber(String phoneNumber) {
    // if (phoneNumber.length < 10) {
    //   return '';
    // }
    // return '${phoneNumber.substring(0, 2)} (${phoneNumber.substring(1, 4)}) ${phoneNumber.substring(4, 12)}'; //TODO: ESTO FORMATEA MAL EL NUMERO DE TELEFONO
    return phoneNumber;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final futureUser = ref.watch(loggedUserProvider);

    return Scaffold(
      body: Center(
        child: Container(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const SizedBox(height: 20),
              const SizedBox(height: 20),
              CustomText(
                text: futureUser?.name,
                color: SPColors.heading,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 10),
              CustomText(
                text: futureUser?.email,
                color: SPColors.darkGray,
                fontSize: 25,
              ),
              const SizedBox(height: 20),
              CustomText(
                text: formatPhoneNumber(futureUser?.phoneNumber ?? ''),
                color: SPColors.darkGray,
                fontSize: 20,
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: 250, // Make the button as wide as its parent
                height: 50, // Set the desired height
                child: Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 10), // Add left and right margin here
                  child: GradientButton(
                    icon: Icons.edit,
                    text: "Editar perfil",
                    gradientColors: const [SPColors.primary, SPColors.primary],
                    onPressed: () {
                      GoRouter.of(context).pushNamed('profile-edit');
                    },
                  ),
                ),
              ),

              const Spacer(), // Pushes the buttons to the bottom
              Column(
                children: [
                  Container(
                    width: 200,
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromARGB(0, 189, 144, 144),
                          Color.fromARGB(0, 255, 255, 255)
                        ],
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextButton(
                      onPressed: () {
                        // Código para cerrar sesión
                        ref.read(firebaseAuthProvider).logout().then((value) => GoRouter.of(context).goNamed('onboarding'));
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons
                                .exit_to_app, // You can change the icon as needed
                            color: Colors.red,
                            size: 20,
                          ),
                          SizedBox(
                              width: 5), // Adjust spacing between icon and text
                          Text(
                            "Cerrar sesión",
                            style: TextStyle(
                                color: Colors.red,
                                decoration: TextDecoration.none,
                                fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 60),
                  Container(
                    width: 200,
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromARGB(0, 255, 255, 255),
                          Color.fromARGB(0, 255, 255, 255)
                        ],
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}

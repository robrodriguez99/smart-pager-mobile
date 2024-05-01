import 'package:flutter/material.dart';
import 'package:smart_pager/config/tokens/sp_colors.dart';
import 'package:smart_pager/config/tokens/sp_custom_text.dart';

class ProfileView extends StatelessWidget {
  final String name = "Federico Rojas";
  final String email = "fidi@gmail.com";
  final String telefono = "541156019614";

  const ProfileView({Key? key}) : super(key: key);

  String formatPhoneNumber(String phoneNumber) {
    return '+${phoneNumber.substring(0, 2)} (${phoneNumber.substring(2, 4)}) ${phoneNumber.substring(4, 12)}';
  }

  @override
  Widget build(BuildContext context) {
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
                text: name,
                color: SPColors.heading,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 10),
              CustomText(
                text: email,
                color: SPColors.darkGray,
                fontSize: 25,
              ),
              const SizedBox(height: 20),
              CustomText(
                text: formatPhoneNumber("541156019614"),
                color: SPColors.darkGray,
                fontSize: 20,
              ),
              const SizedBox(height: 40),
              TextButton.icon(
                onPressed: () {
                  // Add your code to handle "Editar Perfil" button tap
                },
                icon: const Icon(Icons.edit),
                label: const Text(
                  "Editar perfil",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(SPColors.primary),
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
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons
                                .exit_to_app, // You can change the icon as needed
                            color: Colors.black,
                            size: 20,
                          ),
                          SizedBox(
                              width: 5), // Adjust spacing between icon and text
                          Text(
                            "Cerrar sesión",
                            style: TextStyle(
                                color: Colors.black,
                                decoration: TextDecoration.underline,
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
                    child: TextButton(
                      onPressed: () {
                        // Código para cerrar sesión
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              width: 5), // Adjust spacing between icon and text
                          Text(
                            "Eliminar cuenta",
                            style: TextStyle(color: Colors.red, fontSize: 18),
                          ),
                        ],
                      ),
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

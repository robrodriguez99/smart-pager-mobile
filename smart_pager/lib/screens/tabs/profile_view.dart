import 'package:flutter/material.dart';
import 'package:smart_pager/config/molecules/buttons/gradient_button.dart';
import 'package:smart_pager/config/tokens/sp_colors.dart';
import 'package:smart_pager/config/tokens/sp_custom_text.dart';

class ProfileView extends StatelessWidget {
  final String name = "Nombre de Usuario";
  final String email = "example@gmail.com";

  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          
          const SizedBox(height: 20),
          CircleAvatar(
            radius: 50,
            child: ClipOval(
              child: Image.asset(
                'assets/images/burger-icon.jpg',
                fit: BoxFit.cover,
                width: 80, // Ajusta el ancho de la imagen
                height: 80, // Ajusta la altura de la imagen
              ),
            ),
          ),
          const SizedBox(height: 20),
          CustomText(
            text: name,
            color: SPColors.heading,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 10),
          CustomText(
            text: email,
            color: SPColors.activeBlack,
            fontSize: 15,
          ),
          
          const SizedBox(height: 20),
          GradientButton(
            text: "Cerrar Sesión",
            width: 150,
            gradientColors: [SPColors.red, SPColors.orange],
            onPressed: () {
              // Código para cerrar sesión
            },
          ),
        ],
      ),
    );
  }
}

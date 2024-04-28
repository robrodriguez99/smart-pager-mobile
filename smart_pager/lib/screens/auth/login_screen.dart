import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_pager/config/molecules/buttons/gradient_button.dart';
import 'package:smart_pager/config/tokens/sp_colors.dart';
import 'package:smart_pager/config/tokens/sp_custom_text.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                const CustomText(
                  text: '(aca va el logo)',
                  color: SPColors.heading,
                  fontSize: 33,
                  fontWeight: FontWeight.bold,
                  
                ),
                const SizedBox(height: 20),
                const Text('TODO: OAUTH GOOGLE', style: TextStyle(fontSize: 30)),
          
                const SizedBox(height: 20),
                GradientButton(
                  text: 'Iniciar sesión',
                  onPressed: () {
                    GoRouter.of(context).go('/home');

                  },
                  gradientColors: [SPColors.primary, SPColors.primary],
                  width: 200,
                  height: 50,
                  borderRadius: BorderRadius.circular(10),
                ),
                const SizedBox(height: 20),
                GradientButton(
                  text: 'Registrarse',
                  onPressed: () {
                    GoRouter.of(context).go('/home');
                  },
                  gradientColors: [SPColors.primary, SPColors.primary],
                  width: 200,
                  height: 50,
                  borderRadius: BorderRadius.circular(10),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

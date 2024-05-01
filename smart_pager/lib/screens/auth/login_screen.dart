import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_pager/config/molecules/buttons/gradient_button.dart';
import 'package:smart_pager/config/tokens/sp_colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                Image.asset(
                  'assets/images/logo.png',
                  width: 100,
                  height: 100,
                ),
                const SizedBox(height: 20),
                const Text('TODO: OAUTH GOOGLE',
                    style: TextStyle(fontSize: 30)),
                const SizedBox(height: 20),
                GradientButton(
                  text: 'Iniciar Sesión',
                  onPressed: () {
                    GoRouter.of(context).go('/home');
                  },
                  gradientColors: const [SPColors.primary, SPColors.primary],
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
                  gradientColors: const [SPColors.primary, SPColors.primary],
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

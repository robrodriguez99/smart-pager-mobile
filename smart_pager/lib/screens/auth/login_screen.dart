import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_pager/config/molecules/buttons/gradient_button.dart';
import 'package:smart_pager/config/tokens/sp_colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SPColors.primary,
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Image.asset(
                  'assets/images/white_logo.png',
                  width: 200,
                  height: 200,
                ),
                const SizedBox(height: 10), // Adjust spacing as needed
                const Text(
                  'Smart Pager',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                      fontFamily: 'Averta'),
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.all(8.0), // Add padding
                  child: GestureDetector(
                    onTap: () {
                      GoRouter.of(context).go('/home');
                    },
                    child: Container(
                      width: 300,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: const LinearGradient(
                          colors: [
                            SPColors.primary,
                            SPColors.primary,
                          ],
                        ),
                        border: Border.all(
                          color: Colors.white,
                          width: 3.0, // Increase border width
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/google.png',
                            width: 30, // Adjust size as needed
                            height: 30, // Adjust size as needed
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            'Continuar con Google',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

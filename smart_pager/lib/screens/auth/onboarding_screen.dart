import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_pager/config/molecules/buttons/gradient_button.dart';
import 'package:smart_pager/config/tokens/sp_colors.dart';
import 'package:smart_pager/screens/auth/onboarding_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

List onBoardingList = [
  {
    'title': "Bienvenido a smart pager",
    'description': "decile adios a las filas eternas",
    'image': 'assets/images/onboarding1.png',
  },
  {
    'title': "Reserva tu lugar en la fila",
    'description': "Reserva tu lugar en la fila y recibe notificaciones en tiempo real",
    'image': 'assets/images/onboarding2.png',
  }
];

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.8,
            child: PageView(
              controller: controller,
              children: List.generate(
                  onBoardingList.length, (index) => OnboardingView(index)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                SmoothPageIndicator(
                    controller: controller, // PageController
                    count: onBoardingList.length,
                    effect: ExpandingDotsEffect(
                      dotHeight: 10,
                      dotWidth: 22,
                      activeDotColor: SPColors.heading,
                      radius: 100,
                      dotColor: SPColors.lightText,
                    ), // your preferred effect
                    onDotClicked: (index) {}),
                const SizedBox(height: 20),
                Row(
                  children: [
                    GradientButton(
                      text: "Siguiente",
                      width: 150,
                      onPressed: () {
                        if (controller.page!.toInt() == onBoardingList.length - 1) {
                          // Redirige a la página de inicio de sesión
                          GoRouter.of(context).go('/login');
                        } else {
                          controller.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        }
                      }
                    ),
                    const Spacer(),
                    GradientButton(
                      text: "Saltar",
                      gradientColors: [SPColors.white, SPColors.white],
                      textColor: SPColors.text,
                      width: 120,
                      onPressed: () {
                        // Redirige a la página de inicio de sesión
                        GoRouter.of(context).go('/login');
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_pager/config/molecules/buttons/gradient_button.dart';
import 'package:smart_pager/config/tokens/sp_colors.dart';
import 'package:smart_pager/providers/auth_provider.dart';
import 'package:smart_pager/providers/user_provider.dart';
import 'package:smart_pager/screens/auth/onboarding_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

List onBoardingList = [
  {
    'title': "¡Bienvenido a Smart Pager!",
    'description': "Decile adiós a las filas eternas.",
    'image': 'assets/images/logo.png',
  },
  {
    'title': "¡Reserva tu lugar en la fila!",
    'description':
        "Elegi donde comer, reserva tu lugar en la fila y obtene un tiempo estimado de espera.\n¡Desde donde te encuentres!",
    'image': 'assets/images/onboarding.png',
  }
];

class OnBoardingScreen extends ConsumerStatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  ConsumerState<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends ConsumerState<OnBoardingScreen> {
  late final PageController controller;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: currentPage);
    controller.addListener(() {
      setState(() {
        currentPage = controller.page!.round();
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    if (ref.read(firebaseAuthProvider).currentUser() != null) {
      ref
          .read(loggedUserProvider.notifier)
          .refresh()
          .then((value) => GoRouter.of(context).pushReplacementNamed('home'));
    }

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: PageView(
              controller: controller,
              children: List.generate(
                onBoardingList.length,
                (index) => OnboardingView(index),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                SmoothPageIndicator(
                  controller: controller,
                  count: onBoardingList.length,
                  effect: ExpandingDotsEffect(
                    dotHeight: 10,
                    dotWidth: 22,
                    activeDotColor: SPColors.heading,
                    radius: 100,
                    dotColor: SPColors.lightText,
                  ),
                  onDotClicked: (index) {},
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    GradientButton(
                      text: currentPage == onBoardingList.length - 1
                          ? "Comenzar"
                          : "Siguiente",
                      width: 150,
                      onPressed: () {
                        if (currentPage == onBoardingList.length - 1) {
                          // Redirect to the login page
                          GoRouter.of(context).go('/login');
                        } else {
                          controller.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                          );
                        }
                      },
                    ),
                    const Spacer(),
                    GradientButton(
                      text: "Saltar",
                      gradientColors: const [
                        SPColors.lightGray,
                        SPColors.lightGray
                      ],
                      textColor: SPColors.text,
                      width: 130,
                      onPressed: () {
                        // Redirect to the login page
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

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

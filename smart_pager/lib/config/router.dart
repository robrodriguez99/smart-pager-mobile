import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_pager/screens/auth/onboarding_screen.dart';

import '../main.dart';


mixin RouterMixin on State<MyApp> {
  final _router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
          path: '/',
          name: 'onboarding',
          builder: (BuildContext context, GoRouterState state) {
            return const OnboardingScreen();
          }),
    
    ],
  );

  GoRouter get router => _router;
}

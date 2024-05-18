import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_pager/screens/current_queue_screen.dart';
import 'package:smart_pager/screens/home_screen.dart';
import 'package:smart_pager/screens/auth/login_screen.dart';
import 'package:smart_pager/screens/auth/onboarding_screen.dart';
import 'package:smart_pager/screens/menu_view.dart';
import 'package:smart_pager/screens/queue_screen.dart';
import 'package:smart_pager/screens/profile_edit_screen.dart';
import 'package:smart_pager/screens/restaurant_screen.dart';
import 'package:smart_pager/screens/search_results_screen.dart';
import 'package:smart_pager/screens/search_screen.dart';

import '../main.dart';

mixin RouterMixin on State<MyApp> {
  final _router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
          path: '/',
          name: 'onboarding',
          builder: (BuildContext context, GoRouterState state) {
            return const OnBoardingScreen();
          }),
      GoRoute(
          path: '/login',
          name: 'login',
          builder: (BuildContext context, GoRouterState state) {
            return const LoginScreen();
          }),
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (BuildContext context, GoRouterState state) {
          return const HomeScreen();
        },
      ),
      GoRoute(
        path: '/restaurant',
        name: 'restaurant',
        builder: (BuildContext context, GoRouterState state) {
          return const RestaurantScreen(closed: false);
        },
      ),
      GoRoute(
        path: '/profile/edit',
        name: 'profile-edit',
        builder: (BuildContext context, GoRouterState state) {
          return const ProfileEditScreen();
        },
      ),
      GoRoute(
        path: '/menu',
        name: 'menu',
        builder: (BuildContext context, GoRouterState state) {
          return const MenuView();
        },
      ),
      GoRoute(
        path: '/queue',
        name: 'queue',
        builder: (BuildContext context, GoRouterState state) {
          return const QueueScreen();
        },
      ),
      GoRoute(
        path: '/search',
        name: 'search',
        builder: (BuildContext context, GoRouterState state) {
          return const SearchScreen();
        },
      ),
      GoRoute(
        path: '/search/results',
        name: 'search-results',
        builder: (BuildContext context, GoRouterState state) {
          return const SearchResultsScreen();
        },
      ),
      GoRoute(
        path: '/queue/current',
        name: 'current-queue',
        builder: (BuildContext context, GoRouterState state) {
          return const CurrentQueueScreen();
        },
      ),
    ],
  );

  GoRouter get router => _router;
}

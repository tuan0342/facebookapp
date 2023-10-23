import 'package:facebook_app/pages/homeScreen/GoHomeScreen.dart';
import 'package:go_router/go_router.dart';

final GoRoute goHomeScreenRoute = GoRoute(
  path: '/homeScreen',
  builder: (context, state) => const GoHomeScreen(),
  routes: [
    GoRoute(
      path: 'homeScreen',
      builder: (context, state) => const GoHomeScreen(),
    ),
  ]
);
import 'package:facebook_app/pages/logIn/LoginPage.dart';
import 'package:go_router/go_router.dart';

final GoRoute logInRoute = GoRoute(
      path: '/logIn',
      builder: (context, state) => const LoginPage(),
);

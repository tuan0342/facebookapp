import 'package:facebook_app/main.dart';
import 'package:facebook_app/navigation/routes/authenticatedRoute.dart';
import 'package:facebook_app/navigation/routes/createAccountRoute.dart';
import 'package:facebook_app/navigation/routes/goHomeScreenRoute.dart';
import 'package:facebook_app/navigation/routes/logInRoute.dart';
import 'package:facebook_app/navigation/rootTabNavigator.dart';
import 'package:facebook_app/pages/ProfileLogin.dart';
import 'package:facebook_app/pages/createAccount/JoinFacebookPage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const ProfileLoginPage(),
      // redirect: (context, state) => "/authenticated"
    ),
    createAccountRoute,
    logInRoute,
    authenticatedRoute,
    goHomeScreenRoute
  ],
);


class AppNavigator extends StatelessWidget {
  const AppNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: _router.routerDelegate,
      routeInformationParser: _router.routeInformationParser,
      routeInformationProvider: _router.routeInformationProvider,
    );
  }
}
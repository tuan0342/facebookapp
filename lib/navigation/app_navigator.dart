import 'package:facebook_app/main.dart';
import 'package:facebook_app/navigation/routes/authenticatedRoute.dart';
import 'package:facebook_app/navigation/routes/createAccountRoute.dart';
import 'package:facebook_app/navigation/routes/logInRoute.dart';
import 'package:facebook_app/navigation/rootTabNavigator.dart';
import 'package:facebook_app/pages/ProfileLogin.dart';
import 'package:facebook_app/pages/createAccount/JoinFacebookPage.dart';
import 'package:facebook_app/pages/db/AddStudent.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const ProfileLoginPage(),
      // redirect: (context, state) => "/authenticated"
    ),
    GoRoute(
      path: '/addStudent',
      builder: (context, state) => const AddStudent(),
      // redirect: (context, state) => "/authenticated"
    ),
    createAccountRoute,
    logInRoute,
    authenticatedRoute,
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
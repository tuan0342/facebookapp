import 'package:facebook_app/main.dart';
import 'package:facebook_app/navigation/rootTabNavigator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRoute authenticatedRoute = GoRoute(
      path: '/authenticated',
      builder: (context, state) => const RootTabNavigator(),
      routes: [
        GoRoute(
          path: 'abc',
          builder: (context, state) => const MyApp(),
        )
      ]
);

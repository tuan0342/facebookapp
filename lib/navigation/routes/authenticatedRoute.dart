import 'package:facebook_app/navigation/rootTabNavigator.dart';
import 'package:facebook_app/pages/homePage.dart';
import 'package:go_router/go_router.dart';

final GoRoute authenticatedRoute = GoRoute(
      path: '/authenticated',
      builder: (context, state) => const RootTabNavigator(),
      // routes: [
      //   GoRoute(
      //     path: 'abc',
      //     builder: (context, state) => const HomePage(),
      //   )
      // ]
);

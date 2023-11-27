import 'package:facebook_app/navigation/authenticated_navigator.dart';
import 'package:facebook_app/navigation/routes/authenticated/submenu_route.dart';
import 'package:facebook_app/pages/authenticated/personal_page.dart';
import 'package:go_router/go_router.dart';

final GoRoute authenticatedRoute = GoRoute(
  path: '/authenticated',
  builder: (context, state) => const AuthenticatedNavigator(),
  routes: [
    menuRoute,
    GoRoute(
      path: 'personalPage',
      builder: (context, state) => const PersonalPage(),
    ),
  ],
  redirect: (context, state) {
    return null;
  },
);

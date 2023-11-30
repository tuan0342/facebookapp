import 'package:facebook_app/navigation/authenticated_navigator.dart';
import 'package:facebook_app/navigation/routes/authenticated/submenu_route.dart';
import 'package:facebook_app/navigation/routes/authenticated/search_routes.dart';
import 'package:facebook_app/pages/authenticated/friend/suggest_friends_page.dart';
import 'package:facebook_app/pages/authenticated/friend/user_friends_page.dart';
import 'package:facebook_app/pages/authenticated/personal_page.dart';
import 'package:go_router/go_router.dart';

final GoRoute authenticatedRoute = GoRoute(
  path: '/authenticated',
  builder: (context, state) => const AuthenticatedNavigator(),
  routes: [
    searchRoutes,
    menuRoute,
    GoRoute(
      path: 'personalPage',
      builder: (context, state) => const PersonalPage(),
    ),
    GoRoute(
          path: "friends/suggests",
          builder: (context, state) => const SuggestFriendsPage()),
      GoRoute(
          path: "friends",
          builder: (context, state) => const UserFriendsPage())
  ],
  redirect: (context, state) {
    return null;
  },
);


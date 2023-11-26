import 'package:facebook_app/navigation/authenticated_navigator.dart';
import 'package:facebook_app/navigation/routes/authenticated/search_routes.dart';
import 'package:go_router/go_router.dart';

final GoRoute authenticatedRoute = GoRoute(
      path: '/authenticated',
      builder: (context, state) => const AuthenticatedNavigator(),
      routes: [
        searchRoutes
      ]
);

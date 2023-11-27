import 'package:facebook_app/pages/auth/login/login_with_known_account.dart';
import 'package:facebook_app/pages/auth/login/login_with_unknown_account.dart';
import 'package:go_router/go_router.dart';

final logInRoute = GoRoute(
  path: "",
  routes: [
    logInKnownRoute,
    logInUnKnownRoute,
  ]
);

final GoRoute logInKnownRoute = GoRoute(
  path: 'logInKnown',
  builder: (context, state) => const LogInKnownPage(),
);

final GoRoute logInUnKnownRoute = GoRoute(
  path: 'logInUnknown',
  builder: (context, state) => const LogInUnknownPage(),
);

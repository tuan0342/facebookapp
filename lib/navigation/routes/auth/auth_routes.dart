import 'package:facebook_app/navigation/routes/auth/register.dart';
import 'package:facebook_app/navigation/routes/auth/login_route.dart';
import 'package:facebook_app/pages/auth/login/profile_login_page.dart';
import 'package:go_router/go_router.dart';

final GoRoute authRoutes = GoRoute(
  path: "/auth",
  builder: (context, state) => const ProfileLoginPage(),
  routes: [
    logInKnownRoute,
    logInUnKnownRoute,
    registerRoute,
  ],
  redirect: (context, state) {
    return null;
  },
);

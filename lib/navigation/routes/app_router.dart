import 'package:facebook_app/navigation/routes/auth/auth_routes.dart';
import 'package:facebook_app/navigation/routes/authenticated/authenticated_route.dart';
import 'package:facebook_app/pages/error_page.dart';
import 'package:facebook_app/pages/splash_screen.dart';
import 'package:facebook_app/services/app_service.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  late final AppService appService;
  GoRouter get router => _goRouter;

  AppRouter(this.appService);

  late final GoRouter _goRouter = GoRouter(
    refreshListenable: appService,
    initialLocation: '/',
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        builder: (context, state) {
          return const SplashScreen();
        },
        redirect: (context, state) {
          final uidLoggedIn = appService.uidLoggedIn;
          final isInitialized = appService.initialized;

          //return "/auth/register/confirmCode/dtrang1570@gmail.com";
          if (!isInitialized) {
            return '/';
          } else if (isInitialized && uidLoggedIn == '') {
            return '/auth';
          } else if (isInitialized && uidLoggedIn != '') {
            return '/authenticated';
          } else {
            return null;
          }
        },
      ),
      authenticatedRoute,
      authRoutes,
    ],
    errorBuilder: (context, state) => const ErrorPage(),
  );
}

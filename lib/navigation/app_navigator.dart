import 'package:facebook_app/navigation/routes/auth/auth_routes.dart';
import 'package:facebook_app/navigation/routes/auth/login_route.dart';
import 'package:facebook_app/navigation/routes/authenticated/authenticated_route.dart';
import 'package:facebook_app/pages/auth/login/profile_login_page.dart';
import 'package:facebook_app/pages/error_page.dart';
import 'package:facebook_app/pages/splash_screen.dart';
import 'package:facebook_app/services/auth_service.dart';
import 'package:facebook_app/util/common.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

final _router = GoRouter(
  routes: [
    GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
        // redirect: (context, state) async {
        //   SharedPreferences sref = await SharedPreferences.getInstance();
        //   var uid = sref.getString('uid');
        //   if (uid != null) {
        //     // ignore: use_build_context_synchronously
        //     Provider.of<AuthService>(context, listen: false).uid = uid;
        //     Provider.of<AuthService>(context, listen: false).deviceId =
        //         await getDeviceId();
        //     return "/authenticated";
        //   }
        //   return "/auth";
        // }
        ),
    authenticatedRoute,
    authRoutes,
  ],
  errorBuilder: (context, state) => const ErrorPage(),
  // redirect: (context, state) {

  // },
);

class AppNavigator extends StatelessWidget {
  const AppNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: _router.routerDelegate,
      routeInformationParser: _router.routeInformationParser,
      routeInformationProvider: _router.routeInformationProvider,
      debugShowCheckedModeBanner: false,
    );
  }
}

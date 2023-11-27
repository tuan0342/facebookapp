import 'package:facebook_app/navigation/routes/authenticatedRoute.dart';
import 'package:facebook_app/navigation/routes/createAccountRoute.dart';
import 'package:facebook_app/navigation/routes/logInRoute.dart';
import 'package:facebook_app/pages/ProfileLogin.dart';
import 'package:facebook_app/pages/logIn/LoginForm.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AppNavigator extends StatefulWidget {
  SharedPreferences sref;
  AppNavigator({super.key, required this.sref});

  @override
  State<AppNavigator> createState() => _AppNavigatorState();
}

class _AppNavigatorState extends State<AppNavigator> {
  late AppService appService;
  late NotificationServices notificationServices;

  @override
  void initState() {
    appService = AppService(widget.sref);
    checkDeviceIdInAppService(appService);

    // set up push noti
    notificationServices = NotificationServices();
    notificationServices.requestNotificationPermission();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    notificationServices.getDeviceToken().then((value) {
      debugPrint("divice token: $value");
    });
    super.initState();
  }

  void checkDeviceIdInAppService(AppService appService) async {
    if (appService.deviceId == '') {
      appService.deviceId = await getDeviceId() ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppService>(create: (context) => appService),
        Provider<AppRouter>(create: (context) => AppRouter(appService)),
        ListenableProvider<AuthService>(create: (context) => AuthService()),
        ListenableProvider<NotificationServices>(create: (context) => notificationServices),
      ],
      child: Builder(
        builder: (context) {
          final GoRouter goRouter =
              Provider.of<AppRouter>(context, listen: false).router;
          return MaterialApp.router(
            title: "Facebook app",
            routerConfig: goRouter,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
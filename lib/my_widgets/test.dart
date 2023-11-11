import 'package:facebook_app/services/notification_services.dart';
import 'package:facebook_app/util/common.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class Application extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Application();
}

class _Application extends State<Application> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NotificationServices notificationServices = NotificationServices();

    notificationServices.requestNotificationPermission();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    // notificationServices.isTokenRefresh();
    notificationServices.getDeviceToken().then((value) {
      print("divice token: $value");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("test noti")),
        body: SafeArea(child: Center(child: Text("..."))));
  }
}

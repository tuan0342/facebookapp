import 'dart:io';
import 'dart:math';
import 'package:facebook_app/pages/splash_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// AAAAk_e3YVk:APA91bHJ_t3VtCVFwsKK5OjnWa_dO9mTBqIfz5p6VEUIheDSTG3XZYo_07mgp7y7HDTkRd_A-0mTV2QfPUqt9gdmKqeLtZqdkuflZm-JHRYvo0VMfMgy8cIau7EIHe3wlVuDvcoFvzi1
class NotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
        sound: true);

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("user granted permistion");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print("user granted provisional permistion");
    } else {
      print("user denied permistion");
    }
  }

  void initLocalNotifications(
      BuildContext context, RemoteMessage message) async {
    var androidInitializationSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    var initializationSetting = InitializationSettings(
      android: androidInitializationSettings,
    );

    await _flutterLocalNotificationsPlugin.initialize(initializationSetting,
        onDidReceiveNotificationResponse: (payload) {
          handleMessage(context, message);
        });
  }

  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((message) {
        print(message.notification!.title.toString());
        print(message.notification!.body.toString());
        print(message.data.toString());
        print(message.data['type']);
        print(message.data['id']);

      if (Platform.isAndroid) {
        print("on listen message");
        initLocalNotifications(context, message);
        showNotification(message);
      }
    });
  }

  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
        Random.secure().nextInt(100000).toString(),
        'High Importance Notifications',
        importance: Importance.max);
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(channel.id.toString(), channel.name,
            channelDescription: 'your channel description',
            importance: Importance.high,
            priority: Priority.high,
            ticker: 'ticker');

    // // for ios
    // DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails(
    //   presentAlert: true,
    //   presentBadge: true,
    //   presentSound: true,
    // );

    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(
        0,
        message.notification!.title.toString(),
        message.notification!.body.toString(),
        notificationDetails,
      );
    });
  }

  Future<String?> getDeviceToken() async {
    return await messaging.getToken();
  }

  void isTokenRefresh() async {
    messaging.onTokenRefresh.listen((event) {
      event.toString();
      print("refresh");
    });
  }

  Future<void> setupInteractMessage(BuildContext context) async {
    // when app is terminated
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      handleMessage(context, initialMessage);
    }

    // when app ins inbackground
    FirebaseMessaging.onMessageOpenedApp.listen((event) { 
      handleMessage(context, event);
    });
  }

  void handleMessage(BuildContext context, RemoteMessage message) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const SplashScreen()));
  }


  // () {
  //         notificationServices.getDeviceToken().then((value) async {
  //           var data = {
  //             'to': value.toString(),
  //             'priority': 'high',
  //             'notification': {
  //               'title': "this is title",
  //               'body': "this is body",
  //             },
  //             'data': {
  //               'type': 'msj',
  //               'id': '123456',
  //             }
  //           };

  //           await http.post(
  //             Uri.parse('https://fcm.googleapis.com/fcm/send'),
  //             body: jsonEncode(data),
  //             headers: {
  //               'Content-Type': 'application/json; charset=UTF-8',
  //               'Authorization':
  //                   'key=AAAAMbDhyqM:APA91bEJjeEu3qseiLN5uOToGGR4t1soTJvy4127KCTQtHpPfwoi7nkd5Hio_oC9S1S8zfWJQ609ZWdXz5rDrAL-e0A2tiD9vtsTetXfkppFA0oevIucKGUsHqKbA5T1w-DWyKvAMDh3',
  //             },
  //           );
}

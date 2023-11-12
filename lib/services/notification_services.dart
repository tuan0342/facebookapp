import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class NotificationServices extends ChangeNotifier {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  // request permission
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
      debugPrint("user granted permistion");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      debugPrint("user granted provisional permistion");
    } else {
      debugPrint("user denied permistion");
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
      debugPrint(message.notification!.title.toString());
      debugPrint(message.notification!.body.toString());
      debugPrint(message.data.toString());

      if (Platform.isAndroid) {
        initLocalNotifications(context, message);
        showNotification(message);
      }
    });
  }

  // show notification when receive
  Future<void> showNotification(RemoteMessage message) async {
    // set up
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
    // end setup

    // show
    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(
        0,
        message.notification!.title.toString(),
        message.notification!.body.toString(),
        notificationDetails,
      );
    });
  }

  // get FCM token
  Future<String?> getDeviceToken() async {
    return await messaging.getToken();
  }

  void isTokenRefresh() async {
    messaging.onTokenRefresh.listen((event) {
      event.toString();
      debugPrint("refresh");
    });
  }

  // when click noti
  Future<void> setupInteractMessage(BuildContext context) async {
    // when app is terminated
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      // ignore: use_build_context_synchronously
      handleMessage(context, initialMessage);
    }

    // when app ins inbackground
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handleMessage(context, event);
    });
  }

  void handleMessage(BuildContext context, RemoteMessage message) {
    print("clicked");
    context.go("/");
  }

  void sendNotificationWithFCMToken({required String token, String? priority,
      required String title,required String message, Map<String, String>? data}) async {
    debugPrint("token : ${token}");
    debugPrint("api: ${dotenv.env['SERVER_API_MESSAGING']}");
    final body = {
      'to': token,
      'priority': priority ?? 'high',
      'notification': {
        'title': title,
        'body': message,
      },
      'data': data ?? {},
    };

    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      body: jsonEncode(body),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'key=${dotenv.env['SERVER_API_MESSAGING']}',
      },
    );
  }

    void sendNotificationToTopic({required String topic, String? priority,
      required String title,required String message, Map<String, String>? data}) async {
    debugPrint("topic : ${topic}");
    debugPrint("api: ${dotenv.env['SERVER_API_MESSAGING']}");
    final body = {
      'to': '/topics/${topic}',
      'priority': priority ?? 'high',
      'notification': {
        'title': title,
        'body': message,
      },
      'data': data ?? {},
    };

    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      body: jsonEncode(body),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'key=${dotenv.env['SERVER_API_MESSAGING']}',
      },
    );
  }

}
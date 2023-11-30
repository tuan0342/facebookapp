import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_app/models/notification_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class NotificationServices extends ChangeNotifier {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

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
    context.go("/");
  }

  void sendNotificationWithFCMToken(
      {required String token,
      String? priority,
      required String title,
      required String message,
      Map<String, String>? data}) async {
    try {
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
    } catch (err) {
      debugPrint("get error when send noti to specific device $err");
    }
  }

  void sendNotificationToTopic(
      {required String topic,
      String? priority,
      required NotificationModel notification}) async {
    try {
      final body = {
        'to': '/topics/${topic}',
        'priority': priority ?? 'high',
        'notification': {
          'title': notification.title,
          'body': notification.message,
        },
        'data': notification.data ?? {},
      };

      // send noti
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        body: jsonEncode(body),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'key=${dotenv.env['SERVER_API_MESSAGING']}',
        },
      );

      // save noti to database
      fireStore
          .collection("topics")
          .doc(topic)
          .collection("notifications")
          .add({...body, "createdAt": DateTime.now().millisecondsSinceEpoch});
    } catch (err) {
      debugPrint("get error when send noti to topic $err");
    }
  }
}

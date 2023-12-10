import 'package:facebook_app/firebase_options.dart';
import 'package:facebook_app/navigation/app_navigator.dart';
import 'package:facebook_app/services/notification_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  await dotenv.load(fileName: 'dev.env');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  SharedPreferences sref = await SharedPreferences.getInstance();

  runApp(AppNavigator(
    sref: sref,
  ));
}

// Lisitnening to the background messages
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  NotificationServices().showNotification(message);
}

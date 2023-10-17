import 'package:facebook_app/navigation/app_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: 'dev.env');
  runApp(const AppNavigator());
}

// ignore: non_constant_identifier_names
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

String LOGIN_KEY = "uid";
String DEVICE_ID = "device_id";

class AppService with ChangeNotifier {
  late final SharedPreferences sharedPreferences;
  final StreamController<bool> _uidLoggedInChange =
      StreamController<bool>.broadcast();
  String _uidLoggedIn = '';
  String _deviceId = '';
  bool _initialized = false;

  AppService(this.sharedPreferences);

  String get uidLoggedIn => _uidLoggedIn;
  String get deviceId => _deviceId;
  bool get initialized => _initialized;
  Stream<bool> get loginStateChange => _uidLoggedInChange.stream;

  set uidLoggedIn(String uid) {
    sharedPreferences.setString(LOGIN_KEY, uid);
    _uidLoggedIn = uid;
    // _uidLoggedInChange.add(state);
    notifyListeners();
  }

  set deviceId(String deviceId) {
    sharedPreferences.setString(DEVICE_ID, deviceId);
    _deviceId = deviceId;
    // notifyListeners();
  }

  set initialized(bool value) {
    _initialized = value;
    notifyListeners();
  }

  Future<void> onAppStart() async {
    _uidLoggedIn = sharedPreferences.getString(LOGIN_KEY) ?? '';
    _deviceId = sharedPreferences.getString(DEVICE_ID) ?? '';
    _initialized = true;
    // solve exception setState or markBuild during build
    Future.delayed(Duration.zero, () {
      notifyListeners();
    });
  }
}

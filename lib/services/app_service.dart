// ignore: non_constant_identifier_names
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

String LOGIN_KEY = "uid";
String DEVICE_ID = "device_id";
String TOKEN_KEY = "token";
String AVATAR_KEY = "avatar";
String USERNAME_KEY = "avatar";
String COINS_KEY = "coins";

class AppService with ChangeNotifier {
  late final SharedPreferences sharedPreferences;
  final StreamController<bool> _uidLoggedInChange =
      StreamController<bool>.broadcast();
  String _uidLoggedIn = '';
  String _deviceId = '';
  String _token = '';
  String _avatar = '';
  String _userName = '';
  int _coins = 0;
  bool _initialized = false;

  AppService(this.sharedPreferences);

  String get uidLoggedIn => _uidLoggedIn;
  String get deviceId => _deviceId;
  String get token => _token;
  String get avatar => _avatar;
  String get userName => _userName;
  int get coins => _coins;
  bool get initialized => _initialized;
  Stream<bool> get loginStateChange => _uidLoggedInChange.stream;

  set uidLoggedIn(String uid) {
    sharedPreferences.setString(LOGIN_KEY, uid);
    _uidLoggedIn = uid;
    notifyListeners();
  }

  set deviceId(String deviceId) {
    sharedPreferences.setString(DEVICE_ID, deviceId);
    _deviceId = deviceId;
  }

  set token(String token) {
    sharedPreferences.setString(TOKEN_KEY, token);
    _token = token;
  }

  set avatar(String avatar) {
    sharedPreferences.setString(AVATAR_KEY, avatar);
    _avatar = avatar;
  }

  set userName(String userName) {
    sharedPreferences.setString(USERNAME_KEY, userName);
    _userName = userName;
  }

  set coins(int coins) {
    sharedPreferences.setInt(COINS_KEY, coins);
    _coins = coins;
  }

  set initialized(bool value) {
    _initialized = value;
    notifyListeners();
  }

  Future<void> onAppStart() async {
    _uidLoggedIn = sharedPreferences.getString(LOGIN_KEY) ?? '';
    _token = sharedPreferences.getString(TOKEN_KEY) ?? '';
    _deviceId = sharedPreferences.getString(DEVICE_ID) ?? '';
    _avatar = sharedPreferences.getString(AVATAR_KEY) ?? '';
    _userName = sharedPreferences.getString(USERNAME_KEY) ?? '';
    _coins = sharedPreferences.getInt(COINS_KEY) ?? 0;
    _initialized = true;
    // solve exception setState or markBuild during build
    Future.delayed(Duration(seconds: 1), () {
      notifyListeners();
    });
  }
}

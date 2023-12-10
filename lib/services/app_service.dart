// ignore: non_constant_identifier_names
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: constant_identifier_names
const String LOGIN_KEY = "uid";
// ignore: constant_identifier_names
const String EMAIL_KEY = "email";
// ignore: constant_identifier_names
const String DEVICE_ID = "device_id";
// ignore: constant_identifier_names
const String TOKEN_KEY = "token";
// ignore: constant_identifier_names
const String AVATAR_KEY = "avatar";
// ignore: constant_identifier_names
const String COVER_IMAGE_KEY = "cover_image";
// ignore: constant_identifier_names
const String USERNAME_KEY = "username";
// ignore: constant_identifier_names
const String COINS_KEY = "coins";
// ignore: constant_identifier_names
const String SUBCRIBE_TOPIC = "subcribe";

class AppService with ChangeNotifier {
  late final SharedPreferences sharedPreferences;
  final StreamController<bool> _uidLoggedInChange =
      StreamController<bool>.broadcast();
  String _uidLoggedIn = '';
  String _email = '';
  String _deviceId = '';
  String _token = '';
  String _avatar = '';
  String _coverImage = '';
  String _username = '';
  String _subcribe = '';
  int _coins = 0;
  bool _initialized = false;

  AppService(this.sharedPreferences);

  String get uidLoggedIn => _uidLoggedIn;
  String get email => _email;
  String get deviceId => _deviceId;
  String get token => _token;
  String get avatar => _avatar;
  String get coverImage => _coverImage;
  String get username => _username;
  int get coins => _coins;
  String get subcribe => _subcribe;
  bool get initialized => _initialized;
  Stream<bool> get loginStateChange => _uidLoggedInChange.stream;

  set uidLoggedIn(String uid) {
    sharedPreferences.setString(LOGIN_KEY, uid);
    _uidLoggedIn = uid;
    notifyListeners();
  }

  set email(String email) {
    sharedPreferences.setString(EMAIL_KEY, email);
    _email = email;
    notifyListeners();
  }

  set deviceId(String deviceId) {
    sharedPreferences.setString(DEVICE_ID, deviceId);
    _deviceId = deviceId;
  }

  set token(String token) {
    sharedPreferences.setString(TOKEN_KEY, token);
    _token = token;
    notifyListeners();
  }

  set avatar(String avatar) {
    sharedPreferences.setString(AVATAR_KEY, avatar);
    _avatar = avatar;
    notifyListeners();
  }

  set coverImage(String coverImage) {
    sharedPreferences.setString(COVER_IMAGE_KEY, coverImage);
    _coverImage = coverImage;
    notifyListeners();
  }

  set username(String username) {
    sharedPreferences.setString(USERNAME_KEY, username);
    _username = username;
    notifyListeners();
  }

  set coins(int coins) {
    sharedPreferences.setInt(COINS_KEY, coins);
    _coins = coins;
    notifyListeners();
  }

    set subcribe(String topic) {
    sharedPreferences.setString(SUBCRIBE_TOPIC, topic);
    _subcribe = topic;
    notifyListeners();
  }

  set initialized(bool value) {
    _initialized = value;
    notifyListeners();
  }

  Future<void> onAppStart() async {
    _uidLoggedIn = sharedPreferences.getString(LOGIN_KEY) ?? '';
    _email = sharedPreferences.getString(EMAIL_KEY) ?? '';
    _token = sharedPreferences.getString(TOKEN_KEY) ?? '';
    _deviceId = sharedPreferences.getString(DEVICE_ID) ?? '';
    _avatar = sharedPreferences.getString(AVATAR_KEY) ?? '';
    _coverImage = sharedPreferences.getString(COVER_IMAGE_KEY) ?? '';
    _username = sharedPreferences.getString(USERNAME_KEY) ?? '';
    _coins = sharedPreferences.getInt(COINS_KEY) ?? 0;
    _initialized = true;
    // solve exception setState or markBuild during build
    Future.delayed(const Duration(seconds: 1), () {
      notifyListeners();
    });
  }
}

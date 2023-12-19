import "dart:convert";

import "package:cloud_firestore/cloud_firestore.dart";
import "package:facebook_app/models/user_model.dart" as models;
import "package:facebook_app/rest_api/rest_api.dart";
import "package:facebook_app/services/app_service.dart";
import "package:facebook_app/util/common.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_messaging/firebase_messaging.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:provider/provider.dart";

// extends ChangeNotifier to become state
class AuthService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ignore: non_constant_identifier_names
  void logInWithFirebase(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      final appService = Provider.of<AppService>(context, listen: false);

      // login to firebase
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      // get device id
      final deviceId = await getDeviceId();
      // insert into firebase database
      _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
        'device_id': deviceId ?? "",
      }, SetOptions(merge: true));

      appService.uidLoggedIn = userCredential.user!.uid;
      // ignore: use_build_context_synchronously
      context.go("/authenticated/0");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        // ignore: use_build_context_synchronously
        showSnackBar(context: context, msg: 'Sai email hoặc mật khẩu');
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(
          context: context, msg: "Có lỗi xảy ra vui lòng thử lại sau $e");
    }
  }

  Future<void> register({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      // ignore: no_leading_underscores_for_local_identifiers
      // final _appService = Provider.of<AppService>(context, listen: false);
      final deviceId = await getDeviceId();

      final user = models.UserLogIn(
          userEmail: email, password: password, uuid: deviceId ?? "");
      final response = await postMethod(endpoind: 'signup', body: user);
      // get device id
      // ignore: use_build_context_synchronously
      final body = jsonDecode(response.body);
      if (response.statusCode == 201) {
        // ignore: use_build_context_synchronously
        // showSnackBar(context: context, msg: 'Đăng ký thành công');
        // ignore: use_build_context_synchronously
        context.go('/auth/register/confirmCode/$email');
      } else {
        // ignore: use_build_context_synchronously
        showSnackBar(context: context, msg: body['message']);
      }
    } catch (e) {
      debugPrint("get err: $e");
      // ignore: use_build_context_synchronously
      showSnackBar(context: context, msg: "Có lỗi xảy ra vui lòng thử lại sau");
    }
  }

  void logInWithApi({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      // ignore: no_leading_underscores_for_local_identifiers
      final _appService = Provider.of<AppService>(context, listen: false);
      final deviceId = await getDeviceId();

      final user = models.UserLogIn(
        userEmail: email,
        password: password,
        uuid: deviceId ?? "",
      );
      final response = await postMethod(endpoind: 'login', body: user);
      // get device id
      // ignore: use_build_context_synchronously
      final body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final uid = body["data"]['id'];
        final token = body["data"]['token'];
        final avatar = body["data"]['avatar'];
        final username = body["data"]['username'];
        final int coins = int.parse(body["data"]["coins"] ?? "0");
        // insert into firebase database
        _firestore.collection('users').doc(uid).set({
          'uid': uid,
          'token': token,
          'email': email,
          'avatar': avatar,
          'username': username,
          'coins': coins,
          'device_id': deviceId ?? "",
        }, SetOptions(merge: true));

        _appService.uidLoggedIn = uid;
        _appService.token = token;
        _appService.avatar = avatar;
        _appService.username = username;
        _appService.coins = coins;
        _appService.email = email;

        debugPrint("uid: $uid");
        debugPrint("uid: ${_appService.uidLoggedIn}");
        debugPrint("active: ${body["data"]['active']}");

        if(body["data"]['active'] == "1") {
          // ignore: use_build_context_synchronously
          context.go("/authenticated/0");
        } else {
          // ignore: use_build_context_synchronously
          context.go("/auth/firstEditName");
        }

        // ignore: use_build_context_synchronously
        showSnackBar(context: context, msg: 'Đăng nhập thành công');
      } else {
        debugPrint("get err: $body");
        // ignore: use_build_context_synchronously
        showSnackBar(context: context, msg: body['message']);
      }
    } catch (e) {
      debugPrint("get err $e");
      // ignore: use_build_context_synchronously
      showSnackBar(
          context: context, msg: "Có lỗi xảy ra, vui lòng thử lại sau");
    }
  }

  Future<void> logOut(
      {required BuildContext context,
      bool isShowSnackbar = false,
      msg = "Tài khoản đang được đăng nhập trên thiết bị khác"}) async {
    final appService = Provider.of<AppService>(context, listen: false);
    try {
      if (isShowSnackbar) {
        // ignore: use_build_context_synchronously
        showSnackBar(context: context, msg: msg);
      }
      await FirebaseMessaging.instance
          .unsubscribeFromTopic(appService.uidLoggedIn)
          .timeout(const Duration(seconds: 3));
      appService.subcribe = '';
    } catch (err) {
      debugPrint("get error $err");
    } finally {
      appService.uidLoggedIn = '';
      appService.token = '';
      // ignore: use_build_context_synchronously
      context.go("/auth");
    }
  }

  Future<void> changePassword(
      {required BuildContext context,
      required String password,
      required String newPassword}) async {
    late AuthService authService =
        Provider.of<AuthService>(context, listen: false);

    try {
      final appService = Provider.of<AppService>(context, listen: false);
      Map<String, dynamic> body = {
        "password": password,
        "new_password": newPassword,
      };
      Map<String, String> headers = {
        "Authorization": "Bearer ${appService.token}",
        'Content-Type': 'application/json; charset=UTF-8'
      };

      final response = await postMethod(
          endpoind: "change_password", body: body, headers: headers);
      final responseBody = jsonDecode(response.body);
      if (int.parse(responseBody["code"]) == 9998) {
        throw UnauthorizationException();
      }
      if (response.statusCode == 200) {
        // ignore: use_build_context_synchronously
        showSnackBar(context: context, msg: "Đổi mật khẩu thành công");
        // ignore: use_build_context_synchronously
        authService.logOut(context: context);
      }
    } on UnauthorizationException {
      // ignore: use_build_context_synchronously
      authService.logOut(
          context: context,
          isShowSnackbar: true,
          msg: "Phiên đăng nhập hết hạn");
    } catch (err) {
      debugPrint("get exception $err");
      // ignore: use_build_context_synchronously
      showSnackBar(
          context: context, msg: "Có lỗi xảy ra vui lòng thử lại sau $err");
    }
  }
}

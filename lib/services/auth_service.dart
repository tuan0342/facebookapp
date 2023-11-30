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
      final _appService = Provider.of<AppService>(context, listen: false);

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

      _appService.uidLoggedIn = userCredential.user!.uid;
      // ignore: use_build_context_synchronously
      context.go("/authenticated");
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
      debugPrint("body: $body");
      if (response.statusCode == 200) {
        final uid = body["data"]['id'];
        final token = body["data"]['token'];
        // insert into firebase database
        _firestore.collection('users').doc(uid).set({
          'uid': uid,
          'token': token,
          'email': email,
          'device_id': deviceId ?? "",
        }, SetOptions(merge: true));

        _appService.uidLoggedIn = uid;
        _appService.token = token;

        // ignore: use_build_context_synchronously
        context.go("/authenticated");
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
    final _appService = Provider.of<AppService>(context, listen: false);

    await FirebaseMessaging.instance
        .unsubscribeFromTopic(_appService.uidLoggedIn);
    _appService.uidLoggedIn = '';
    _appService.token = '';

    if (isShowSnackbar) {
      // ignore: use_build_context_synchronously
      showSnackBar(context: context, msg: msg);
    }
    // ignore: use_build_context_synchronously
    context.go("/auth");
  }
}

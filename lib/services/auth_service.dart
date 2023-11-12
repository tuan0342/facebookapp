import "dart:convert";

import "package:cloud_firestore/cloud_firestore.dart";
import 'package:facebook_app/rest_api/handle_response.dart';
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
        showSnackBar(context: context, msg: 'Wrong email or password');
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(
          context: context, msg: "Have any error, please try again $e");
    }
  }

  void logInWithApi(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      // ignore: no_leading_underscores_for_local_identifiers
      final _appService = Provider.of<AppService>(context, listen: false);

      final user = models.User(
          id: '',
          address: '',
          avatar: '',
          userClass: '',
          gpa: '',
          name: '',
          userEmail: email,
          password: password);
      final response = await postMethod(endpoind: 'auth/login', body: user);
      // get device id
      final deviceId = await getDeviceId();
      final body = jsonDecode(response.body);
      // ignore: use_build_context_synchronously
      handleResponse(
          response: response,
          context: context,
          onSuccess: () {
            // insert into firebase database
            _firestore.collection('users').doc(body['Token']).set({
              'uid': body['Token'],
              'email': email,
              'device_id': deviceId ?? "",
            }, SetOptions(merge: true));
          });

      _appService.uidLoggedIn = body['Token'];
      
      // ignore: use_build_context_synchronously
      context.go("/authenticated");
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(
          context: context, msg: "Have any error, please try again $e");
    }
  }

  Future<void> logOut(
      {required BuildContext context, bool isShowSnackbar = false}) async {
    final _appService = Provider.of<AppService>(context, listen: false);

    await FirebaseAuth.instance.signOut();
    await FirebaseMessaging.instance
        .unsubscribeFromTopic(_appService.uidLoggedIn);
    _appService.uidLoggedIn = '';

    if (isShowSnackbar) {
      // ignore: use_build_context_synchronously
      showSnackBar(
          context: context, msg: 'Your account logged in another device');
    }
    // ignore: use_build_context_synchronously
    context.go("/auth");
  }
}
import "package:cloud_firestore/cloud_firestore.dart";
import "package:facebook_app/util/common.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:shared_preferences/shared_preferences.dart";

// extends ChangeNotifier to become state
class AuthService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  SharedPreferences shared;
  String? deviceId;
  String? uid;

  AuthService({required this.shared});
  // ignore: non_constant_identifier_names
  void LogIn(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      debugPrint("info: $email $password");
      // login to firebase
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      // get device id
      deviceId = await getDeviceId();
      // insert into firebase database
      _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
        'device_id': deviceId ?? "",
      }, SetOptions(merge: true));
      // update state for auth service
      uid = userCredential.user!.uid;
      // save ref data
      shared.setString('uid', uid!);
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

  Future<void> logout(
      {required BuildContext context, bool isShowSnackbar = false}) async {
    await FirebaseAuth.instance.signOut();

    if (isShowSnackbar) {
      // ignore: use_build_context_synchronously
      showSnackBar(
          context: context, msg: 'Your account logged in another device');
    }
    SharedPreferences sref = await SharedPreferences.getInstance();
    await sref.remove('uid');

    // ignore: use_build_context_synchronously
    context.go("/loginForm");
  }
}

import "package:facebook_app/constant/HandleResponse.dart";
import "package:facebook_app/models/user_model.dart";
import "package:facebook_app/restApi/restApi.dart";
import "package:facebook_app/util/common.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

class AuthService {
  // ignore: non_constant_identifier_names
  void LogIn({
    required BuildContext context,
    required String email,
    required String password
    }) async {
      try {
      final user = User(name: "",userEmail: email, password: password, id: '', address: '', userClass: '', gpa: '', avatar: '');
      final response = await postMethod(endpoind: "auth/login", body: user);

      // ignore: use_build_context_synchronously
      HandleResponse(response: response, context: context, onSuccess: () {
        showSnackBar(context: context,msg: 'login successfully!');
        context.go("/authenticated");
      });
      }catch (e) {
        // ignore: use_build_context_synchronously
        showSnackBar(context: context, msg: "invalid error");
      }

  }

}
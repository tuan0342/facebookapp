import 'dart:convert';

import 'package:facebook_app/models/profile_model.dart';
import 'package:facebook_app/rest_api/rest_api.dart';
import 'package:facebook_app/services/app_service.dart';
import 'package:facebook_app/services/auth_service.dart';
import 'package:facebook_app/util/common.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserService {

  Future<Profile> getProfile({
    required BuildContext context
  }) async {
    Profile profile = const Profile(id: "", username: "", created: "", description: "", 
              avatar: "", imageCover: "", link: "", address: "", city: "", country: "", listing: "", 
              isFriend: "", online: "", coins: "");
    late AuthService _authService = Provider.of<AuthService>(context, listen: false);
    try {
      final _appService = Provider.of<AppService>(context, listen: false);

      Map<String, dynamic> body = {
        "user_id": _appService.uidLoggedIn,
      };
      Map<String, String> headers = {
        "Authorization": "Bearer ${_appService.token}",
        'Content-Type': 'application/json; charset=UTF-8'
      };

      final response =
          await postMethod(endpoind: "get_user_info", body: body, headers: headers);
      final responseBody = jsonDecode(response.body);
      
      debugPrint('>>check haha ${responseBody}');
      debugPrint('>>check res : ${response.statusCode}');

      if (int.parse(responseBody["code"]) == 9998) {
        throw UnauthorizationException();
      }
      if (int.parse(responseBody["code"]) == 1000) {
        // ignore: use_build_context_synchronously
        showSnackBar(context: context, msg: "Lấy thông tin thành công");
        
        final result = responseBody["data"];
        profile = Profile.fromJson(result);
        debugPrint('>>check respon: ${responseBody}');
      }
    }on UnauthorizationException {
      // ignore: use_build_context_synchronously
      _authService.logOut(
          context: context,
          isShowSnackbar: true,
          msg: "Phiên đăng nhập hết hạn");
    }  catch (err) {
      debugPrint("get exception $err");
      // ignore: use_build_context_synchronously
      showSnackBar(context: context, msg: "Có lỗi xảy ra vui lòng thử lại sau $err");
    }

    return profile;
  }
}
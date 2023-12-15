import 'dart:convert';

import 'package:facebook_app/rest_api/rest_api.dart';
import 'package:facebook_app/services/app_service.dart';
import 'package:facebook_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/video_post_model.dart';

class VideoService {
  final BuildContext context;
  late final AppService _appService = Provider.of<AppService>(context, listen: false);
  late final AuthService _authService =
    Provider.of<AuthService>(context, listen: false);
    VideoService({required this.context});

  Future<Map<String, dynamic>> getVideoPost() async {
    Map<String, dynamic> result = {"posts": <VideoPost>[], "total": 0};
    try {
      Map<String, dynamic> body = {
        "user_id": 1,
        "in_campaign": 1,
        "campaign_id": 1,
        "latitude": 1.0,
        "longitude": 1.0,
        "last_id": 0,
        "index": 0,
        "count": 10,
      };

      Map<String, String> headers = {
        "Authorization": "Bearer ${_appService.token}",
        'Content-Type': 'application/json; charset=UTF-8',
      };

      final response = await postMethod(
          endpoind: "get_list_videos", body: body, headers: headers);
      final responseBody = jsonDecode(response.body);
      if (int.parse(responseBody["code"]) == 9998) {
        throw UnauthorizationException();
      }
      if (response.statusCode == 200) {
        result["posts"] = (responseBody["data"]["post"] as List)
            .map((e) => VideoPost.fromJson(e))
            .toList();
      } else {
        throw ApiFailException();
      }
    } on UnauthorizationException {
      _authService.logOut(
          context: context,
          isShowSnackbar: true,
          msg: "Phiên đăng nhập hết hạn");
    } catch (err) {
      debugPrint("get err $err");
    }

    return result;
  }
}
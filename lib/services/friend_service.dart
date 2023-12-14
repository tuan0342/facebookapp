import 'dart:convert';

import 'package:facebook_app/models/friend_model.dart';
import 'package:facebook_app/models/notification_model.dart';
import 'package:facebook_app/rest_api/rest_api.dart';
import 'package:facebook_app/services/app_service.dart';
import 'package:facebook_app/services/auth_service.dart';
import 'package:facebook_app/services/notification_services.dart';
import 'package:facebook_app/util/common.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FriendService {
  final BuildContext context;
  late final AppService _appService =
      Provider.of<AppService>(context, listen: false);
  late final AuthService _authService =
      Provider.of<AuthService>(context, listen: false);
  late final NotificationServices _notificationServices =
      Provider.of<NotificationServices>(context, listen: false);
  FriendService({required this.context});

  Future<Map<String, dynamic>> getRequests(int index, int count) async {
    Map<String, dynamic> result = {
      "requests": <RequestFriendModel>[],
      "total": 0
    };
    try {
      Map<String, dynamic> body = {
        "index": index,
        "count": count,
      };

      Map<String, String> headers = {
        "Authorization": "Bearer ${_appService.token}",
        'Content-Type': 'application/json; charset=UTF-8',
      };

      final response = await postMethod(
          endpoind: "get_requested_friends", body: body, headers: headers);
      final responseBody = jsonDecode(response.body);

      if (int.parse(responseBody["code"]) == 9998) {
        throw UnauthorizationException();
      }
      if (response.statusCode == 200) {
        result["requests"] = (responseBody["data"]["requests"] as List)
            .map((e) => RequestFriendModel.fromJson(e))
            .toList();
        result["total"] = int.parse(responseBody["data"]["total"]);
      } else {
        throw ApiFailException();
      }
    } on UnauthorizationException {
      // ignore: use_build_context_synchronously
      _authService.logOut(
          context: context,
          isShowSnackbar: true,
          msg: "Phiên đăng nhập hết hạn");
    } catch (err) {
      debugPrint("get err $err");
    }

    return result;
  }

  Future<Map<String, dynamic>> getFriends(
      int index, int count, String uid) async {
    Map<String, dynamic> result = {"friends": <FriendModel>[], "total": 0};
    try {
      Map<String, dynamic> body = {
        "index": index,
        "count": count,
        "user_id": uid,
      };

      Map<String, String> headers = {
        "Authorization": "Bearer ${_appService.token}",
        'Content-Type': 'application/json; charset=UTF-8',
      };

      final response = await postMethod(
          endpoind: "get_user_friends", body: body, headers: headers);
      final responseBody = jsonDecode(response.body);

      if (int.parse(responseBody["code"]) == 9998) {
        throw UnauthorizationException();
      }
      if (response.statusCode == 200) {
        result["friends"] = (responseBody["data"]["friends"] as List)
            .map((e) => FriendModel.fromJson(e))
            .toList();
        result["total"] = int.parse(responseBody["data"]["total"]);
      }
    } on UnauthorizationException {
      // ignore: use_build_context_synchronously
      _authService.logOut(
          context: context,
          isShowSnackbar: true,
          msg: "Phiên đăng nhập hết hạn");
    } catch (err) {
      debugPrint("get err $err");
    }

    return result;
  }

  Future<List<SuggestFriendModel>> getSuggestFriends(
      int index, int count) async {
    List<SuggestFriendModel> result = [];
    try {
      Map<String, dynamic> body = {
        "index": index,
        "count": count,
      };

      Map<String, String> headers = {
        "Authorization": "Bearer ${_appService.token}",
        'Content-Type': 'application/json; charset=UTF-8',
      };

      final response = await postMethod(
          endpoind: "get_suggested_friends", body: body, headers: headers);
      final responseBody = jsonDecode(response.body);
      if (int.parse(responseBody["code"]) == 9998) {
        throw UnauthorizationException();
      }
      if (response.statusCode == 200) {
        result = (responseBody["data"] as List)
            .map((e) => SuggestFriendModel.fromJson(e))
            .toList();
      }
    } on UnauthorizationException {
      // ignore: use_build_context_synchronously
      _authService.logOut(
          context: context,
          isShowSnackbar: true,
          msg: "Phiên đăng nhập hết hạn");
    } catch (err) {
      debugPrint("get err $err");
    }

    return result;
  }

  Future<bool> setAcceptFriend(int userRequestId, int isAccept) async {
    try {
      Map<String, dynamic> body = {
        "is_accept": isAccept.toString(),
        "user_id": userRequestId,
      };

      Map<String, String> headers = {
        "Authorization": "Bearer ${_appService.token}",
        'Content-Type': 'application/json; charset=UTF-8',
      };

      final response = await postMethod(
          endpoind: "set_accept_friend", body: body, headers: headers);
      final responseBody = jsonDecode(response.body);
      if (int.parse(responseBody["code"]) == 9998) {
        throw UnauthorizationException();
      }

      if (response.statusCode == 200) {
        return true;
      }
    } on UnauthorizationException {
      // ignore: use_build_context_synchronously
      _authService.logOut(
          context: context,
          isShowSnackbar: true,
          msg: "Phiên đăng nhập hết hạn");
    } catch (err) {
      debugPrint("get err $err");
      // ignore: use_build_context_synchronously
      showSnackBar(
          context: context, msg: "có lỗi xảy ra, vui lòng thử lại sau");
    }
    return false;
  }

  Future<bool> unFriend(int userRequestId) async {
    try {
      Map<String, dynamic> body = {
        "user_id": userRequestId,
      };

      Map<String, String> headers = {
        "Authorization": "Bearer ${_appService.token}",
        'Content-Type': 'application/json; charset=UTF-8',
      };

      final response =
          await postMethod(endpoind: "unfriend", body: body, headers: headers);
      final responseBody = jsonDecode(response.body);

      if (int.parse(responseBody["code"]) == 9998) {
        throw UnauthorizationException();
      }
      if (response.statusCode == 200) {
        return true;
      }
    } on UnauthorizationException {
      // ignore: use_build_context_synchronously
      _authService.logOut(
          context: context,
          isShowSnackbar: true,
          msg: "Phiên đăng nhập hết hạn");
    } catch (err) {
      debugPrint("get err $err");
      // ignore: use_build_context_synchronously
      showSnackBar(
          context: context, msg: "có lỗi xảy ra, vui lòng thử lại sau");
    }
    return false;
  }

  Future<bool> setRequestFriend(int userRequestId) async {
    try {
      Map<String, dynamic> body = {
        "user_id": userRequestId,
      };

      Map<String, String> headers = {
        "Authorization": "Bearer ${_appService.token}",
        'Content-Type': 'application/json; charset=UTF-8',
      };

      final response = await postMethod(
          endpoind: "set_request_friend", body: body, headers: headers);
      final responseBody = jsonDecode(response.body);

      if (int.parse(responseBody["code"]) == 9998) {
        throw UnauthorizationException();
      }
      if (int.parse(responseBody["code"]) == 1000) {
        _notificationServices.sendNotificationToTopic(
            topic: "$userRequestId",
            notification: NotificationModel(
                title: "Anti facebook",
                message:
                    "${_appService.username} đã gửi lời mời kết bạn tới bạn",
                data: RequestFriendNotiModel().toMap()));
        return true;
      }
    } on UnauthorizationException {
      // ignore: use_build_context_synchronously
      _authService.logOut(
          context: context,
          isShowSnackbar: true,
          msg: "Phiên đăng nhập hết hạn");
    } catch (err) {
      debugPrint("get err $err");
      // ignore: use_build_context_synchronously
      showSnackBar(
          context: context, msg: "có lỗi xảy ra, vui lòng thử lại sau");
    }
    return false;
  }

  Future<bool> delRequestFriend(int userRequestId) async {
    try {
      Map<String, dynamic> body = {
        "user_id": userRequestId,
      };

      Map<String, String> headers = {
        "Authorization": "Bearer ${_appService.token}",
        'Content-Type': 'application/json; charset=UTF-8',
      };

      final response = await postMethod(
          endpoind: "del_request_friend", body: body, headers: headers);
      final responseBody = jsonDecode(response.body);

      if (int.parse(responseBody["code"]) == 9998) {
        throw UnauthorizationException();
      }
      if (response.statusCode == 200) {
        return true;
      }
    } on UnauthorizationException {
      // ignore: use_build_context_synchronously
      _authService.logOut(
          context: context,
          isShowSnackbar: true,
          msg: "Phiên đăng nhập hết hạn");
    } catch (err) {
      debugPrint("get err $err");
      // ignore: use_build_context_synchronously
      showSnackBar(
          context: context, msg: "có lỗi xảy ra, vui lòng thử lại sau");
    }
    return false;
  }

  Future<List<FriendBlock>> getBlocksList(
      int index, int count, String uid) async {
    List<FriendBlock> blocksList = [];
    try {
      Map<String, dynamic> body = {
        "index": index,
        "count": count,
      };

      Map<String, String> headers = {
        "Authorization": "Bearer ${_appService.token}",
        'Content-Type': 'application/json',
      };

      final response = await postMethod(
          endpoind: "get_list_blocks", body: body, headers: headers);
      final responseBody = jsonDecode(response.body);
      if (int.parse(responseBody["code"]) == 9998) {
        throw UnauthorizationException();
      }
      if (int.parse(responseBody["code"]) == 1000) {
        blocksList = (responseBody["data"] as List)
            .map((e) => FriendBlock.fromJson(e))
            .toList();
      }
    } on UnauthorizationException {
      // ignore: use_build_context_synchronously
      _authService.logOut(
          context: context,
          isShowSnackbar: true,
          msg: "Phiên đăng nhập hết hạn");
    } catch (err) {
      debugPrint("get err $err");
    }

    return blocksList;
  }

  Future<bool> setBlocksFriend(String uid) async {
    try {
      Map<String, dynamic> body = {
        "user_id": uid,
      };

      Map<String, String> headers = {
        "Authorization": "Bearer ${_appService.token}",
        'Content-Type': 'application/json',
      };

      final response =
          await postMethod(endpoind: "set_block", body: body, headers: headers);
      final responseBody = jsonDecode(response.body);
      if (int.parse(responseBody["code"]) == 9998) {
        throw UnauthorizationException();
      }
      if (int.parse(responseBody["code"]) == 1000) {
        return true;
      }
    } on UnauthorizationException {
      // ignore: use_build_context_synchronously
      _authService.logOut(
          context: context,
          isShowSnackbar: true,
          msg: "Phiên đăng nhập hết hạn");
    } catch (err) {
      debugPrint("get err $err");
    }

    return false;
  }
}

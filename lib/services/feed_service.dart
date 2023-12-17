import 'dart:convert';

import 'package:facebook_app/models/image_model.dart';
import 'package:facebook_app/models/notification_model.dart';
import 'package:facebook_app/models/post_model.dart';
import 'package:facebook_app/rest_api/rest_api.dart';
import 'package:facebook_app/services/app_service.dart';
import 'package:facebook_app/services/auth_service.dart';
import 'package:facebook_app/services/notification_services.dart';
import 'package:facebook_app/util/common.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeedService {
  final BuildContext context;
  late final AppService _appService =
      Provider.of<AppService>(context, listen: false);
  late final AuthService _authService =
      Provider.of<AuthService>(context, listen: false);

  List<Post> fakePosts = [
    Post(
      id: 1,
      name: "",
      image: [const ImageModel(id: 1, url: "assets/images/img")], //
      described: "",
      created: "2023-11-16T07:37:51.804Z",
      feel: 0,
      markComment: 0,
      isFelt: -1,
      state: "Not Hyped",
      author: const Author(
          id: 1,
          name: "Nguyễn Khánh Duy",
          avatar:
              "https://it4788.catan.io.vn/files/avatar-1700472905228-894880239.jpg",
          coins: 0,
          listing: []),
      canEdit: 1,
      banned: 0,
      isBlocked: 0,
    ),
  ];

  FeedService({required this.context});
  Future<List<Post>> getFeeds(
      {int? uid,
      inCampain = 0,
      campaignId = 0,
      latitude = 0,
      longitude = 0,
      int? lastId,
      int index = 0,
      int count = 20}) async {
    // return fakePosts;

    List<Post> posts = [];
    try {
      Map<String, dynamic> body = {
        "user_id": uid,
        "in_campaign": inCampain,
        "campaign_id": campaignId,
        "latitude": latitude,
        "longitude": longitude,
        "last_id": lastId,
        "index": index,
        "count": count
      };

      Map<String, String> headers = {
        "Authorization": "Bearer ${_appService.token}",
        'Content-Type': 'application/json; charset=UTF-8',
      };

      final response = await postMethod(
          endpoind: "get_list_posts", body: body, headers: headers);

      final responseBody = jsonDecode(response.body);

      if (int.parse(responseBody["code"]) == 9998) {
        throw UnauthorizationException();
      }
      if (response.statusCode == 200) {
        posts = (responseBody["data"]["post"] as List)
            .map((e) => Post.fromJson(e))
            .toList();
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

    return posts;
  }

  bool updateFeed(int index) {
    // posts[index].disappointedNumber +=1;
    // posts[index].kudosNumber += 1;
    return true;
  }

  Future<Map<String, dynamic>> getPersonalFeeds({
    required BuildContext context,
    required String in_campaign,
    required String campaign_id,
    required String latitude,
    required String longitude,
    required String last_id,
    required String index,
    required String count,
    required String uid,
  }) async {
    Map<String, dynamic> result = {"posts": <Post>[], "lastId": 0};
    // List<Post> myPosts = [];
    late AuthService _authService =
        Provider.of<AuthService>(context, listen: false);
    try {
      final _appService = Provider.of<AppService>(context, listen: false);

      Map<String, dynamic> body = {
        "user_id": uid,
        "in_campaign": in_campaign,
        "campaign_id": campaign_id,
        "latitude": latitude,
        "longitude": longitude,
        "last_id": last_id,
        "index": index,
        "count": count
      };
      Map<String, String> headers = {
        "Authorization": "Bearer ${_appService.token}",
        'Content-Type': 'application/json'
      };

      final response = await postMethod(
          endpoind: "get_list_posts", body: body, headers: headers);
      final responseBody = jsonDecode(response.body);

      if (int.parse(responseBody["code"]) == 9998) {
        throw UnauthorizationException();
      }
      if (int.parse(responseBody["code"]) == 1000) {
        // myPosts = (responseBody["data"]["post"] as List)
        //     .map((e) => Post.fromJson(e))
        //     .toList();
        result["posts"] = (responseBody["data"]["post"] as List)
            .map((e) => Post.fromJson(e))
            .toList();
        result["lastId"] = (responseBody["data"]["last_id"]);
      }
    } on UnauthorizationException {
      // ignore: use_build_context_synchronously
      _authService.logOut(
          context: context,
          isShowSnackbar: true,
          msg: "Phiên đăng nhập hết hạn");
    } catch (err) {
      debugPrint("get exception $err");
      // ignore: use_build_context_synchronously
      showSnackBar(
          context: context, msg: "Có lỗi xảy ra vui lòng thử lại sau $err");
    }

    return result;
  }

  Future<bool> feelPost(
      {required BuildContext context,
      required int postId,
      required int postOwnerId,
      required int feelType}) async {
    final appService = Provider.of<AppService>(context, listen: false);
    final authService = Provider.of<AuthService>(context, listen: false);
    final notificationService =
        Provider.of<NotificationServices>(context, listen: false);
    try {
      Map<String, dynamic> body = {
        "id": postId,
        "type": feelType,
      };

      Map<String, String> headers = {
        "Authorization": "Bearer ${appService.token}",
        'Content-Type': 'application/json'
      };

      final response =
          await postMethod(endpoind: "feel", body: body, headers: headers);
      final responseBody = jsonDecode(response.body);

      if (int.parse(responseBody["code"]) == 9998) {
        throw UnauthorizationException();
      }
      if (int.parse(responseBody["code"]) == 1000) {
        // send noti
        if (postOwnerId != int.parse(_appService.uidLoggedIn)) {
          if (feelType == 1) {
            notificationService.sendNotificationToTopic(
              // topic: postOwnerId.toString(),
              topic: postOwnerId.toString(),
              notification: NotificationModel(
                  title: "Anti Facebook",
                  message:
                      "${appService.username} đã bày tỏ cảm xúc kudos vào bài viết của bạn",
                  data: InteractPostNotiModel(postId: postId).toMap()),
            );
          } else {
            notificationService.sendNotificationToTopic(
                // topic: postOwnerId.toString(),
                topic: postOwnerId.toString(),
                notification: NotificationModel(
                    title: "Anti Facebook",
                    message:
                        "${appService.username} đã bày tỏ cảm xúc disapointed vào bài viết của bạn",
                    data: InteractPostNotiModel(postId: postId).toMap()));
          }
        }
        return true;
      }
    } on UnauthorizationException {
      // ignore: use_build_context_synchronously
      authService.logOut(
          context: context,
          isShowSnackbar: true,
          msg: "Phiên đăng nhập hết hạn");
    } catch (e) {
      debugPrint("get error $e");
      // ignore: use_build_context_synchronously
      showSnackBar(
          context: context, msg: "Có lỗi xảy ra vui lòng thử lại sau $e");
    }

    return false;
  }

  Future<bool> deleteFeelPost(
      {required BuildContext context, required int postId}) async {
    final appService = Provider.of<AppService>(context, listen: false);
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      Map<String, dynamic> body = {
        "id": postId,
      };

      Map<String, String> headers = {
        "Authorization": "Bearer ${appService.token}",
        'Content-Type': 'application/json'
      };

      final response = await postMethod(
          endpoind: "delete_feel", body: body, headers: headers);
      final responseBody = jsonDecode(response.body);
      if (int.parse(responseBody["code"]) == 9998) {
        throw UnauthorizationException();
      }
      if (int.parse(responseBody["code"]) == 1000) {
        return true;
      }
    } on UnauthorizationException {
      // ignore: use_build_context_synchronously
      authService.logOut(
          context: context,
          isShowSnackbar: true,
          msg: "Phiên đăng nhập hết hạn");
    } catch (e) {
      debugPrint("get error $e");
      // ignore: use_build_context_synchronously
      showSnackBar(
          context: context, msg: "Có lỗi xảy ra vui lòng thử lại sau $e");
    }

    return false;
  }

  Future<bool> getListFeel(
      {required BuildContext context, required int postId}) async {
    final appService = Provider.of<AppService>(context, listen: false);
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      Map<String, dynamic> body = {
        "id": postId,
      };

      Map<String, String> headers = {
        "Authorization": "Bearer ${appService.token}",
        'Content-Type': 'application/json'
      };

      final response = await postMethod(
          endpoind: "delete_feel", body: body, headers: headers);
      final responseBody = jsonDecode(response.body);
      if (int.parse(responseBody["code"]) == 9998) {
        throw UnauthorizationException();
      }
      if (int.parse(responseBody["code"]) == 1000) {
        return true;
      }
    } on UnauthorizationException {
      // ignore: use_build_context_synchronously
      authService.logOut(
          context: context,
          isShowSnackbar: true,
          msg: "Phiên đăng nhập hết hạn");
    } catch (e) {
      debugPrint("get error $e");
      // ignore: use_build_context_synchronously
      showSnackBar(
          context: context, msg: "Có lỗi xảy ra vui lòng thử lại sau $e");
    }

    return false;
  }

  Future<PostDetailModel?> getPost({required int postId}) async {
    final appService = Provider.of<AppService>(context, listen: false);
    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      Map<String, dynamic> body = {
        "id": postId,
      };

      Map<String, String> headers = {
        "Authorization": "Bearer ${appService.token}",
        'Content-Type': 'application/json'
      };

      final response =
          await postMethod(endpoind: "get_post", body: body, headers: headers);
      final responseBody = jsonDecode(response.body);

      if (int.parse(responseBody["code"]) == 9998) {
        throw UnauthorizationException();
      }
      if (int.parse(responseBody["code"]) == 1000) {
        return PostDetailModel.fromJson(responseBody["data"]);
      }
    } on UnauthorizationException {
      // ignore: use_build_context_synchronously
      authService.logOut(
          context: context,
          isShowSnackbar: true,
          msg: "Phiên đăng nhập hết hạn");
    } catch (e) {
      debugPrint("get error $e");
      // ignore: use_build_context_synchronously
      showSnackBar(
          context: context, msg: "Có lỗi xảy ra vui lòng thử lại sau $e");
    }

    return null;
  }
}

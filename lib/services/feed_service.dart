import 'dart:convert';
import 'dart:io';

import 'package:facebook_app/models/mark_comment_model.dart';
import 'package:facebook_app/models/notification_model.dart';
import 'package:facebook_app/models/post_model.dart';
import 'package:facebook_app/rest_api/rest_api.dart';
import 'package:facebook_app/services/app_service.dart';
import 'package:facebook_app/services/auth_service.dart';
import 'package:facebook_app/services/notification_services.dart';
import 'package:facebook_app/util/common.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class FeedService {
  final BuildContext context;
  late final AppService _appService =
      Provider.of<AppService>(context, listen: false);
  late final AuthService _authService =
      Provider.of<AuthService>(context, listen: false);

  FeedService({required this.context});
  Future<Map<String, dynamic>> getFeeds(
      {int? uid,
      inCampain = 0,
      campaignId = 0,
      latitude = 0,
      longitude = 0,
      int? lastId,
      int index = 0,
      int count = 20}) async {
    List<Post> posts = [];
    int? lastID = lastId;
    bool isSuccess = false;
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
        debugPrint('check 123: ${posts[1].toJson()}');
        lastID = int.parse(responseBody["data"]["last_id"]);
        isSuccess = true;
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

    return {
      "feed": posts,
      "last_id": lastID,
      "isSuccess": false,
    };
  }

  bool updateFeed(int index) {
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
      showSnackBar(context: context, msg: "Có lỗi xảy ra vui lòng thử lại sau");
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
                  data: InteractPostNotiModel(
                          postId: postId, avatar: appService.avatar)
                      .toMap()),
            );
          } else {
            notificationService.sendNotificationToTopic(
                // topic: postOwnerId.toString(),
                topic: postOwnerId.toString(),
                notification: NotificationModel(
                    title: "Anti Facebook",
                    message:
                        "${appService.username} đã bày tỏ cảm xúc disapointed vào bài viết của bạn",
                    data: InteractPostNotiModel(
                            postId: postId, avatar: appService.avatar)
                        .toMap()));
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
      showSnackBar(context: context, msg: "Có lỗi xảy ra vui lòng thử lại sau");
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
      showSnackBar(context: context, msg: "Có lỗi xảy ra vui lòng thử lại sau");
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
      showSnackBar(context: context, msg: "Có lỗi xảy ra vui lòng thử lại sau");
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
    }

    return null;
  }

// markId = 0 => mark
// marId != 0 => comment
// markType (1 is trust, 0 is fake)
  Future<List<MarkModel>> setMarkComment({
    required int postId,
    required int receiverId,
    required String content,
    int index = 0,
    int count = 10,
    required int markId,
    required int markType,
  }) async {
    final appService = Provider.of<AppService>(context, listen: false);
    final authService = Provider.of<AuthService>(context, listen: false);
    final notificationService =
        Provider.of<NotificationServices>(context, listen: false);
    List<MarkModel> marks = [];
    try {
      Map<String, dynamic> body = {
        "id": postId,
        "content": content,
        "index": index,
        "count": count,
        "mark_id": markId,
        "type": markType
      };

      Map<String, String> header = {
        "Authorization": "Bearer ${appService.token}",
        'Content-Type': 'application/json'
      };

      final response = await postMethod(
          endpoind: "set_mark_comment", body: body, headers: header);
      final responseBody = jsonDecode(response.body);
      if (int.parse(responseBody["code"]) == 9998) {
        throw UnauthorizationException();
      }
      if (int.parse(responseBody["code"]) == 1000) {
        marks = (responseBody["data"] as List)
            .map((mark) => MarkModel.fromJson(mark))
            .toList();

        // sendnoti
        notificationService.sendNotificationToTopic(
            topic: receiverId.toString(),
            notification: NotificationModel(
                title: "Anti Facebook",
                message: markId != 0
                    ? "${appService.username} đã phản hồi mark của bạn"
                    : "${appService.username} đã mark vào bài viết của bạn",
                data: InteractPostNotiModel(
                        postId: postId, avatar: appService.avatar)
                    .toMap()));
      }
    } on UnauthorizationException {
      // ignore: use_build_context_synchronously
      authService.logOut(
          context: context,
          isShowSnackbar: true,
          msg: "Phiên đăng nhập hết hạn");
    } catch (err) {
      debugPrint("get error when set mark $err");
      // ignore: use_build_context_synchronously
      showSnackBar(context: context, msg: "get error when set mark");
    } finally {
      // ignore: control_flow_in_finally
      return marks;
    }
  }

  Future<List<MarkModel>> getMarkComment(
      {required int postId, required int index, required int count}) async {
    final appService = Provider.of<AppService>(context, listen: false);
    final authService = Provider.of<AuthService>(context, listen: false);
    List<MarkModel> marks = [];

    try {
      Map<String, dynamic> body = {
        "id": postId,
        "index": index,
        "count": count,
      };

      Map<String, String> header = {
        "Authorization": "Bearer ${appService.token}",
        'Content-Type': 'application/json'
      };

      final response = await postMethod(
          endpoind: "get_mark_comment", body: body, headers: header);
      final responseBody = jsonDecode(response.body);
      if (int.parse(responseBody["code"]) == 9998) {
        throw UnauthorizationException();
      }
      if (int.parse(responseBody["code"]) == 1000) {
        debugPrint('listMarks: $responseBody');
        marks = (responseBody["data"] as List)
            .map((mark) => MarkModel.fromJson(mark))
            .toList();
      }
    } on UnauthorizationException {
      // ignore: use_build_context_synchronously
      authService.logOut(
          context: context,
          isShowSnackbar: true,
          msg: "Phiên đăng nhập hết hạn");
    } catch (err) {
      debugPrint("get error when get mark $err");
      // ignore: use_build_context_synchronously
    } finally {
      // ignore: control_flow_in_finally
      return marks;
    }
  }
  Future<void> addPost({
    required BuildContext context,
    List<File>? imageList,
    File? video,
    String? described,
    String? status,
  })async {
    late AuthService _authService =
    Provider.of<AuthService>(context, listen: false);
    try {
      debugPrint('go feed service');

      final _appService = Provider.of<AppService>(context, listen: false);

      Map<String, String> body = {
        "described": described!.trim(),
        "status": status!.trim()
      };
      List<FileData> files = [];
      if (imageList!.isNotEmpty) {
        for ( var image in imageList) {
          files.add(FileData(fieldName: 'image', file: image, type: "image", subType: "png"),);
        }
      }
      if (video != null) {
        files.add(FileData(fieldName: 'video', file: video, type: "video", subType: "mp4"),);
      }

      debugPrint("$imageList $video $status $described");

      Map<String, String> headers = {
        "Authorization": "Bearer ${_appService.token}",
        'Content-Type': 'application/json; charset=UTF-8'
      };



      final response = await postWithFormDataMethod(
          endpoind: "add_post", body: body, headers: headers, files: files);
      final responseBody = jsonDecode(response.body);
      debugPrint('go res: $responseBody');

      if (int.parse(responseBody["code"]) == 9998) {
        showSnackBar(
            context: context, msg: "Có lỗi xảy ra vui lòng thử lại sau");
      }
      if (int.parse(responseBody["code"]) == 1000) {
        context.go('/authenticated/0');
      }
    } catch (err) {
      debugPrint("get exception $err");
    }
  }

  Future<void> deletePost({
    required BuildContext context,
    required int postId
  }) async {
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
      await postMethod(endpoind: "delete_post", body: body, headers: headers);
      final responseBody = jsonDecode(response.body);

      if (int.parse(responseBody["code"]) == 9998) {
        throw UnauthorizationException();
      }
      if (int.parse(responseBody["code"]) == 1000) {
        debugPrint("sucessfully delete Pos ");
        context.go("/authenticated/personalPage/${appService.uidLoggedIn}");
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
          context: context, msg: "Có lỗi xảy ra vui lòng thử lại sau");
    }

    return null;
  }

  Future<void> editPost({
    required BuildContext context,
    required int id,
    List<File>? image,
    File? video,
    String? described,
    String? status,
    String? image_del,
    String? image_sort
}) async {
    late AuthService _authService =
    Provider.of<AuthService>(context, listen: false);
    try {
      debugPrint('go feed service status: $status');
      final _appService = Provider.of<AppService>(context, listen: false);
      Map<String, String> body = {
        "id": id.toString(),
        "described": described == null ? "" : described.trim(),
        "status": status == null ? "" : status.trim(),
        "image_del": image_del == null ? "" : image_del.trim(),
        "image_sort":  image_sort == null ? "" : image_sort.trim(),
      };
      debugPrint("$image  $described $image_del");
      List<FileData> files = [];
      if (image!.isNotEmpty) {
        for ( var a in image) {
          files.add(FileData(fieldName: 'image', file: a, type: "image", subType: "png"),);
        }
      }
      if (video != null) {
        files.add(FileData(fieldName: 'video', file: video, type: "video", subType: "mp4"),);
      }
      debugPrint("$image $status $described $image_del");
      Map<String, String> headers = {
        "Authorization": "Bearer ${_appService.token}",
        'Content-Type': 'application/json; charset=UTF-8'
      };
      final response = await postWithFormDataMethod(
          endpoind: "edit_post", body: body, headers: headers, files: files);
      final responseBody = jsonDecode(response.body);
      debugPrint('go res: $responseBody');

      if (int.parse(responseBody["code"]) == 9998) {
        showSnackBar(
            context: context, msg: "Có lỗi xảy ra vui lòng thử lại sau");
      }
      if (int.parse(responseBody["code"]) == 1000) {
          context.go('/authenticated/0');
      }
    } catch (err) {
      debugPrint("get exception $err");
    }

}



}

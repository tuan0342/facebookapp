import 'dart:convert';

import 'package:facebook_app/models/image_model.dart' as myImage;
import 'package:facebook_app/models/post_model.dart';
import 'package:facebook_app/rest_api/rest_api.dart';
import 'package:facebook_app/services/app_service.dart';
import 'package:facebook_app/services/auth_service.dart';
import 'package:facebook_app/util/common.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeedService {
  List<Post> posts = [
    Post(
        id: 1,
        name: "",
        image: [const myImage.Image(id: 1, url: "assets/images/img")],   // 
        described: "",
        created: "2023-11-16T07:37:51.804Z",
        feel: 10,
        markComment: 0,
        isFelt: 1,
        state: "Not Hyped",
        author: Author(id: 1, name: "Nguyễn Khánh Duy", avatar: "https://it4788.catan.io.vn/files/avatar-1700472905228-894880239.jpg"),
        canEdit: 1,
        banned: 0,
        isBlocked: 0,
      ),
    Post(
        id: 1,
        name: "",
        image: [const myImage.Image(id: 1, url: "")],
        described: "",
        created: "2023-11-16T07:37:51.804Z",
        feel: 8,
        markComment: 0,
        isFelt: 1,
        state: "Not Hyped",
        author: Author(id: 1, name: "Nguyễn Khánh Duy", avatar: ""),
        canEdit: 1,
        banned: 0,
        isBlocked: 0,),
    Post(
        id: 1,
        name: "",
        image: [const myImage.Image(id: 1, url: "")],
        described: "",
        created: "2023-11-16T07:37:51.804Z",
        feel: 20,
        markComment: 0,
        isFelt: 0,
        state: "Not Hyped",
        author: Author(id: 1, name: "Nguyễn Khánh Duy", avatar: ""),
        canEdit: 1,
        banned: 0,
        isBlocked: 0,),
    Post(
        id: 1,
        name: "",
        image: [const myImage.Image(id: 1, url: "")],
        described: "",
        created: "2023-11-16T07:37:51.804Z",
        feel: 0,
        markComment: 0,
        isFelt: 0,
        state: "Not Hyped",
        author: Author(id: 1, name: "Nguyễn Khánh Duy", avatar: ""),
        canEdit: 1,
        banned: 0,
        isBlocked: 0,),
  ];

  Future<List<Post>> getFeeds() async {
    return Future.value(posts);
  }

  bool updateFeed(int index) {
    // posts[index].disappointedNumber +=1;
    // posts[index].kudosNumber += 1;
    return true;
  }

  Future<List<Post>> getPersonalFeeds({
    required BuildContext context, required String in_campaign, required String campaign_id,
    required String latitude, required String longitude, required String last_id, 
    required String index, required String count,
  }) async {
    List<Post> myPosts = [];
    late AuthService _authService =
        Provider.of<AuthService>(context, listen: false);
    try {
      final _appService = Provider.of<AppService>(context, listen: false);

      Map<String, dynamic> body = {
        "user_id": _appService.uidLoggedIn,
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

      final response = await postMethod(endpoind: "get_list_posts", body: body, headers: headers);
      final responseBody = jsonDecode(response.body);
      debugPrint('check responseBody: ${responseBody}');

      if (int.parse(responseBody["code"]) == 9998) {
        throw UnauthorizationException();
      }
      if (int.parse(responseBody["code"]) == 1000) {
        var test = (responseBody["data"]["post"] as List);
        debugPrint('check ${test}');

        myPosts = (responseBody["data"]["post"] as List)
            .map((e) => Post.fromJson(e))
            .toList();
        debugPrint('check ${myPosts}');

        // List<Post> postsObj = postsJson.map((tagJson) => Post.fromJson(tagJson)).toList();
        // debugPrint('check hehe');
        // debugPrint('check postsObj: ${postsObj}');
        // return postsObj;
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

    return myPosts;
    // return Future.value(posts);
  }
}

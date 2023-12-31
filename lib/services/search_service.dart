import 'dart:convert';

import 'package:facebook_app/models/friend_model.dart';
import 'package:facebook_app/models/post_model.dart';
import 'package:facebook_app/models/search_log_model.dart';
import 'package:facebook_app/rest_api/rest_api.dart';
import 'package:facebook_app/services/app_service.dart';
import 'package:facebook_app/services/auth_service.dart';
import 'package:facebook_app/util/common.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchService {
  final BuildContext context;
  late final AppService _appService =
      Provider.of<AppService>(context, listen: false);
  SearchService({required this.context});

  Future<List<Post>> search(
    String keyword,
    int index,
    int count,
  ) async {
    List<Post> posts = [];
    try {
      Map<String, dynamic> body = {
        "keyword": keyword,
        // "user_id": _appService.uidLoggedIn,
        "index": index,
        "count": count
      };
      Map<String, String> headers = {
        "Authorization": "Bearer ${_appService.token}",
        'Content-Type': 'application/json; charset=UTF-8'
      };

      final response =
          await postMethod(endpoind: "search", body: body, headers: headers);
      final responseBody = jsonDecode(response.body);
      debugPrint("response: $responseBody");
      if (int.parse(responseBody["code"]) == 9998) {
        throw UnauthorizationException();
      }
      if (response.statusCode == 200) {
        posts = (responseBody["data"] as List)
            .map((post) => Post.fromJson(post))
            .toList();
      }
    } on UnauthorizationException {
      // ignore: use_build_context_synchronously
      Provider.of<AuthService>(context, listen: false).logOut(
          context: context,
          isShowSnackbar: true,
          msg: "Phiên đăng nhập hết hạn");
    } catch (err) {
      debugPrint("get exception $err");
    }
    return posts;
  }

  Future<List<SuggestFriendModel>> searchUser(
      String keyword, int index, int count) async {
    List<SuggestFriendModel> result = [];
    try {
      Map<String, dynamic> body = {
        "keyword": keyword,
        "index": index,
        "count": count,
      };

      Map<String, String> headers = {
        "Authorization": "Bearer ${_appService.token}",
        'Content-Type': 'application/json; charset=UTF-8',
      };
      debugPrint('bcd in search service: -- body ${body}');

      final response = await postMethod(
          endpoind: "search_user", body: body, headers: headers);
      final responseBody = jsonDecode(response.body);
      if (int.parse(responseBody["code"]) == 9998) {
        throw UnauthorizationException();
      }
      debugPrint('bcd in search service: -- responseBody ${responseBody}');
      if (response.statusCode == 200) {
        result = (responseBody["data"] as List)
            .map((e) => SuggestFriendModel.fromJson(e))
            .toList();
      }
    } on UnauthorizationException {
      // ignore: use_build_context_synchronously
      Provider.of<AuthService>(context, listen: false).logOut(
          context: context,
          isShowSnackbar: true,
          msg: "Phiên đăng nhập hết hạn");
    } catch (err) {
      debugPrint("get err $err");
    }

    return result;
  }

  Future<List<SearchLogModel>> getRecentKeywords(
      {required int index,
      required int count,
      bool inSearchPage = false}) async {
    List<SearchLogModel> recentKeywords = [];
    if (inSearchPage &&
        _appService.sharedPreferences
                .getStringList("KEYWORDS_${_appService.uidLoggedIn}") !=
            null) {
      recentKeywords = _appService.sharedPreferences
          .getStringList("KEYWORDS_${_appService.uidLoggedIn}")!
          .map((e) => SearchLogModel(id: 0, keyword: e, created: ""))
          .toList();
    }

    try {
      Map<String, dynamic> body = {"index": index, "count": count};

      Map<String, String> headers = {
        "Authorization": "Bearer ${_appService.token}",
        'Content-Type': 'application/json'
      };

      final response = await postMethod(
          endpoind: "get_saved_search", body: body, headers: headers);
      final responseBody = jsonDecode(response.body);
      if (int.parse(responseBody["code"]) == 9998) {
        throw UnauthorizationException();
      }
      if (response.statusCode == 200) {
        recentKeywords = (responseBody["data"] as List)
            .map((e) => SearchLogModel.fromJson(e))
            .toList();
      }
    } on UnauthorizationException {
      // ignore: use_build_context_synchronously
      Provider.of<AuthService>(context, listen: false).logOut(
          context: context,
          isShowSnackbar: true,
          msg: "Phiên đăng nhập hết hạn");
    } catch (err) {
      debugPrint("get exception $err");
    } finally {
      // ignore: control_flow_in_finally
      return recentKeywords;
    }
  }

  Future<void> deleteSearchLog({required int id, int all = 0}) async {
    try {
      Map<String, dynamic> body = {"search_id": id, "all": all};
      Map<String, String> headers = {
        "Authorization": "Bearer ${_appService.token}",
        'Content-Type': 'application/json'
      };
      final response = await postMethod(
          endpoind: "del_saved_search", body: body, headers: headers);
      final responseBody = jsonDecode(response.body);
      if (int.parse(responseBody["code"]) == 9998) {
        throw UnauthorizationException();
      }
      if (response.statusCode == 200) {
        // ignore: use_build_context_synchronously
        showSnackBar(context: context, msg: "Xóa thành công");
      }
    } on UnauthorizationException {
      // ignore: use_build_context_synchronously
      Provider.of<AuthService>(context, listen: false).logOut(
          context: context,
          isShowSnackbar: true,
          msg: "Phiên đăng nhập hết hạn");
    } catch (err) {
      // ignore: use_build_context_synchronously
      // showSnackBar(context: context, msg: "Có lỗi xảy ra, vui lòng thử lại sau");
      throw ApiFailException();
    }
  }
}

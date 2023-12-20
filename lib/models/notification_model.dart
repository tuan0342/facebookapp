import 'package:facebook_app/util/common.dart';

class NotificationModel {
  final String title;
  final String message;
  Map<String, dynamic>? data;

  NotificationModel({required this.title, required this.message, this.data});

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "message": message,
      "data": data,
    };
  }
}

class BaseNotiData {
  final String type;
  final String avatar;

  BaseNotiData({required this.type, required this.avatar});
}

class InteractPostNotiModel extends BaseNotiData {
  final int postId;

  InteractPostNotiModel(
      {required this.postId, super.type = INTERACTPOST, required super.avatar});

  Map<String, dynamic> toMap() => {
        "type": type,
        "postId": postId,
        "avatar": avatar,
      };
}

class AccepetFriendNotiModel extends BaseNotiData {
  final int friendId;

  AccepetFriendNotiModel(
      {required this.friendId,
      super.type = ACCEPTFRIEND,
      required super.avatar});

  Map<String, dynamic> toMap() => {
        "type": type,
        "friendId": friendId,
        "avatar": avatar,
      };
}

class RequestFriendNotiModel extends BaseNotiData {
  RequestFriendNotiModel({super.type = REQUESTFRIEND, required super.avatar});

  Map<String, dynamic> toMap() => {
        "type": type,
        "avatar": avatar,
      };
}

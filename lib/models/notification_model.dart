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

  BaseNotiData({required this.type});
}

class InteractPostNotiModel extends BaseNotiData {
  final int postId;

  InteractPostNotiModel({required this.postId, super.type = INTERACTPOST});

  Map<String, dynamic> toMap() => {
        "type": type,
        "postId": postId,
      };
}

class AccepetFriendNotiModel extends BaseNotiData {
  final int friendId;

  AccepetFriendNotiModel({required this.friendId, super.type = ACCEPTFRIEND});

  Map<String, dynamic> toMap() => {
        "type": type,
        "friendId": friendId,
      };
}

class RequestFriendNotiModel extends BaseNotiData {
  RequestFriendNotiModel({super.type = REQUESTFRIEND});

  Map<String, dynamic> toMap() => {
        "type": type,
      };
}

import 'package:http/http.dart';

class FriendModel {
  final int id;
  final String username;
  final String avatar;
  final int sameFriends;
  final String created;

  FriendModel({
    required this.id,
    required this.username,
    required this.avatar,
    required this.sameFriends,
    required this.created,
  });

  FriendModel.fromJson(Map<String, dynamic> json)
      : id = int.parse(json["id"] ?? 0),
        username = json["username"] ?? "",
        avatar = json["avatar"] ?? "",
        sameFriends = int.parse(json["same_friends"] ?? 0),
        created = json["created"] ?? "";

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "username": username,
      "avatar": avatar,
      "same_friends": sameFriends,
      "created": created,
    };
  }
}

class FriendBlock {
  final int id;
  final String username;
  final String avatar;

  FriendBlock({
    required this.id,
    required this.username,
    required this.avatar,
  });

  FriendBlock.fromJson(Map<String, dynamic> json)
      : id = int.parse(json["id"] ?? 0),
        username = json["name"] ?? "",
        avatar = json["avatar"] ?? "";

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": username,
      "avatar": avatar,
    };
  }
}

class RequestFriendModel extends FriendModel {
  bool isReject = false;
  RequestFriendModel(
      {required super.id,
      required super.username,
      required super.avatar,
      required super.sameFriends,
      required super.created});

  // set isReject(bool state) {
  //   this.isReject = state;
  // }

  // bool get isReject => this._isReject;

  factory RequestFriendModel.fromJson(Map<String, dynamic> json) =>
      RequestFriendModel(
          id: int.parse(json["id"] ?? 0),
          username: json["username"] ?? "",
          avatar: json["avatar"] ?? "",
          sameFriends: int.parse(json["same_friends"] ?? 0),
          created: json["created"] ?? "");
  // Map<String, dynamic> toJson() {
  //   return {
  //     "id": id,
  //     "username": username,
  //     "avatar": avatar,
  //     "same_friends": sameFriends,
  //     "created": created,
  //   };
  // }
}

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

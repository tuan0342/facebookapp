import 'package:facebook_app/models/image_model.dart';

class Post {
  final int id;
  final String name;
  List<ImageModel> image;
  String described;
  String created;
  int feel;
  int markComment;
  int isFelt;
  String state;
  final Author author;
  int isBlocked;
  int canEdit;
  int banned;

  Post(
      {required this.id,
      required this.name,
      required this.image,
      required this.described,
      required this.created,
      required this.feel,
      required this.markComment,
      required this.isFelt,
      required this.state,
      required this.author,
      required this.isBlocked,
      required this.canEdit,
      required this.banned});

  Post.fromJson(Map<String, dynamic> json)
      : id = int.parse(json["id"] ?? "0"),
        name = json["name"] ?? "anonymous",
        image = (json["image"] as List)
            .map((image) => ImageModel.fromJson(image))
            .toList(),
        described = json["described"] ?? "",
        created = json["created"] ?? "",
        feel = int.parse(json["feel"] ?? "0"),
        markComment = int.parse(json["comment_mark"] ?? "0"),
        isFelt = int.parse(json["is_felt"] ?? "-1"),
        state = json["state"] ?? "",
        author = Author.fromJson(json["author"]),
        isBlocked = int.parse(json["is_blocked"] ?? "0"),
        canEdit = int.parse(json["can_edit"] ?? "0"),
        banned = int.parse(json["banned"] ?? "0");

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "image": image.map((e) => e.toJson()).toList(),
      "described": described,
      "created": created,
      "feel": feel,
      "comment_mark": markComment,
      "is_felt": isFelt,
      "state": state,
      "author": author,
      "is_blocked": isBlocked,
      "can_edit": canEdit,
      "banned": banned,
    };
  }
}

class Author {
  final int id;
  final String name;
  final String avatar;

  const Author({
    required this.id,
    required this.name,
    required this.avatar,
  });

  Author.fromJson(Map<String, dynamic> json)
      : id = int.parse(json["id"]),
        name = json["name"],
        avatar = json["avatar"];

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "avatar": avatar,
      };
}

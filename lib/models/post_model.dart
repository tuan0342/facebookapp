
import 'package:facebook_app/models/image_model.dart';
class Post {
  final int id;
  final String name;
  List<ImageModel> image;
  Video video;
  String described;
  String status;
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
      required this.video,
      required this.described,
        required this.status,
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
        video = Video.fromJson(json["video"] ?? {"url": ""}),
        described = json["described"] ?? "",
        status = json["status"] ?? "",
        created = json["created"] ?? "",
        feel = int.parse(json["feel"] ?? "0"),
        markComment = int.parse(json["comment_mark"] ?? "0"),
        isFelt = int.parse(json["is_felt"] ?? "-1"),
        state = json["state"] ?? "",
        author = Author.fromJson(json["author"]),
        isBlocked = int.parse(json["is_blocked"] ?? "0"),
        canEdit = int.parse(json["can_edit"] ?? "0"),
        banned = int.parse(json["banned"] ?? "0");
        // video = json["video"] ?? "";
  Map<String, dynamic> toJson() {
    return {
      "id": id.toString(),
      "name": name,
      "image": image.map((e) => e.toJson()).toList(),
      "video": video.toJson(),
      "described": described,
      "status": status,
      "created": created,
      "feel": feel.toString(),
      "comment_mark": markComment.toString(),
      "is_felt": isFelt.toString(),
      "state": state,
      "author": author,
      "is_blocked": isBlocked.toString(),
      "can_edit": canEdit.toString(),
      "banned": banned.toString(),
      // "video": video.toString()
    };
  }
}

class Video {
  final String url;

  Video({required this.url});

  Video.fromJson(Map<String, dynamic> json) : url = json["url"];

  Map<String, dynamic> toJson() => {
        "url": url,
      };
}

class Author {
  final int id;
  final String name;
  final String avatar;
  final int coins;
  // danh sách bài viết của tác giả
  final List<String> listing;
  const Author({
    required this.id,
    required this.name,
    required this.avatar,
    required this.coins,
    required this.listing,
  });

  Author.fromJson(Map<String, dynamic> json)
      : id = int.parse(json["id"] ?? "0"),
        name = json["name"] ?? "",
        avatar = json["avatar"] ?? "",
        coins = int.parse(json["coins"] ?? "0"),
        listing = [];

  Map<String, dynamic> toJson() => {
        "id": id.toString(),
        "name": name,
        "avatar": avatar,
        "coins": coins.toString(),
        "listing": listing,
      };
}

class Category {
  final int id;
  final int hasName;
  final String name;

  const Category({
    required this.id,
    required this.name,
    required this.hasName,
  });

  Category.fromJson(Map<String, dynamic> json)
      : id = int.parse(json["id"] ?? "0"),
        name = json["name"] ?? "",
        hasName = int.parse(json["has_name"] ?? "0");

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "has_name": hasName,
      };
}

class PostDetailModel {
  final int id;
  final String name;
  List<ImageModel> image;
  final Video video;
  int modified;
  String described;
  String created;
  int isFelt;
  int fake;
  int trust;
  int kudos;
  int disappointed;
  int isMark;
  String state;
  Category category;
  final Author author;
  int isBlocked;
  int canEdit;
  int banned;
  int canMark;
  int canRate;
  String url;
  String messages;

  PostDetailModel({
    required this.id,
    required this.name,
    required this.image,
    required this.video,
    required this.described,
    required this.created,
    required this.state,
    required this.author,
    required this.isBlocked,
    required this.canEdit,
    required this.banned,
    required this.canMark,
    required this.canRate,
    required this.category,
    required this.disappointed,
    required this.fake,
    required this.isMark,
    required this.isFelt,
    required this.kudos,
    required this.trust,
    required this.modified,
    required this.url,
    required this.messages,
  });

  PostDetailModel.fromJson(Map<String, dynamic> json)
      : id = int.parse(json["id"] ?? "0"),
        name = json["name"] ?? "anonymous",
        image = (json["image"] as List)
            .map((image) => ImageModel.fromJson(image))
            .toList(),
        video = Video.fromJson(json["video"] ?? {"url": ""}),
        described = json["described"] ?? "",
        created = json["created"] ?? "",
        state = json["state"] ?? "",
        author = Author.fromJson(json["author"]),
        isBlocked = int.parse(json["is_blocked"] ?? "0"),
        canEdit = int.parse(json["can_edit"] ?? "0"),
        banned = int.parse(json["banned"] ?? "0"),
        canMark = int.parse(json["can_mark"] ?? "0"),
        canRate = int.parse(json["can_rate"] ?? "0"),
        category = Category.fromJson(json["category"]),
        disappointed = int.parse(json["disappointed"] ?? "0"),
        fake = int.parse(json["fake"] ?? "0"),
        isMark = int.parse(json["is_mark"] ?? "0"),
        isFelt = int.parse(json["is_felt"] ?? "0"),
        kudos = int.parse(json['kudos'] ?? "0"),
        trust = int.parse(json["trust"] ?? "0"),
        modified = int.parse(json['modified'] ?? "0"),
        url = json["url"] ?? "",
        messages = "";

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "image": image.map((e) => e.toJson()).toList(),
      "video": video.toJson(),
      "described": described,
      "created": created,
      "state": state,
      "author": author,
      "is_blocked": isBlocked,
      "can_edit": canEdit,
      "banned": banned,
      "can_mark": canMark,
      "can_rate": canRate,
      "category": category,
      "disappointed": disappointed,
      "fake": fake,
      "is_mark": isMark,
      "is_felt": isFelt,
      "kudos": kudos,
      "trust": trust,
      "modified": modified,
      "url": url,
      "messages": messages,
    };
  }
}

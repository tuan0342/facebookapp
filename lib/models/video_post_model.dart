import 'package:facebook_app/models/post_model.dart';

class VideoPost {
  final int id;
  final String name;
  final Video video;
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

  VideoPost({
    required this.id,
    required this.name,
    required this.video,
    required this.described,
    required this.created,
    required this.feel,
    required this.markComment,
    required this.isFelt,
    required this.state,
    required this.author,
    required this.isBlocked,
    required this.canEdit,
    required this.banned
  });

  VideoPost.fromJson(Map<String, dynamic> json)
    :  id = int.parse(json["id"]),
        name = json["name"],
        video = Video.fromJson(json["video"]),
        described = json["described"],
        created = json["created"],
        feel = int.parse(json["feel"]),
        markComment = int.parse(json["comment_mark"]),
        isFelt = int.parse(json["is_felt"]),
        state = json["state"],
        author = Author.fromJson(json["author"]),
        isBlocked = int.parse(json["is_blocked"]),
        canEdit = int.parse(json["can_edit"]),
        banned = int.parse(json["banned"]);

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "video": video.toJson(),
      "described": described,
      "created": created,
      "feel": feel,
      "comment_mark": markComment,
      "is_felt": isFelt,
      "state": state,
      "author": author.toJson(),
      "is_blocked": isBlocked,
      "can_edit": canEdit,
      "banned": banned,
    };
  }
}

class Video {
  final String url;

  const Video({ required this.url});

  Video.fromJson(Map<String, dynamic> json)
    : url = json["url"];

  Map<String, dynamic> toJson() => {
    "url": url
  };
}
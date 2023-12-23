class PosterModel {
  final int id;
  final String name;
  final String avatar;

  PosterModel({required this.id, required this.name, required this.avatar});

  PosterModel.fromJson(Map<String, dynamic> json)
      : id = int.parse(json["id"] ?? "0"),
        name = json["name"] ?? "",
        avatar = json["avatar"] ?? "";
}

class CommentModel {
  final String content;
  final String created;
  final PosterModel poster;

  CommentModel(
      {required this.content, required this.created, required this.poster});

  CommentModel.fromJson(Map<String, dynamic> json)
      : content = json["content"] ?? "",
        created = json["created"] ?? "",
        poster = PosterModel.fromJson(json["poster"]);
}

class MarkModel {
  final int id;
  final String markContent;
  final String created;
  final PosterModel poster;
  final List<CommentModel> comments;

  MarkModel(
      {required this.id,
      required this.markContent,
      required this.created,
      required this.poster,
      required this.comments});

  MarkModel.fromJson(Map<String, dynamic> json)
      : id = int.parse(json["id"] ?? "0"),
        markContent = json["mark_content"] ?? "",
        created = json["created"] ?? "",
        poster = PosterModel.fromJson(json["poster"]),
        comments = (json["comments"] as List)
            .map((comment) => CommentModel.fromJson(comment))
            .toList();
}

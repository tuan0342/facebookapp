import 'dart:convert';

import 'package:facebook_app/models/image_model.dart';

class Post {
  final int id;
  final String name;
  final List<Image> image;
  final String described;
  final String created;
  final int feel;
  final int markComment;
  final int isFelt;
  final String state;
  final Author author;

  const Post( 
      {required this.id,
      required this.name,
      required this.image,
      required this.described,
      required this.created,
      required this.feel,
      required this.markComment,
      required this.isFelt,
      required this.state,
      required this.author});

  Post.fromJson(Map<String, dynamic> json)
      : id = int.parse(json["id"]),
        name = json["name"],
        image = (json["image"] as List).map((image) => Image.fromJson(image)).toList(),
        described = json["described"],
        created = json["created"],
        feel = int.parse(json["feel"]),
        markComment = int.parse(json["mark_comment"]),
        isFelt = int.parse(json["is_felt"]),
        state = json["state"],
        author = Author.fromJson(json["author"]);

  Map<String, dynamic> toJson() {
    return {
        "id" : id,
        "name" : name,
        "image" : image.map((e) => e.toJson()).toList(),
        "described" : described,
        "created" : created,
        "feel" : feel,
        "mark_comment" : markComment,
        "is_felt" : isFelt,
        "state" : state,
        "author" : author,
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

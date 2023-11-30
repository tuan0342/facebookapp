class Image {
  final int id;
  final String url;

  const Image({required this.id, required this.url});

  Image.fromJson(Map<String, dynamic> json)
      : id = int.parse(json["id"]),
        url = json["url"];

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
      };
}

class ImageModel {
  final int id;
  final String url;

  const ImageModel({required this.id, required this.url});

  ImageModel.fromJson(Map<String, dynamic> json)
      : id = int.parse(json["id"]),
        url = json["url"];

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
      };
}

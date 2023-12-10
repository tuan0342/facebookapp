class SearchLogModel {
  final int id;
  final String keyword;
  final String created;
  const SearchLogModel(
      {required this.id, required this.keyword, required this.created});

  SearchLogModel.fromJson(Map<String, dynamic> json)
      : id = int.parse(json["id"]),
        keyword = json["keyword"],
        created = json["created"];

  Map<String, dynamic> toJson() => {
        "id": id,
        "keyword": keyword,
        "created": created,
      };
}

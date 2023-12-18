class Profile {
  final String id;
  final String username;
  final String created;
  final String description;
  final String avatar;
  final String imageCover;
  final String link;
  final String address;
  final String city;
  final String country;
  final String listing; // count friends
  final String isFriend;
  final String online;
  final String coins;

  const Profile({
    required this.id,
    required this.username,
    required this.created,
    required this.description,
    required this.avatar,
    required this.imageCover,
    required this.link,
    required this.address,
    required this.city,
    required this.country,
    required this.listing,
    required this.isFriend,
    required this.online,
    required this.coins,
  });

  Profile.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        username = json['username'],
        created = json['created'],
        description = json['description'],
        avatar = json['avatar'],
        imageCover = json['cover_image'],
        link = json['link'],
        address = json['address'],
        city = json['city'],
        country = json['country'],
        listing = json['listing'],
        isFriend = json['is_friend'],
        online = json['online'],
        coins = json['coins'];

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": username,
        "created": created,
        "description": description,
        "avatar": avatar,
        "imageCover": imageCover,
        "link": link,
        "address": address,
        "city": city,
        "country": country,
        "listing": listing,
        "isFriend": isFriend,
        "online": online,
        "coins": coins,
      };
}

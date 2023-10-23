class User {
  final String id;
  final String name;
  final String address;
  final String avatar;
  final String userClass;
  final String gpa;
  final String userEmail;
  final String password;

  const User(
      {required this.id,
      required this.address,
      required this.avatar,
      required this.userClass,
      required this.gpa,
      required this.name,
      required this.userEmail,
      required this.password});

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        address = json['address'],
        avatar = json['avatar'],
        userClass = json['class'],
        gpa = json['gpa'],
        userEmail = json['email'],
        password = json['password'];

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "avatar": avatar,
        "class": userClass,
        "gpa": gpa,
        "email": userEmail,
        "password": password,
      };
}

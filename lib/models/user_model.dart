class User {
  final String userEmail;
  final String password;
  final String uuid;
  final int coins;
  final String username;

  const User({
    required this.userEmail,
    required this.password,
    required this.uuid,
    required this.coins,
    required this.username,
  });

  User.fromJson(Map<String, dynamic> json)
      : userEmail = json['email'],
        password = json['password'],
        uuid = json['uuid'],
        coins = json['coins'],
        username = json['username'];

  Map<String, dynamic> toJson() => {
        "email": userEmail,
        "password": password,
        "uuid": uuid,
        "coins": coins,
        "username": username,
      };
}

class UserLogIn {
  final String userEmail;
  final String password;
  final String uuid;

  UserLogIn(
      {required this.userEmail, required this.password, required this.uuid});

  UserLogIn.fromJson(Map<String, dynamic> json)
      : userEmail = json['email'],
        password = json['password'],
        uuid = json['uuid'];

  Map<String, dynamic> toJson() => {
        "email": userEmail,
        "password": password,
        "uuid": uuid,
      };
}

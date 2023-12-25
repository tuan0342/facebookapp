import 'package:facebook_app/models/user_model.dart';

class Conversation {
  final String id;
  final User user;
  final String lastMessage;
  final bool isRead;
  final int lastTime;

  const Conversation({
    required this.user,
    required this.id,
    required this.lastMessage,
    required this.lastTime,
    required this.isRead,
  });

  // User.fromJson(Map<String, dynamic> json)
  //     : userEmail = json['email'],
  //       password = json['password'],
  //       uuid = json['uuid'],
  //       coins = json['coins'],
  //       username = json['username'];
  //
  // Map<String, dynamic> toJson() => {
  //   "email": userEmail,
  //   "password": password,
  //   "uuid": uuid,
  //   "coins": coins,
  //   "username": username,
  // };
}

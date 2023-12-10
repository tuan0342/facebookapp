import 'package:facebook_app/models/friend_model.dart';
import 'package:facebook_app/my_widgets/my_image.dart';
import 'package:flutter/material.dart';

class FriendBlockItem extends StatelessWidget {
  final FriendBlock friend;
  const FriendBlockItem({
    super.key,
    required this.friend,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 0, right: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          MyImage(
            imageUrl: friend.avatar,
            height: 50,
            width: 50,
            shape: BoxShape.rectangle,
          ),
          const SizedBox(
            width: 12,
          ),
          Flexible(
              child: Text(
            friend.username,
            style: const TextStyle(fontSize: 16),
          )),
        ],
      ),
    );
  }
}

import 'package:facebook_app/models/friend_model.dart';
import 'package:facebook_app/my_widgets/my_image.dart';
import 'package:facebook_app/services/friend_service.dart';
import 'package:facebook_app/util/common.dart';
import 'package:flutter/material.dart';

class FriendBlockItem extends StatelessWidget {
  final FriendBlock friend;
  final VoidCallback refreshBlock;
  const FriendBlockItem({
    super.key,
    required this.friend,
    required this.refreshBlock,
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
          // Flexible(
          //     child: Text(
          //   friend.username,
          //   style: const TextStyle(fontSize: 16),
          // )),
          Text(
            friend.username,
            style: const TextStyle(fontSize: 16),
          ),

          const Spacer(),
          TextButton(
              onPressed: () async {
                      final success = await FriendService(context: context)
                          .setUnblocksFriend(friend.id.toString());
                      if (success) {
                        // ignore: use_build_context_synchronously
                        showSnackBar(
                          context: context,
                          msg: "Đã bỏ chặn người dùng: ${friend.username}");
                        refreshBlock();
                      }
                    },
              child: const Text(
                      'Bỏ chặn',
                      style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w700),
                    ),)
        ],
      ),
    );
  }
}

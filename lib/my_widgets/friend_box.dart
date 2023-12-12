import 'package:facebook_app/models/friend_model.dart';
import 'package:facebook_app/my_widgets/my_image.dart';
import 'package:facebook_app/services/friend_service.dart';
import 'package:facebook_app/util/common.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FriendBox extends StatelessWidget {
  final FriendModel friend;
  final VoidCallback onRemove;
  const FriendBox({
    super.key,
    required this.friend,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      // avatar
      Expanded(
          flex: 2,
          child: GestureDetector(
            onTap: () =>
                {context.push("/authenticated/personalPage/${friend.id}")},
            child: MyImage(
              imageUrl: friend.avatar,
              height: 90,
              width: 90,
            ),
          )),
      const SizedBox(
        width: 12,
      ),
      // info and button
      Expanded(
          flex: 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // name and time
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    friend.username,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.more_horiz,
                      size: 25,
                      color: Colors.grey[600],
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: MyImage(
                                        imageUrl: friend.avatar,
                                        width: 60,
                                        height: 60,
                                      ),
                                    ),
                                    Expanded(
                                        flex: 1,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              friend.username,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "Là bạn bè từ ${getDifferenceTime(DateTime.now(), DateTime.parse(friend.created))}",
                                              style: const TextStyle(
                                                  color: Colors.grey),
                                            )
                                          ],
                                        ))
                                  ],
                                ),
                                TextButton(
                                  onPressed: () async {
                                    // block user
                                    final success = await FriendService(
                                            context: context)
                                        .setBlocksFriend(friend.id.toString());
                                    if (success) {
                                      // ignore: use_build_context_synchronously
                                      showSnackBar(
                                          context: context,
                                          msg:
                                              "Đã chặn tài khoản ${friend.username}");
                                      onRemove();
                                    }
                                    // ignore: use_build_context_synchronously
                                    Navigator.pop(context);
                                  },
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.lock,
                                        size: 30,
                                        color: Colors.black,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "chặn ${friend.username}",
                                        style: const TextStyle(
                                            fontSize: 16, color: Colors.black),
                                      )
                                    ],
                                  ),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    // block user
                                    final success =
                                        await FriendService(context: context)
                                            .unFriend(friend.id);
                                    if (success) {
                                      // ignore: use_build_context_synchronously
                                      showSnackBar(
                                          context: context,
                                          msg:
                                              "Đã hủy kết bạn với ${friend.username}");
                                      onRemove();
                                    }
                                    // ignore: use_build_context_synchronously
                                    Navigator.pop(context);
                                  },
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.person_add_disabled,
                                        size: 30,
                                        color: Colors.black,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Huỷ kết bạn với ${friend.username}",
                                        style: const TextStyle(
                                            fontSize: 16, color: Colors.black),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 2,
              ),
              // bạn chung
              if (friend.sameFriends > 0)
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      friend.sameFriends > 0
                          ? "${friend.sameFriends} bạn chung"
                          : "",
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
            ],
          ))
    ]);
  }
}

import 'package:facebook_app/models/friend_model.dart';
import 'package:facebook_app/my_widgets/my_image.dart';
import 'package:facebook_app/services/friend_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SuggestFriendBox extends StatelessWidget {
  final FriendModel friend;
  final VoidCallback onSendRequestSuccess;
  final VoidCallback onRejectSuccess;
  const SuggestFriendBox(
      {super.key,
      required this.friend,
      required this.onSendRequestSuccess,
      required this.onRejectSuccess});

  void _onRemoveSuggest(BuildContext context) async {
    onRejectSuccess();
  }

  void _onAddFriend(BuildContext context) async {
   final  isSendRequested = await FriendService(context: context)
        .setRequestFriend(friend.id);

    if (isSendRequested) {

    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      // avatar
      Expanded(
          flex: 2,
          child: GestureDetector(
            onTap: () => {
              context.push("/authenticated/personalPage/${friend.id}")
            },
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    friend.username,
                    style: const TextStyle(fontWeight: FontWeight.bold),
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

              const SizedBox(
                height: 6,
              ),
              // button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        _onAddFriend(context);
                      },
                      style: ElevatedButton.styleFrom(),
                      child: const Text("Thêm bạn bè"),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        _onRemoveSuggest(context);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[300]),
                      child: const Text(
                        "Gỡ",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ))
    ]);
  }
}

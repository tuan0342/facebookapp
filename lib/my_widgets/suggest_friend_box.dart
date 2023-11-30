import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook_app/models/friend_model.dart';
import 'package:facebook_app/services/friend_service.dart';
import 'package:flutter/material.dart';

class SuggestFriendBox extends StatelessWidget {
  final FriendModel friend;
  final VoidCallback onAcceptSuccess;
  final VoidCallback onRejectSuccess;
  const SuggestFriendBox(
      {super.key,
      required this.friend,
      required this.onAcceptSuccess,
      required this.onRejectSuccess});

  void _onRemoveSuggest(BuildContext context) async {
    await FriendService(context: context)
        .setAcceptFriend(friend.id, 0, onRejectSuccess);
  }

  void _onAddFriend(BuildContext context) async {
    await FriendService(context: context)
        .setAcceptFriend(friend.id, 1, onAcceptSuccess);
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      // avatar
      Expanded(
          flex: 2,
          child: CachedNetworkImage(
              imageUrl: friend.avatar,
              imageBuilder: (context, imageProvider) => Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.contain)),
                  ),
              placeholder: (context, url) => Container(
                    height: 90,
                    width: 90,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage(
                                "assets/images/male_default_avatar.jpeg"),
                            fit: BoxFit.cover)),
                  ),
              errorWidget: (context, url, error) => Container(
                    height: 90,
                    width: 90,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage(
                                "assets/images/male_default_avatar.jpeg"),
                            fit: BoxFit.cover)),
                  ))),
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

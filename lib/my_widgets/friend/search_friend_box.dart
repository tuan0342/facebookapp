import 'package:facebook_app/models/friend_model.dart';
import 'package:facebook_app/my_widgets/my_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SearchFriendBox extends StatelessWidget {
  final SuggestFriendModel friend;
  final VoidCallback refresh;
  const SearchFriendBox({super.key, required this.friend, required this.refresh});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          const SizedBox(
            width: 15,
          ),
          // avatar
          GestureDetector(
            onTap: () => {
              context.push('/authenticated/personalPage/${friend.id}')
                .then((value) {refresh();})
            },
            child: MyImage(
              imageUrl: friend.avatar,
              height: 70,
              width: 70,
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          // info and button
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // name
              Text(
                friend.username.length > 25 ? "${friend.username.substring(0,25)}..." : friend.username,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(
                height: 4,
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
                height: 10,
              ),
            ],
          )
        ]
      ),
    );
  }
}
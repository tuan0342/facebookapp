import 'package:facebook_app/models/friend_model.dart';
import 'package:facebook_app/my_widgets/friend/friend_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PersonalFriend extends StatelessWidget {
  final List<FriendModel> friends;
  const PersonalFriend({super.key, required this.friends});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20,),
          const Text('Bạn bè', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
          const SizedBox(height: 5,),
          Text('${friends.length} người bạn', style: const TextStyle(fontSize: 18, color: Colors.black54),),

          const SizedBox(height: 20,),
          Wrap(
            direction: Axis.horizontal,
            spacing: 9,
            children: friends.map((friend) => FriendItem(friend: friend,)).toList(),
          ),

          Container(
            margin: const EdgeInsets.only(top: 10.0),
            height: 40,
            child: ElevatedButton(
              onPressed: () {
                context.push("/authenticated/friends");
              },
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFe5e6eb)),
              child: const Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Xem tất cả bạn bè", style: TextStyle(
                      fontSize: 16,
                      fontWeight:FontWeight.bold,
                      color: Colors.black)
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20,),
        ],
      ),
    );
  }
}
import 'package:facebook_app/models/conversation.dart';
import 'package:flutter/material.dart';

class ConversationItem extends StatelessWidget {
  final Conversation conversation;
  const ConversationItem({super.key, required this.conversation});

  // void _onDeleteRequest(BuildContext context) {
  //   showSnackBar(
  //     context: context,
  //     msg: "Delete friend",
  //   );
  // }
  //
  // void _onAcceptRequest(BuildContext context) {
  //   showSnackBar(
  //     context: context,
  //     msg: "Accept friend",
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        child: Center(
          child: Row(children: [
            // avatar
            Expanded(
                flex: 1,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(90),
                    // child: Image.network(friend.avatar))),
                    child: Image.asset("assets/images/male_default_avatar.jpeg"))),
            const SizedBox(
              width: 12,
            ),
            // info and button
            Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // name and time
                    Text(
                      conversation.user.username,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    // mutual friends
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                              conversation.lastMessage,
                              style: TextStyle(color: Colors.grey),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              softWrap: false
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        const Text(
                            "23:45",
                            style: TextStyle(color: Colors.grey),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            softWrap: false
                        )
                      ],
                    ),
                  ],
                )),
            const SizedBox(
              width: 12,
            ),
            SizedBox(
                width: 12,
                height: 12,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(90),
                    // child: Image.network(friend.avatar))),
                    child: Image.asset("assets/images/male_default_avatar.jpeg"))
            ),
          ]),
        ),
      )

    );
  }
}

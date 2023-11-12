import 'package:facebook_app/models/user_model.dart';
import 'package:facebook_app/util/common.dart';
import 'package:flutter/material.dart';

class FriendBox extends StatelessWidget {
  final User friend;
  const FriendBox(
      {super.key,
      this.friend = const User(
          id: "1",
          name: "Full Name Request",
          address: "address",
          userEmail: "email",
          password: "123456",
          userClass: "IT1-02 K65",
          gpa: "4.0",
          avatar: 'https://picsum.photos/250?image=9')});

  void _onDeleteRequest(BuildContext context) {
    showSnackBar(
      context: context,
      msg: "Delete friend",
    );
  }

  void _onAcceptRequest(BuildContext context) {
    showSnackBar(
      context: context,
      msg: "Accept friend",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(children: [
        // avatar
        Expanded(
            flex: 2,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // name and time
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      friend.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "9w",
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
                // mutual friends
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "1 mutual friend",
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      "",
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),

                const SizedBox(
                  height: 10,
                ),
                // button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          _onAcceptRequest(context);
                        },
                        style: ElevatedButton.styleFrom(),
                        child: const Text("Accept"),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          _onDeleteRequest(context);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[300]),
                        child: const Text("Delete", style: TextStyle(color: Colors.black),),
                      ),
                    ),
                  ],
                )
              ],
            ))
      ]),
    );
  }
}

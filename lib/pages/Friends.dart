import 'package:facebook_app/my_widgets/friend_box.dart';
import 'package:facebook_app/my_widgets/my_text_button.dart';
import 'package:facebook_app/util/common.dart';
import 'package:flutter/material.dart';

class Friends extends StatefulWidget {
  Friends({super.key});

  @override
  State<Friends> createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {
  void _onShowSuggest(BuildContext context) {
    showSnackBar(context: context, msg: "show friend suggest");
  }

    void _onShowFriends(BuildContext context) {
    showSnackBar(context: context, msg: "show all friends");
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey))
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text("Friends", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  OutlinedButton(
                      onPressed: () {
                        _onShowSuggest(context);
                      },
                      style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.grey[300],
                          side: BorderSide.none,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          )),
                      child: const Text(
                        "Suggest",
                        style: TextStyle(color: Colors.black),
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  OutlinedButton(
                      onPressed: () {
                        _onShowFriends(context);
                      },
                      style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.grey[300],
                          side: BorderSide.none,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          )),
                      child: const Text(
                        "Friends",
                        style: TextStyle(color: Colors.black),
                      )),
                ],
              )
            ]),
          ),
          const SizedBox(
            height: 12,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: 10, itemBuilder: (context, index) => const FriendBox()),
          ),
        ]),
      ),
    );
  }
}

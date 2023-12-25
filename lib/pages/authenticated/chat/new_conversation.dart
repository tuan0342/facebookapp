import 'package:facebook_app/models/user_model.dart';
import 'package:facebook_app/my_widgets/my_app_bar.dart';
import 'package:facebook_app/my_widgets/my_editText.dart';
import 'package:flutter/material.dart';


List<User> suggestUsers = [
  User(userEmail: "userEmail", password: "password", uuid: "uuid", coins: 20, username: "Duy"),
  User(userEmail: "userEmail", password: "password", uuid: "uuid", coins: 20, username: "Tuấn"),
  User(userEmail: "userEmail", password: "password", uuid: "uuid", coins: 20, username: "Hạnh"),
  User(userEmail: "userEmail", password: "password", uuid: "uuid", coins: 20, username: "Lợi"),
];

class NewConversation extends StatelessWidget {
  const NewConversation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppBar(title: "Tin nhắn mới"),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12,),
              MyEditText(isDisabled: false, labelText: "Tới"),
              const Text("Gợi ý", style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16)),
              const SizedBox(height: 8,),
              Expanded(
                  child: ListView.builder(
                      itemCount: suggestUsers.length,
                      itemBuilder: (BuildContext context, int index) =>
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                        child: Row(
                          children: [
                            SizedBox(
                                width: 32,
                                height: 32,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(90),
                                    // child: Image.network(friend.avatar))),
                                    child: Image.asset("assets/images/male_default_avatar.jpeg"))
                            ),
                            Text(suggestUsers[index].username, style: TextStyle(fontWeight: FontWeight.w600),)
                          ],
                        ),
                      ),
                  )
              )

            ]
        )
    );
  }
}

import 'package:facebook_app/my_widgets/my_app_bar.dart';
import 'package:flutter/material.dart';

class ChatMyProfile extends StatelessWidget {
  const ChatMyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppBar(title: "Tôi"),
        body: Column(
          children: [
            const SizedBox(height: 24,),
            SizedBox(
              width: 82,
              height: 82,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(90),
                  // child: Image.network(friend.avatar))),
                  child: Image.asset("assets/images/male_default_avatar.jpeg")),
            ),
            const Text("Hải Nam", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
            const SizedBox(height: 24,),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
              child: Row(
                children: [
                  Icon(Icons.nightlight_round_outlined),
                  SizedBox(width: 8,),
                  Expanded(child: Text("Chế độ tối"),),
                  Switch(value: true, onChanged: null, )
                ],
              ),
            ),
            const Padding(
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                child: Row(
                  children: [
                    Icon(Icons.message_outlined),
                    SizedBox(width: 8,),
                    Expanded(child: Text("Tin nhắn đang chờ"),),
                  ],
                ),
            ),
          ]
        )

    );
  }
}

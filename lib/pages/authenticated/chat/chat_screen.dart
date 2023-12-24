import 'package:facebook_app/models/conversation.dart';
import 'package:facebook_app/models/user_model.dart';
import 'package:facebook_app/pages/authenticated/chat/my_widgets/conversation_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Conversation> conversations = [
    const Conversation(user: User(userEmail: "userEmail", password: "password", uuid: "uuid", coins: 20, username: "Nam"), id: "1", lastMessage: "Lorem Ipsum is simply dummy text of the printing", lastTime: 1701018297, isRead: true),
    const Conversation(user: User(userEmail: "userEmail", password: "password", uuid: "uuid", coins: 20, username: "Tuấn"), id: "2", lastMessage: "with the release of Letraset sheets containing", lastTime: 1698321897, isRead: false),
    const Conversation(user: User(userEmail: "userEmail", password: "password", uuid: "uuid", coins: 20, username: "Duy"), id: "3", lastMessage: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout", lastTime: 1698322017, isRead: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  context.push("/authenticated/chatMyProfile");
                },
                child: SizedBox(
                    width: 32,
                    height: 32,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(90),
                        // child: Image.network(friend.avatar))),
                        child: Image.asset("assets/images/male_default_avatar.jpeg"))
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              const Text("Chat")
            ],
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              context.push("/authenticated/takePhoto");
            },
            child: const Icon(Icons.camera_alt),
          ),
          const SizedBox(
            width: 12,
          ),
          InkWell(
            onTap: () {
              context.push("/authenticated/newConversation");
            },
            child: const Icon(Icons.add),
          ),
          const SizedBox(
            width: 12,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: conversations.length,
        itemBuilder: (BuildContext context, int index) => ConversationItem(conversation: conversations[index],)
      ),
    );
  }
}

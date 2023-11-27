import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_app/my_widgets/error_when_get_data_screen.dart';
import 'package:facebook_app/my_widgets/waiting_data_screen.dart';
import 'package:facebook_app/services/app_service.dart';
import 'package:facebook_app/util/common.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    final _appService = Provider.of<AppService>(context, listen: false);
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("topics")
            .doc(_appService.uidLoggedIn)
            .collection("notifications")
            .orderBy("createdAt", descending: true)
            .snapshots(),
        builder: ((context, snapshot) {
          if (snapshot.hasError) {
            return const ErrorGettingDataScreen();
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const WaitingDataScreen();
          }

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Notifications",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ListView(
                        children: snapshot.data!.docs
                            .map((doc) => _buildNotiItem(doc))
                            .toList(),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }));
  }

  Widget _buildNotiItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;

    return GestureDetector(
      onTap: handleClickNotification,
      child: Container(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(90),
                      // child: Image.network(friend.avatar))),
                      child: Image.asset(
                          "assets/images/male_default_avatar.jpeg")),
                )),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              flex: 3,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data["notification"]["body"],
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      getDifferenceTime(
                          DateTime.now(),
                          DateTime.fromMillisecondsSinceEpoch(
                              data["createdAt"])),
                      style: const TextStyle(
                          color: Color.fromRGBO(30, 30, 30, 0.6), fontSize: 14),
                    )
                  ]),
            ),
          ],
        ),
      ),
    );
  }

  void handleClickNotification() {}
}

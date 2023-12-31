import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_app/my_widgets/error_when_get_data_screen.dart';
import 'package:facebook_app/my_widgets/my_image.dart';
import 'package:facebook_app/my_widgets/waiting_data_screen.dart';
import 'package:facebook_app/services/app_service.dart';
import 'package:facebook_app/services/notification_services.dart';
import 'package:facebook_app/util/common.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late final NotificationServices notificationService;
  late final AppService appService;
  @override
  Widget build(BuildContext context) {
    appService = Provider.of<AppService>(context, listen: false);
    notificationService =
        Provider.of<NotificationServices>(context, listen: false);

    return StreamBuilder(
        stream: notificationService.fireStore
            .collection("topics")
            .doc(appService.uidLoggedIn)
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(12, 16, 12, 0),
                  child: Text(
                    "Notifications",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView(
                    children: snapshot.data!.docs
                        .map((doc) => _buildNotiItem(doc))
                        .toList(),
                  ),
                )
              ],
            ),
          );
        }));
  }

  Widget _buildNotiItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;

    return GestureDetector(
      onTap: () {
        handleClickNotification(data);
        if (!data["seen"]) {
          notificationService.handleClickNotification(
              topic: appService.uidLoggedIn, messageId: doc.id);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        color: data["seen"]
            ? Colors.white
            : const Color.fromARGB(255, 186, 232, 254),
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: MyImage(
                    imageUrl: data["data"]["avatar"],
                    height: 80,
                    width: 80,
                  ),
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

  void handleClickNotification(Map<String, dynamic> data) {
    final Map<String, dynamic> map = data["data"];
    final route =
        mapNotiDataToStringRoute(map, int.parse(appService.uidLoggedIn));
    if (route != null) {
      context.push(route);
    }
  }
}

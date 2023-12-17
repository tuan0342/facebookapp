import 'package:facebook_app/models/notification_model.dart';
import 'package:facebook_app/services/notification_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  @override
  Widget build(BuildContext context) {
    final NotificationServices notificationService =
        Provider.of<NotificationServices>(context, listen: false);
    return SafeArea(
        child: ElevatedButton(
      onPressed: () {
        notificationService.sendNotificationToTopic(
            topic: "180",
            notification: NotificationModel(
                title: "new message", message: "Send to Tuấn"));
      },
      child: const Text("send noti to Tuan"),
    ));
  }
}

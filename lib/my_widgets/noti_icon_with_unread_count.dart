import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_app/services/app_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotiIconWithUnReadCount extends StatelessWidget {
  const NotiIconWithUnReadCount({super.key});

  @override
  Widget build(BuildContext context) {
    final appService = Provider.of<AppService>(context, listen: false);
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('topics')
            .doc(appService.uidLoggedIn)
            .snapshots(),
        builder: (context, snapshot) {
          try {
            if (snapshot.hasData) {
              final unread = snapshot.data!["unread"] ?? 0;

              return Stack(children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Icon(Icons.notifications),
                ),
                if (unread > 0)
                  Positioned(
                      right: unread <= 9 ? 7 : 0,
                      top: -3,
                      child: Text(
                        unread <= 9 ? unread.toString() : "9+",
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            color: Colors.red, fontWeight: FontWeight.w500),
                      ))
              ]);
            }
          } catch (err) {
            return const Stack(children: [Icon(Icons.notifications), Text("")]);
          }

          return const Stack(children: [Icon(Icons.notifications), Text("")]);
        });
  }
}

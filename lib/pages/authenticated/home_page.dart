import 'package:facebook_app/my_widgets/my_filled_button.dart';
import 'package:facebook_app/services/app_service.dart';
import 'package:facebook_app/services/notification_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    final _notificationService = Provider.of<NotificationServices>(context, listen: false);
    final _appService = Provider.of<AppService>(context, listen: false);
    return Column(
          children: [
            RichText(
              text: const TextSpan(
                text: 'Hello: ',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 16),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Logged In',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.red)
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            MyFilledButton(isDisabled: false,title: "Send notify", cbFunction: () async {
              _notificationService.sendNotificationToTopic(topic: _appService.uidLoggedIn,title:  'title',message: 'message');
            })
          ],
        );
  }
}

import 'package:facebook_app/my_widgets/my_filled_button.dart';
import 'package:facebook_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Column(
          children: [
            RichText(
              text: TextSpan(
                text: 'Hello: ',
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 16),
                children: <TextSpan>[
                  TextSpan(
                    text: Provider.of<AuthService>(context, listen: false).deviceId ?? "dont have device id",
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.red)
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            MyFilledButton(isDisabled: false,title: "Start again", cbFunction: () {
              context.push("/");
            })
          ],
        );
  }
}

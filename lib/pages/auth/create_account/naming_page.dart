import 'package:facebook_app/my_widgets/my_app_bar.dart';
import 'package:facebook_app/my_widgets/my_editText.dart';
import 'package:facebook_app/my_widgets/my_filled_button.dart';
import 'package:facebook_app/my_widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NamingPage extends StatelessWidget {
  const NamingPage({super.key});


  @override
  Widget build(BuildContext context) {
    void nextScreen() {
      context.push("/createAccount/birthdate");
    }

    return Scaffold(
      appBar: MyAppBar(title: "Tên"),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 36.0),
                    child: MyText(title: "Bạn tên gì?", type: "title",),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MyEditText(isDisabled: false, labelText: "Họ"),
                        SizedBox(width: 16,),
                        MyEditText(isDisabled: false, labelText: "Tên")
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 36.0),
                    child: MyFilledButton(title: "Tiếp", isDisabled: false, cbFunction: nextScreen),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:facebook_app/my_widgets/my_app_bar.dart';
import 'package:facebook_app/my_widgets/my_editText.dart';
import 'package:facebook_app/my_widgets/my_filled_button.dart';
import 'package:facebook_app/my_widgets/my_text.dart';
import 'package:facebook_app/my_widgets/my_text_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddEmailPage extends StatelessWidget {
  const AddEmailPage({super.key});


  @override
  Widget build(BuildContext context) {
    void nextScreen() {
      context.push("/createAccount/confirmCode");
    }

    return Scaffold(
      appBar: const MyAppBar(title: "Địa chỉ Email"),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 36.0),
                    child: MyText(title: "Nhập địa chỉ email của bạn", type: "title",),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MyEditText(isDisabled: false, labelText: "Địa chỉ email"),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 36.0),
                    child: MyFilledButton(title: "Tiếp", isDisabled: false, cbFunction: nextScreen),
                  ),
                ],
              ),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: MyTextButton(isDisabled: false, title: "Đăng ký bằng số di động", cbFunction: nextScreen,)
            ),
          ],
        ),
      ),
    );
  }
}
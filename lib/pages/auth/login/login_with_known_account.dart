import 'package:facebook_app/my_widgets/my_app_bar.dart';
import 'package:facebook_app/my_widgets/my_editText.dart';
import 'package:facebook_app/my_widgets/my_filled_button.dart';
import 'package:facebook_app/my_widgets/my_text.dart';
import 'package:facebook_app/my_widgets/my_text_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LogInKnownPage extends StatelessWidget {
  const LogInKnownPage({super.key});

  @override
  Widget build(BuildContext context) {
    void nextScreen() {
      context.go("/authenticated");
    }

    return Scaffold(
      appBar: MyAppBar(title: ""),
      body: Padding(
        padding: EdgeInsets.fromLTRB(16.0, 80.0, 16.0, 0),
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8), // Image border
                      child: SizedBox.fromSize(
                        size: Size.fromRadius(30), // Image radius
                        child: Image.asset("assets/images/male_default_avatar.jpeg"),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 16.0),
                      child: MyText(title: "Anh Hoang", type: "labelLarge",),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 24.0),
                      child: SizedBox(
                        width: 250,
                        child: TextField(
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                            labelText: "Mật khẩu"
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16.0),
                      child: MyFilledButton(isDisabled: false, title: "Đăng nhập", cbFunction: nextScreen),
                    ),
                    MyTextButton(isDisabled: false, title: "Quên mật khẩu?", cbFunction: nextScreen),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
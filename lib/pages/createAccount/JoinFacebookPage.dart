import 'package:facebook_app/my_widgets/my_app_bar.dart';
import 'package:facebook_app/my_widgets/my_filled_button.dart';
import 'package:facebook_app/my_widgets/my_text.dart';
import 'package:facebook_app/my_widgets/my_text_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class JoinFacebookPage extends StatelessWidget {
  const JoinFacebookPage({super.key});


  @override
  Widget build(BuildContext context) {
    void nextScreen() {
      context.push("/createAccount/name");
    }

    return Scaffold(
      appBar: MyAppBar(title: "Tạo tài khoản"),
      body: Padding(
        padding: EdgeInsets.only(left: 16.0, right: 16.0),
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Image.asset("assets/images/Illustration.png"),
                    const Padding(
                      padding: EdgeInsets.only(top: 36.0),
                      child: MyText(title: "Tham gia Facebook", type: "title",),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 16.0),
                      child: MyText(title: "Chúng tôi sẽ giúp bạn tạo tài khoản mới sau vài bước dễ dàng.", type: "label", ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16.0),
                      child: MyFilledButton(isDisabled: false, title: "Tiếp", cbFunction: nextScreen),
                    ),
                  ],
                ),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: MyTextButton(isDisabled: false, title: "Bạn đã có tài khoản?", cbFunction: nextScreen,)
              ),
            ],
          ),
        ),
      ),
    );
  }
}
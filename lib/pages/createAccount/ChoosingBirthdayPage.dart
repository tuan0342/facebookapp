import 'package:facebook_app/my_widgets/my_app_bar.dart';
import 'package:facebook_app/my_widgets/my_date_picker.dart';
import 'package:facebook_app/my_widgets/my_editText.dart';
import 'package:facebook_app/my_widgets/my_filled_button.dart';
import 'package:facebook_app/my_widgets/my_text.dart';
import 'package:facebook_app/my_widgets/my_text_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChoosingBirthdayPage extends StatelessWidget {
  const ChoosingBirthdayPage({super.key});


  @override
  Widget build(BuildContext context) {
    void nextScreen() {
      context.push("/createAccount/termOfService");
    }

    return Scaffold(
      appBar: MyAppBar(title: "Ngày sinh"),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 36.0),
                    child: MyText(title: "Sinh nhật của bạn khi nào?", type: "title",),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
                    child: MyDatePicker(),
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
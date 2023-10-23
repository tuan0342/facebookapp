import 'package:facebook_app/my_widgets/my_app_bar.dart';
import 'package:facebook_app/my_widgets/my_filled_button.dart';
import 'package:facebook_app/my_widgets/my_text.dart';
import 'package:facebook_app/my_widgets/my_text_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ConfirmCodePage extends StatelessWidget {
  const ConfirmCodePage({super.key});


  @override
  Widget build(BuildContext context) {
    void nextScreen() {
      context.push("/authenticated");
    }

    return Scaffold(
      appBar: MyAppBar(title: "Xác nhận tài khoản"),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 36.0),
                    child: MyText(title: "Chúng tôi đã gủi SMS kèm mã tới 098 776 88 86", type: "label",),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: MyText(title: "Nhập mã gồm 5 chữ số từ SMS của bạn.", type: "label",),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center ,
                      children: [
                        MyText(title: "FB- ", type: "title",),
                        SizedBox(
                          width: 80,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 24.0),
                    child: MyFilledButton(title: "Xác nhận", isDisabled: false, cbFunction: nextScreen),
                  ),
                  SizedBox(
                    height: 24.0,
                    child: Divider(height: 0.2, color: Colors.blueGrey[500],)
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 0),
                    child: MyFilledButton(title: "Tôi không nhận được mã", isDisabled: false, cbFunction: nextScreen),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 12.0),
                    child: MyTextButton(title: "Đăng xuất", isDisabled: false, cbFunction: nextScreen),
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
import 'package:facebook_app/my_widgets/my_app_bar.dart';
import 'package:facebook_app/my_widgets/my_filled_button.dart';
import 'package:flutter/material.dart';

class LoginSecurityChangePassword extends StatefulWidget {
  const LoginSecurityChangePassword({super.key});

  @override
  State<LoginSecurityChangePassword> createState() => _LoginSecurityChangePasswordState();
}

class _LoginSecurityChangePasswordState extends State<LoginSecurityChangePassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const MyAppBar(title: "Đổi mật khẩu"),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(top: 20),
          color: const Color(0xffdadde2),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(color:Color.fromARGB(221, 177, 177, 177), spreadRadius: 1),
                  ],
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 280,
                      height: 40,
                      child: TextField(
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                          labelText: "Mật khẩu hiện tại"
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    SizedBox(
                      width: 280,
                      height: 40,
                      child: TextField(
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                          labelText: "Mật khẩu mới"
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    SizedBox(
                      width: 280,
                      height: 40,
                      child: TextField(
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                          labelText: "Gõ lại mật khẩu mới"
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15,),
              MyFilledButton(
                isDisabled: false,
                title: "Lưu thay đổi",
                cbFunction: (){},
                style: ButtonStyle(
                  minimumSize:
                    MaterialStateProperty.all(const Size(240, 50)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    )
                  )
                )
              ),
              const SizedBox(height: 15,),
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: MyFilledButton(
                      isDisabled: false,
                      title: "Hủy",
                      textStyle: const TextStyle(color: Colors.black),
                      style: FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Colors.black54),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        minimumSize: const Size(200, 50),
                        backgroundColor: Colors.transparent,
                      ),
                      cbFunction: (){}
                    ),
                  ),
                ),
              )
            ],
          )
        )
      ),
    );
  }
}
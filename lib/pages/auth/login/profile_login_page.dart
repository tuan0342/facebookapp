import 'package:facebook_app/my_widgets/my_filled_button.dart';
import 'package:facebook_app/my_widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// this page is show account logged in but logouted
class ProfileLoginPage extends StatelessWidget {
  const ProfileLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    // go to create account
    void createAccount() {
      context.push("/auth/register");
    }
    // login with unknown account (with both email and passoword)
    void loginOtherAccount() {
      context.push("/auth/logInUnknown");
    }

    // login with known account in this page, just need password
    void logIn() {
      // context.push("/auth/logInKnown");
    }

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/logo.png", width: 80, height: 80,),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16,24,16,0),
                    child: InkWell(
                      onTap: logIn,
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8), // Image border
                            child: SizedBox.fromSize(
                              size: const Size.fromRadius(30), // Image radius
                              child: Image.asset("assets/images/male_default_avatar.jpeg"),
                            ),
                          ),
                          Expanded(
                            child: Container(
                                alignment: Alignment.bottomLeft,
                                child: Container(
                                  padding:const  EdgeInsets.only(left: 8.0),
                                  child:const MyText(title: "Anh Hoang", type: "labelLarge"),
                                )
                            ),
                          ),
                          const InkWell(
                              splashColor: Colors.black,
                              child: Icon(Icons.more_vert, color: Colors.black,)
                          )
                        ],
                      )
                    )
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(top: 16.0, left: 16,),
                    child: InkWell(
                        onTap: loginOtherAccount,
                        splashColor: Colors.blue,
                        child: const Row(
                          children: [
                            Icon(Icons.add, color: Colors.blue,),
                            Text("Đăng nhập bằng tài khoản khác", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),)
                          ],
                        )
                    )
                  ),
                  Container(
                      alignment: Alignment.centerLeft,
                      padding:const EdgeInsets.only(top: 16.0, left: 16,),
                      child: InkWell(
                          onTap: () {},
                          splashColor: Colors.blue,
                          child: const Row(
                            children: [
                              Icon(Icons.search, color: Colors.blue,),
                              Text("Tìm tài khoản", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),)
                            ],
                          )
                      )
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding:const EdgeInsets.symmetric(vertical: 8),
            child: Align(
                alignment: Alignment.bottomCenter,
                child:                 MyFilledButton(
                    isDisabled: false,
                    title: "Đăng ký tài khoản mới",
                    cbFunction: createAccount,
                    style: ButtonStyle(
                        minimumSize:
                            MaterialStateProperty.all(const Size(200, 50)))),
            ),
          )
        ],
      ),
    );
  }
}
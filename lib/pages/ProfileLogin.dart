import 'package:facebook_app/my_widgets/my_app_bar.dart';
import 'package:facebook_app/my_widgets/my_editText.dart';
import 'package:facebook_app/my_widgets/my_filled_button.dart';
import 'package:facebook_app/my_widgets/my_text.dart';
import 'package:facebook_app/my_widgets/my_text_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileLoginPage extends StatelessWidget {
  const ProfileLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    void createAccount() {
      context.push("/createAccount");
    }
    void logIn() {
      context.push("/logIn");
    }
    void goHomeScreen(){
      context.push("/homeScreen");
    }

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/logo.png", width: 40, height: 40,),
                  Padding(
                    padding: EdgeInsets.fromLTRB(16,24,16,0),
                    child: InkWell(
                      onTap: logIn,
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8), // Image border
                            child: SizedBox.fromSize(
                              size: Size.fromRadius(30), // Image radius
                              child: Image.asset("assets/images/male_default_avatar.jpeg"),
                            ),
                          ),
                          Expanded(
                            child: Container(
                                alignment: Alignment.bottomLeft,
                                child: Container(
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: MyText(title: "Anh Hoang", type: "labelLarge"),
                                )
                            ),
                          ),
                          InkWell(
                              splashColor: Colors.black,
                              child: Container(
                                child: const Icon(Icons.more_vert, color: Colors.black,),)
                          )
                        ],
                      )
                    )
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(top: 16.0, left: 16,),
                    child: InkWell(
                        onTap: () {},
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
                      padding: EdgeInsets.only(top: 16.0, left: 16,),
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
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(top: 16.0, left: 16,),
                    child: InkWell(
                      onTap: goHomeScreen,
                      child: const Row(
                        children:[
                          Icon(Icons.add_home, color: Colors.blue),
                          Text("Home page", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),)
                        ]
                      )
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Align(
                alignment: Alignment.bottomCenter,
                child: MyFilledButton(isDisabled: false, title: "Tạo tài khoản Facebook mới", cbFunction: createAccount,)
            ),
          )
        ],
      ),
    );
  }
}
import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook_app/my_widgets/my_filled_button.dart';
import 'package:facebook_app/my_widgets/my_text.dart';
import 'package:facebook_app/services/app_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

// this page is show account logged in but logouted
class ProfileLoginPage extends StatelessWidget {
  const ProfileLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _appService = Provider.of<AppService>(context, listen: false);
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
      context.push("/auth/logInKnown");
    }

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                            borderRadius: BorderRadius.circular(10), // Image border
                            child: SizedBox.fromSize(
                              size: const Size.fromRadius(30), // Image radius
                              child: Image.asset("assets/images/af_logo.png"),
                            ),
                          ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
                      child: InkWell(
                          onTap: logIn,
                          child: Row(
                            children: [
                              CachedNetworkImage(
                                  imageUrl: _appService.avatar,
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                        width: 70,
                                        height: 70,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover)),
                                      ),
                                  placeholder: (context, url) => Container(
                                        height: 70,
                                        width: 70,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            image: const DecorationImage(
                                                image: AssetImage(
                                                    "assets/images/male_default_avatar.jpeg"),
                                                fit: BoxFit.cover)),
                                      ),
                                  errorWidget: (context, url, error) =>
                                      Container(
                                        height: 70,
                                        width: 70,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            image: const DecorationImage(
                                                image: AssetImage(
                                                    "assets/images/male_default_avatar.jpeg"),
                                                fit: BoxFit.cover)),
                                      )),
                              Expanded(
                                child: Container(
                                    alignment: Alignment.bottomLeft,
                                    child: Container(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: MyText(
                                          title: _appService.username,
                                          type: "labelLarge"),
                                    )),
                              ),
                              const InkWell(
                                  splashColor: Colors.black,
                                  child: Icon(
                                    Icons.more_vert,
                                    color: Colors.black,
                                  ))
                            ],
                          ))),
                  Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(
                        top: 16.0,
                        left: 16,
                      ),
                      child: InkWell(
                          onTap: loginOtherAccount,
                          splashColor: Colors.blue,
                          child: const Row(
                            children: [
                              Icon(
                                Icons.add,
                                color: Colors.blue,
                              ),
                              Text(
                                "Đăng nhập bằng tài khoản khác",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ))),
                  Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(
                        top: 16.0,
                        left: 16,
                      ),
                      child: InkWell(
                          onTap: () {},
                          splashColor: Colors.blue,
                          child: const Row(
                            children: [
                              Icon(
                                Icons.search,
                                color: Colors.blue,
                              ),
                              Text(
                                "Tìm tài khoản",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ))),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: MyFilledButton(
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

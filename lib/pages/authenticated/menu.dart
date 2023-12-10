import 'dart:io';

import 'package:facebook_app/models/menu_model.dart';
import 'package:facebook_app/my_widgets/my_dropdown.dart';
import 'package:facebook_app/services/app_service.dart';
import 'package:facebook_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  List<MenuItem> supportList = [
    const MenuItem(
        icon: 'assets/images/rules_icon.png',
        title: 'Điều khoản & chính sách',
        route: '/authenticated/menu/termAndPolicies'),
  ];
  List<MenuItem> settingList = [
    const MenuItem(
        icon: 'assets/images/setting_icon.png',
        title: 'Cài đặt',
        route: '/authenticated/menu/setting'),
  ];

  @override
  Widget build(BuildContext context) {
    late AppService appService =
        Provider.of<AppService>(context, listen: false);
    final authService = Provider.of<AuthService>(context, listen: false);

    return SafeArea(
        child: Container(
      color: const Color(0xFFf1f2f6),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: const Text("Menu",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24)),
                  ),
                  TextButton(
                    onPressed: () {
                      context.push('/authenticated/personalPage/${appService.uidLoggedIn}');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(90),
                            child: Selector<AppService, String>(
                              selector: (_, notifier) => notifier.avatar,
                              builder: (_, value, __) => Image.network(
                                appService.avatar,
                                height: 50,
                                width: 50,
                                fit: BoxFit.cover,
                              ),
                            )),
                        const SizedBox(
                          width: 12,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                              child: Selector<AppService, String>(
                                  selector: (_, notifier) => notifier.username,
                                  builder: (_, value, __) => Text(value,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold))),
                            ),
                            const Text('Xem trang cá nhân của bạn',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 132, 132, 132))),
                          ],
                        )
                      ],
                    ),
                  ),
                  const Divider(color: Colors.black),
                  MyDropDown(
                      title: 'Trợ giúp & hỗ trợ',
                      iconOfTitle: 'assets/images/question_icon.png',
                      arrayList: supportList),
                  const Divider(color: Colors.black),
                  MyDropDown(
                      title: 'Cài đặt & quyền riêng tư',
                      iconOfTitle: 'assets/images/setting_and_private_icon.png',
                      arrayList: settingList),
                  Container(
                    margin: const EdgeInsets.only(top: 20.0),
                    child: ElevatedButton(
                      onPressed: () {
                        authService.logOut(context: context);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white),
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(0, 11, 0, 11),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Đăng xuất",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      exit(0);
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.white),
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(0, 11, 0, 11),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Thoát",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}

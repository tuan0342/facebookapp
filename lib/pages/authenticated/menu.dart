import 'package:facebook_app/my_widgets/my_dropdown.dart';
import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: const Color.fromARGB(241,242,246,255),
        child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: const Text(
                      "Menu",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)
                    ),
                  ),
                  TextButton(
                    onPressed: (){}, 
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(90),
                            // child: Image.network(friend.avatar))),
                            child: Image.asset("assets/images/male_default_avatar.jpeg", height: 50, width: 50,)
                          ),
                        const SizedBox(
                          width: 12,
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 5), 
                              child: Text('Ngo Van Tuan', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
                            ),
                            Text('Xem trang cá nhân của bạn', style: TextStyle(color: Color.fromARGB(255, 132, 132, 132))),
                          ],
                        )
                      ],
                    )
                  ),
                  const Divider(color: Colors.black),
                  const MyDropDown(title: 'Cài đặt và quyền riêng tư',),
                ],
              ),
            )
          ],
        ),
        ),
      )
    );
  }
}
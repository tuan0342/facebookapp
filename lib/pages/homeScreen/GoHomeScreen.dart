
import 'package:flutter/material.dart';

class GoHomeScreen extends StatelessWidget {
  const GoHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:  Column(
        children: [
          Expanded(
              child: Center(
                child: Column(
                  children: [
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
                  ],
                ),
              )
          )

        ],
      ),
    );
  }



}
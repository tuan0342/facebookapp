import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const MyAppBar({super.key, required this.title});

  @override
  Size get preferredSize => const Size.fromHeight(56.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0.5),
          child: Container(
            color: Colors.grey,
            height: 0.4,
          ),
        ),
        automaticallyImplyLeading: true,
        elevation: 0.0, // for elevation
        titleSpacing: 0.0, // if you want remove title spacing with back button
        title: Text(title, style: TextStyle(color: Colors.black),),
        leading: Material(
          //Custom leading icon, such as back icon or other icon
          color: Colors.transparent,
          child: InkWell(
              onTap: () {
                context.pop();
              },
              splashColor: Colors.black,
              child: Container(
                  padding: const EdgeInsets.fromLTRB(12.0, 16.0, 16.0, 16.0),
                  child: const Icon(Icons.arrow_back_rounded, color: Colors.black,))),
        ));
  }
}
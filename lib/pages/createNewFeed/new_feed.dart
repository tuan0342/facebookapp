import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NewFeed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                // SizedBox(
                //     height: 18.0,
                //     width: 18.0,
                //     child: IconButton(
                //       onPressed: (){
                //         Navigator.pop(context);                      },
                //       padding: EdgeInsets.all(0.0),
                //       icon: Icon(Icons.arrow_back),
                //     )
                // ),
                // Text(
                //   "Tạo bài viết",
                //   style: TextStyle(fontSize: 20),
                // ),
                // ElevatedButton(onPressed: () {}, child: Text("Đăng"))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

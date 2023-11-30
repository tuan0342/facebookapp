import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NewFeed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              child: Row(
                children: [
                  IconButton(
                      onPressed: (){
                    Navigator.pop(context);
                  },
                      icon: Icon(Icons.arrow_back)
                  ),
                  Text("Tạo bài viết"),
                  OutlinedButton(
                      onPressed: (){},
                      child: const Text("ĐĂNG",
                      style: TextStyle(
                        color: Colors.black
                      ),
                      ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide.none
                    ),
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

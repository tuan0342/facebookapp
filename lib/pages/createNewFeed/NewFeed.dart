import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewFeed extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            child: Row(
              children: [
                IconButton(
                    onPressed: (){},
                    icon: const Icon(Icons.arrow_back)
                ),
                Text("Tạo bài viết"),
                ElevatedButton(
                    onPressed: () {},
                    child: Text("Đăng")
                )
              ],

            ) ,
          ),

          Container(),
          Container()


        ],
      ),

    );
  }

}
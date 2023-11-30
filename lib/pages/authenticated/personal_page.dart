import 'package:facebook_app/my_widgets/my_app_bar.dart';
import 'package:flutter/material.dart';

class PersonalPage extends StatefulWidget {
  const PersonalPage({super.key});

  @override
  State<PersonalPage> createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const MyAppBar(title: "Trang cá nhân"),
      body: Container(
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: <Widget>[
                // const SizedBox(
                //   height: 240,
                // ),
                Container(
                  height: 240,
                  // color: Colors.amber,
                ),
                Positioned(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage("https://mcdn.coolmate.me/image/October2023/nhan-vat-doraemon-3012_329.jpg"),
                      ),
                    ),
                  ),  
                ),
                const Positioned(
                  top: 130,
                  left: 10,
                  child: CircleAvatar(
                    radius: 50.0,
                    backgroundImage: NetworkImage(
                        'https://mcdn.coolmate.me/image/October2023/nhan-vat-doraemon-3012_329.jpg'),
                  ),
                ),
              ],
            ),

            // Container(
            //   padding: EdgeInsets.all(16.0),
            //   child: Row(
            //     children: [
            //       CircleAvatar(
            //         radius: 50.0,
            //         backgroundImage: NetworkImage(
            //             'https://example.com/your_profile_picture.jpg'),
            //       ),
            //       SizedBox(width: 16.0),
            //       Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Text(
            //             'Your Name',
            //             style: TextStyle(
            //               fontSize: 20.0,
            //               fontWeight: FontWeight.bold,
            //             ),
            //           ),
            //           Text('Location, Job, etc.'),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
            // User Posts
            // Container(
            //   padding: EdgeInsets.all(16.0),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(
            //         'Posts',
            //         style: TextStyle(
            //           fontSize: 24.0,
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //       // Add your post widgets here
            //       // Example:
            //       PostWidget('Post 1'),
            //       PostWidget('Post 2'),
            //       // ...
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}


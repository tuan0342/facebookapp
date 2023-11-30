import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook_app/models/profile_model.dart';
import 'package:facebook_app/my_widgets/my_app_bar.dart';
import 'package:facebook_app/services/user_service.dart';
import 'package:flutter/material.dart';

class PersonalPage extends StatefulWidget {
  const PersonalPage({super.key});

  @override
  State<PersonalPage> createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  late Profile profile = Profile(id: "", username: "", created: "", description: "", 
              avatar: "", imageCover: "", link: "", address: "", city: "", country: "", listing: "", 
              isFriend: "", online: "", coins: "");

  @override
  void initState() {
    super.initState();
    getProfile();
  }

  void getProfile() async {
    final profile_ = await UserService().getProfile(context: context);
    setState(() {
      profile = profile_;
    });
  }
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
                  child: CachedNetworkImage(
                    imageUrl: profile.imageCover,
                    imageBuilder: (context, imageProvider) => Container(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(image: imageProvider, fit: BoxFit.contain),
                        // border: Border.all(width: 1)
                      ),
                    ),
                    placeholder: (context, url) => Container(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      decoration: const BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                          image: AssetImage("assets/images/male_default_avatar.jpeg"),
                          fit: BoxFit.cover
                        )
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        shape: BoxShape.rectangle, 
                        image: DecorationImage(
                        image: AssetImage("assets/images/male_default_avatar.jpeg"),
                        fit: BoxFit.cover)
                      ),
                    )
                  ),
                ),
                // const Positioned(
                //   top: 130,
                //   left: 10,
                //   child: CircleAvatar(
                //     radius: 50.0,
                //     backgroundImage: NetworkImage(
                //         'https://mcdn.coolmate.me/image/October2023/nhan-vat-doraemon-3012_329.jpg'),
                //   ),
                // ),
                Positioned(
                  top: 130,
                  left: 10,
                  child: CachedNetworkImage(
                    imageUrl: profile.avatar,
                    imageBuilder: (context, imageProvider) => Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(image: imageProvider, fit: BoxFit.contain),
                        border: Border.all(width: 1)
                      ),
                    ),
                    placeholder: (context, url) => Container(
                      width: 100,
                      height: 100,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage("assets/images/male_default_avatar.jpeg"),
                          fit: BoxFit.cover
                        )
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      height: 100,
                      width: 100,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle, 
                        image: DecorationImage(
                          image: AssetImage("assets/images/male_default_avatar.jpeg"),
                          fit: BoxFit.cover
                        )
                      ),
                    )
                  ),
                )
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


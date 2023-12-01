import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook_app/models/profile_model.dart';
import 'package:facebook_app/my_widgets/my_app_bar.dart';
import 'package:facebook_app/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PersonalPage extends StatefulWidget {
  const PersonalPage({super.key});

  @override
  State<PersonalPage> createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  late Profile profile = const Profile(id: "", username: "", created: "", description: "", 
              avatar: "", imageCover: "", link: "", address: "", city: "", country: "", listing: "", 
              isFriend: "", online: "", coins: "");
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getProfile();
  }

  void getProfile() async {
    setState(() {
      isLoading = true;
    });
    final profile_ = await UserService().getProfile(context: context);
    setState(() {
      profile = profile_;
      isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const MyAppBar(title: "Trang cá nhân"),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              child: 
                isLoading ? NewsCardSkelton()
                : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: <Widget>[
                        Container(
                          height: 240,
                        ),
                        //cover image
                        Positioned(
                          child: CachedNetworkImage(
                            imageUrl: profile.imageCover,
                            imageBuilder: (context, imageProvider) => Container(
                              width: MediaQuery.of(context).size.width,
                              height: 200,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                image: DecorationImage(image: imageProvider, fit: BoxFit.contain),
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
                        //avatar
                        Positioned(
                          top: 90,
                          left: 10,
                          child: CachedNetworkImage(
                            imageUrl: profile.avatar,
                            imageBuilder: (context, imageProvider) => Container(
                              width: 140,
                              height: 140,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(image: imageProvider, fit: BoxFit.contain),
                                border: Border.all(width: 3, color: Colors.white)
                              ),
                            ),
                            placeholder: (context, url) => Container(
                              width: 140,
                              height: 140,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage("assets/images/male_default_avatar.jpeg"),
                                  fit: BoxFit.cover
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              height: 140,
                              width: 140,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle, 
                                image: DecorationImage(
                                  image: AssetImage("assets/images/male_default_avatar.jpeg"),
                                  fit: BoxFit.cover
                                )
                              ),
                            )
                          ),
                        ),
                        //icon change
                        Positioned(
                          top: 170,
                          left: 100,
                          child: ElevatedButton(
                            onPressed: (){},
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              padding: const EdgeInsets.all(10),
                              backgroundColor: const Color.fromARGB(255, 219, 219, 219), // <-- Button color
                              foregroundColor: const Color.fromARGB(255, 133, 133, 133), // <-- Splash color
                            ),
                            child: const Icon(Icons.camera_alt, color: Colors.black),
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(profile.username, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600, ),),
                                Text(profile.description, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600, ),),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.only(
                                          top: profile.description.isNotEmpty ? 10.0 : 0.0, 
                                          right: 10
                                        ),
                                        height: 40,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            context.push('/authenticated/personalPage/editPersonalInfoPage', extra: profile);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color(0xFFe5e6eb)
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(right: 5), 
                                                  child: Icon(Icons.edit, color: Colors.black, size: 20, ),
                                                ),
                                                Text(
                                                  "Chỉnh sửa trang cá nhân", 
                                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: profile.description.isNotEmpty ? 10.0 : 0.0, ),
                                      height: 40,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          context.push('/authenticated/personalPage/settingPersonalPage', extra: profile);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(0xFFe5e6eb)
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                          child: Icon(Icons.more_horiz, color: Colors.black, size: 28),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )
                          )
                        ),
                      ],
                    ),

                    Container(
                      height: 20,
                      margin: const EdgeInsets.only(top: 10),
                      color: const Color(0xFFc9ccd1),
                    ),

                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Chi tiết', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),),
                          const SizedBox(height: 20,),
                          Visibility(
                            visible: !profile.address.isNotEmpty,
                            child: Row(
                              children: [
                                const Icon(Icons.location_on, color: Colors.black54, size: 28),
                                const SizedBox(width: 10,),
                                Text('Đến từ ${profile.address}', style: const TextStyle(fontSize: 18),)
                              ],
                            ),
                          ),
                          const SizedBox(height: 10,),
                          Visibility(
                            visible: !profile.city.isNotEmpty,
                            child: Row(
                              children: [
                                const Icon(Icons.home, color: Colors.black54, size: 28),
                                const SizedBox(width: 10,),
                                Text('Sống tại ${profile.address}', style: const TextStyle(fontSize: 18),)
                              ],
                            ),
                          ),
                          const SizedBox(height: 10,),
                          Visibility(
                            visible: profile.listing.isNotEmpty,
                            child: Row(
                              children: [
                                const Icon(Icons.rss_feed, color: Colors.black54, size: 26),
                                const SizedBox(width: 10,),
                                Text('Có ${profile.listing} người theo dõi', style: const TextStyle(fontSize: 18),)
                              ],
                            ),
                          ),
                        ]
                      ),
                    )
                    
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
          ),
        ],
      )
    );
  }

  Widget NewsCardSkelton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: <Widget>[
            Container(
              height: 240,
            ),
            //cover image
            Positioned(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            Positioned(
              top: 90,
              left: 10,
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
            Positioned(
              top: 170,
              left: 100,
              child: ElevatedButton(
                onPressed: (){},
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(10),
                  backgroundColor: const Color.fromARGB(255, 219, 219, 219), // <-- Button color
                  foregroundColor: const Color.fromARGB(255, 133, 133, 133), // <-- Splash color
                ),
                child: const Icon(Icons.camera_alt, color: Colors.black),
              ),
            ),
          ],
        ),
      ],
    );
}
}


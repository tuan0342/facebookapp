import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook_app/models/post_model.dart';
import 'package:facebook_app/models/profile_model.dart';
import 'package:facebook_app/my_widgets/feed_box.dart';
import 'package:facebook_app/my_widgets/images_dialog.dart';
import 'package:facebook_app/my_widgets/my_app_bar.dart';
import 'package:facebook_app/services/app_service.dart';
import 'package:facebook_app/services/feed_service.dart';
import 'package:facebook_app/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

const COUNT = "10";

class PersonalPage extends StatefulWidget {
  const PersonalPage({super.key});

  @override
  State<PersonalPage> createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  late Profile profile = const Profile(
      id: "",
      username: "",
      created: "",
      description: "",
      avatar: "",
      imageCover: "",
      link: "",
      address: "",
      city: "",
      country: "",
      listing: "",
      isFriend: "",
      online: "",
      coins: "");
  bool isLoading = false;
  late File selectedImages = File(''); // List of selected image
  final picker = ImagePicker(); // Instance of Image picker
  final ScrollController controller = ScrollController();
  int lastId = 0;
  int countPost = 0;
  late List<Post> feeds;

  @override
  void initState() {
    super.initState();
    getProfile();
    controller.addListener(handleScrolling);
    getNewFeed();
  }

  void handleScrolling() {
    if (controller.position.pixels == controller.position.maxScrollExtent) {
      getMoreNewFeed();
    }
  }

  void getNewFeed() async {
    feeds = await FeedService().getPersonalFeeds(context: context, campaign_id: "1", count: COUNT, 
      in_campaign: "1", index: "0", last_id: lastId.toString(), latitude: "1.0", longitude: "1.0");

    setState(() {
      lastId = feeds[feeds.length - 1].id;
      countPost = countPost + feeds.length;
    });
  }

  void getMoreNewFeed() async {

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

  void clickKudosButton(int index) {
    setState(() {
      if (feeds[index].isFelt == 0) {
        feeds[index].feel += 1;
        feeds[index].isFelt = 1;
      } else {
        feeds[index].feel -= 1;
        feeds[index].isFelt = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const MyAppBar(title: "Trang cá nhân"),
        body: 
        Container(
          height: double.infinity,
          child: SingleChildScrollView(
            controller: controller,
            child: isLoading
              ? NewsCardSkelton()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PersonalImages(),
                    PersonalInfo(),
                    Container(
                      height: 20,
                      margin: const EdgeInsets.only(top: 10),
                      color: const Color(0xFFc9ccd1),
                    ),
                    PersonalDetail(),
                    Container(
                      height: 20,
                      margin: const EdgeInsets.only(top: 10),
                      color: const Color(0xFFc9ccd1),
                    ),     

                    PersonalNewFeed(),
                  ],
                ),
          ),
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
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(10),
                  backgroundColor: const Color.fromARGB(
                      255, 219, 219, 219), // <-- Button color
                  foregroundColor: const Color.fromARGB(
                      255, 133, 133, 133), // <-- Splash color
                ),
                child: const Icon(Icons.camera_alt, color: Colors.black),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget PersonalImages() {
    return Stack(
      children: <Widget>[
        Container(
          height: 240,
        ),
        //cover image
        Positioned(
          child: ButtonTheme(
            height: 200,
            minWidth: MediaQuery.of(context).size.width,
            child: TextButton(
              onPressed: () {
                List<String> images;
                if (profile.imageCover == '') {
                  images = [
                    "assets/images/male_default_avatar.jpeg"
                  ];
                } else {
                  images = [profile.imageCover];
                }
                _showPopupList(context, images);
              },
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
              child: CachedNetworkImage(
                imageUrl: profile.imageCover,
                imageBuilder:
                  (context, imageProvider) =>
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      decoration:
                          selectedImages.path == ''
                            ? BoxDecoration(
                                shape: BoxShape.rectangle,
                                image: DecorationImage(
                                  image:imageProvider,
                                  fit: BoxFit.cover
                                ),
                              )
                            : BoxDecoration(
                                shape: BoxShape.rectangle,
                                // image: DecorationImage(
                                //   image: AssetImage(selectedImages.path),
                                //   fit: BoxFit.cover
                                // ),
                                image: DecorationImage(
                                  image: FileImage(selectedImages),
                                  fit: BoxFit.cover
                                ),
                              ),
                    ),
                    placeholder: (context, url) =>
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        decoration: selectedImages.path == ''
                          ? const BoxDecoration(
                              shape: BoxShape.rectangle,
                              image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/male_default_avatar.jpeg"),
                                fit: BoxFit.cover
                              ),
                            )
                          : BoxDecoration(
                              shape: BoxShape.rectangle,
                              // image: DecorationImage(
                              //   image: AssetImage(selectedImages.path),
                              //   fit: BoxFit.cover
                              // ) ,
                              image: DecorationImage(
                                image: FileImage(selectedImages),
                                fit: BoxFit.cover
                              ),
                            ),
                      ),
                    errorWidget: (context, url, error) =>
                      Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        decoration: selectedImages.path == ''
                          ? const BoxDecoration(
                              shape: BoxShape.rectangle,
                              image: DecorationImage(
                                image: AssetImage("assets/images/male_default_avatar.jpeg"),
                                fit: BoxFit.cover
                              ),
                            )
                          : BoxDecoration(
                              shape: BoxShape.rectangle,
                              // image: DecorationImage(
                              //   image: AssetImage(selectedImages.path),
                              //   fit: BoxFit.cover
                              // ),
                              image: DecorationImage(
                                image: FileImage(selectedImages),
                                fit: BoxFit.cover
                              ),
                            ),
                      )
                    ),
              )
            ),
        ),
        //avatar
        Positioned(
          top: 90,
          left: 10,
          child: ButtonTheme(
            child: TextButton(
              onPressed: () {
                List<String> images;
                if (profile.avatar == '') {
                  images = [
                    "assets/images/male_default_avatar.jpeg"
                  ];
                } else {
                  images = [profile.avatar];
                }
                _showPopupList(context, images);
              },
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
              child: Selector<AppService, String>(
                selector: (_, notifier) => notifier.avatar,
                builder: (_, value, __) =>
                  CachedNetworkImage(
                      imageUrl: value,
                      imageBuilder: (context, imageProvider) =>
                        Container(
                          width: 140,
                          height: 140,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover),
                            border: Border.all(
                              width: 3,
                              color: Colors.white)
                          ),
                        ),
                      placeholder: (context, url) =>
                        Container(
                          width: 140,
                          height: 140,
                          decoration:const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage("assets/images/male_default_avatar.jpeg"),
                              fit: BoxFit.cover),
                          ),
                        ),
                      errorWidget:
                        (context, url, error) =>
                          Container(
                            height: 140,
                            width: 140,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: AssetImage("assets/images/male_default_avatar.jpeg"),
                                  fit: BoxFit.cover)
                            ),
                        )
                    ),
                  )
            )
          )
        ),
        //icon change
        Positioned(
          top: 170,
          left: 100,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(0),
              backgroundColor: const Color.fromARGB(255, 219, 219, 219), // <-- Button color
              foregroundColor: const Color.fromARGB(255, 133, 133, 133), // <-- Splash color
            ),
            child: IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          TextButton(
                            onPressed: () {
                              getAvatarImage(ImageSource.camera);
                              Navigator.pop(context);
                            },
                            child: const Row(
                              children: [
                                Icon(Icons.camera_alt, size: 32, color: Colors.black, ),
                                SizedBox(width: 10),
                                Text("Chụp ảnh", style: TextStyle(fontSize: 16, color:Colors.black),)
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextButton(
                            onPressed: () {
                              getAvatarImage(ImageSource.gallery);
                              Navigator.pop(context);
                            },
                            child: const Row(
                              children: [
                                Icon(Icons.library_books, size: 32, color: Colors.black, ),
                                SizedBox(width: 10),
                                Text("Thư viện", style: TextStyle(fontSize: 16, color:Colors.black))
                              ],
                            ),
                          ),
                          const SizedBox(height: 16,),
                        ],
                      ),
                    );
                  },
                );
              },
              icon: const Icon(Icons.camera_alt,color: Colors.black)),
          ),
        ),
      ],
    );
  }

  Widget PersonalInfo() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(profile.username, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
                Text(profile.description,style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(top: profile.description.isNotEmpty ? 10.0 : 0.0, right: 10),
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () {
                              context.push('/authenticated/personalPage/editPersonalInfoPage', extra: profile);
                            },
                            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFe5e6eb)),
                            child: const Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(padding: EdgeInsets.only(right: 5),
                                    child: Icon(Icons.edit,color: Colors.black,size: 20),
                                  ),
                                  Text("Chỉnh sửa trang cá nhân", style: TextStyle(
                                    fontSize: 16,
                                    fontWeight:FontWeight.bold,
                                    color: Colors.black)
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: profile.description.isNotEmpty? 10.0 : 0.0,),
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            context.push('/authenticated/personalPage/settingPersonalPage',extra: profile);
                          },
                          style: ElevatedButton.styleFrom(backgroundColor:const Color(0xFFe5e6eb)),
                          child: const Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Icon(
                              Icons.more_horiz,
                              color: Colors.black,
                              size: 28
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )
            ),
          ),
      ],
    );
  }

  Widget PersonalDetail() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Chi tiết',
            style: TextStyle(fontSize: 24,fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 20),
          Visibility(
            visible: !profile.address.isNotEmpty,
            child: Row(
              children: [
                const Icon(Icons.location_on, color: Colors.black54, size: 28),
                const SizedBox(width: 10),
                Text('Đến từ ${profile.address}', style: const TextStyle(fontSize: 18),)
              ],
            ),
          ),
          const SizedBox(height: 10),
          Visibility(
            visible: !profile.city.isNotEmpty,
            child: Row(
              children: [
                const Icon(Icons.home, color: Colors.black54, size: 28),
                const SizedBox(width: 10),
                Text('Sống tại ${profile.address}', style: const TextStyle(fontSize: 18),)
              ],
            ),
          ),
          const SizedBox(height: 10),
          Visibility(
            visible: profile.listing.isNotEmpty,
            child: Row(
              children: [
                const Icon(Icons.rss_feed, color: Colors.black54, size: 26),
                const SizedBox(width: 10),
                Text('Có ${profile.listing} người theo dõi', style: const TextStyle(fontSize: 18),)
              ],
            ),
          ),
        ]
      ),
    );
  }

  Widget PersonalNewFeed() {
    return ListView.builder(
      // padding: const EdgeInsets.only(left: 10, right: 10),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: feeds.length,
      itemBuilder: (context, index) => FeedBox(
        post: feeds[index],
        ontap: () => clickKudosButton(index),
      ),
    );
  }

  @override
  void dispose() {
    controller.removeListener(handleScrolling);
    super.dispose();
  }

  void _showPopupList(BuildContext context, List<String> images) async {
    final result = await showDialog(
        context: context,
        builder: (_) => ImagesDialog(images: images, index: 0,));
    debugPrint(result);
  }

  Future<void> getAvatarImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(
        source: source, imageQuality: 100, maxHeight: 10000, maxWidth: 10000);
    if (pickedFile != null) {
      final file = File(pickedFile.path);

      // ignore: use_build_context_synchronously
      await UserService().changeUsernameOrAvt(
          context: context, fullName: profile.username, avatar: file);
    } else {
      debugPrint("no change");
    }
  }
}

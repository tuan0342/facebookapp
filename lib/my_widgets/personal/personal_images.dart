import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook_app/models/profile_model.dart';
import 'package:facebook_app/my_widgets/images_dialog.dart';
import 'package:facebook_app/services/app_service.dart';
import 'package:facebook_app/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class PersonalImages extends StatelessWidget {
  final Profile profile;
  final picker = ImagePicker();
  final BuildContext contextPage;
  PersonalImages({super.key, required this.profile, required this.contextPage});

  @override
  Widget build(BuildContext context) {
    final appService = Provider.of<AppService>(context, listen: false);

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
                    images = ["assets/images/male_default_avatar.jpeg"];
                  } else {
                    images = [profile.imageCover];
                  }
                  _showPopupList(context, images);
                },
                style: TextButton.styleFrom(padding: EdgeInsets.zero),
                child: CachedNetworkImage(
                    imageUrl: profile.imageCover,
                    imageBuilder: (context, imageProvider) => Container(
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover),
                        )),
                    placeholder: (context, url) => Container(
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        decoration: const BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                              image: AssetImage(
                                  "assets/images/male_default_avatar.jpeg"),
                              fit: BoxFit.cover),
                        )),
                    errorWidget: (context, url, error) => Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                              image: AssetImage(
                                  "assets/images/male_default_avatar.jpeg"),
                              fit: BoxFit.cover),
                        ))),
              )),
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
                        images = ["assets/images/male_default_avatar.jpeg"];
                      } else {
                        images = [profile.avatar];
                      }
                      _showPopupList(context, images);
                    },
                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                    child: Selector<AppService, String>(
                      // selector: (_, notifier) => notifier.avatar,
                      selector: (_, notifier) => profile.avatar,
                      builder: (_, value, __) => CachedNetworkImage(
                          imageUrl: value,
                          imageBuilder: (context, imageProvider) => Container(
                                width: 140,
                                height: 140,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover),
                                    border: Border.all(
                                        width: 3, color: Colors.white)),
                              ),
                          placeholder: (context, url) => Container(
                                width: 140,
                                height: 140,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/male_default_avatar.jpeg"),
                                      fit: BoxFit.cover),
                                ),
                              ),
                          errorWidget: (context, url, error) => Container(
                                height: 140,
                                width: 140,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/male_default_avatar.jpeg"),
                                        fit: BoxFit.cover)),
                              )),
                    )))),
        //icon change
        appService.uidLoggedIn == profile.id
            ? Positioned(
                top: 170,
                left: 100,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(0),
                    backgroundColor: const Color.fromARGB(
                        255, 219, 219, 219), // <-- Button color
                    foregroundColor: const Color.fromARGB(
                        255, 133, 133, 133), // <-- Splash color
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
                                      getAvatarImage(
                                          ImageSource.camera, contextPage);
                                      Navigator.pop(context);
                                    },
                                    child: const Row(
                                      children: [
                                        Icon(
                                          Icons.camera_alt,
                                          size: 32,
                                          color: Colors.black,
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          "Chụp ảnh",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      getAvatarImage(
                                          ImageSource.gallery, contextPage);
                                      Navigator.pop(context);
                                    },
                                    child: const Row(
                                      children: [
                                        Icon(
                                          Icons.library_books,
                                          size: 32,
                                          color: Colors.black,
                                        ),
                                        SizedBox(width: 10),
                                        Text("Thư viện",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black))
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      icon: const Icon(Icons.camera_alt, color: Colors.black)),
                ),
              )
            : const SizedBox(),
      ],
    );
  }

  void _showPopupList(BuildContext context, List<String> images) async {
    await showDialog(
        context: context,
        builder: (_) => ImagesDialog(
              images: images,
              index: 0,
            ));
  }

  Future<void> getAvatarImage(ImageSource source, BuildContext context) async {
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

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook_app/models/profile_model.dart';
import 'package:facebook_app/util/common.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditAvatar extends StatefulWidget {
  final Profile profile;
  final BuildContext contextPage;
  final File fileAvatar;
  final void Function(String) changeFileAvatar;
  const EditAvatar(
      {super.key,
      required this.profile,
      required this.fileAvatar,
      required this.contextPage,
      required this.changeFileAvatar});

  @override
  State<EditAvatar> createState() => _EditAvatarState();
}

class _EditAvatarState extends State<EditAvatar> {
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Text(
              'Ảnh đại diện',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const Spacer(),
            TextButton(
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
                              getAvatarImage(ImageSource.camera, context);
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
                                      fontSize: 16, color: Colors.black),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextButton(
                            onPressed: () {
                              getAvatarImage(ImageSource.gallery, context);
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
                                        fontSize: 16, color: Colors.black))
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
              child: const Text(
                'Chỉnh sửa',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.blue),
              ),
            ),
          ],
        ),
        ButtonTheme(
            height: 140,
            minWidth: 140,
            child: TextButton(
              onPressed: () {
                showPopupList(
                    context: context, images: [widget.fileAvatar.path]);
              },
              child: CachedNetworkImage(
                  imageUrl: widget.profile.avatar,
                  imageBuilder: (context, imageProvider) => Container(
                        width: 140,
                        height: 140,
                        decoration: widget.fileAvatar.path == ''
                            ? BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover),
                                border:
                                    Border.all(width: 3, color: Colors.white))
                            : BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: FileImage(widget.fileAvatar),
                                    fit: BoxFit.cover),
                              ),
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
            )),
        const SizedBox(
          height: 10,
        ),
        const SizedBox(
          height: 1.0,
          width: double.infinity,
          child: DecoratedBox(
            decoration:
                BoxDecoration(color: Color.fromARGB(255, 220, 223, 226)),
          ),
        ),
      ],
    );
  }

  Future<void> getAvatarImage(ImageSource source, BuildContext context) async {
    final pickedFile = await picker.pickImage(
        source: source, imageQuality: 100, maxHeight: 10000, maxWidth: 10000);
    if (pickedFile != null) {
      widget.changeFileAvatar(pickedFile.path);

      // ignore: use_build_context_synchronously
      // await UserService().changeUsernameOrAvt(
      //     context: context, fullName: profile.username, avatar: file);
    } else {
      debugPrint("no change");
    }
  }
}

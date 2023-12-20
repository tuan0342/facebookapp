import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook_app/models/profile_model.dart';
import 'package:facebook_app/util/common.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditCover extends StatefulWidget {
  final Profile profile;
  final BuildContext contextPage;
  final File fileCover;
  final void Function(String) changeFileCover;
  const EditCover(
      {super.key,
      required this.profile,
      required this.fileCover,
      required this.contextPage,
      required this.changeFileCover});

  @override
  State<EditCover> createState() => _EditCoverState();
}

class _EditCoverState extends State<EditCover> {
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            const Text(
              'Ảnh bìa',
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
                              getCoverImage(ImageSource.camera, context);
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
                              getCoverImage(ImageSource.gallery, context);
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
            height: 200,
            minWidth: MediaQuery.of(context).size.width - 20,
            child: TextButton(
              onPressed: () {
                showPopupList(
                    context: context, images: [widget.fileCover.path.isNotEmpty ? widget.fileCover.path : widget.profile.imageCover]);
              },
              child: CachedNetworkImage(
                  imageUrl: widget.profile.imageCover,
                  imageBuilder: (context, imageProvider) => Container(
                        width: MediaQuery.of(context).size.width - 20,
                        height: 200,
                        decoration: widget.fileCover.path == ''
                            ? BoxDecoration(
                                shape: BoxShape.rectangle,
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(10),
                              )
                            : BoxDecoration(
                                shape: BoxShape.rectangle,
                                image: DecorationImage(
                                    image: FileImage(widget.fileCover),
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(10),
                              ),
                      ),
                  placeholder: (context, url) => Container(
                        width: MediaQuery.of(context).size.width - 20,
                        height: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: const DecorationImage(
                              image: AssetImage(
                                  "assets/images/male_default_avatar.jpeg"),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                  errorWidget: (context, url, error) => Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width - 20,
                        decoration: widget.fileCover.path == ''
                            ? BoxDecoration(
                                shape: BoxShape.rectangle,
                                image:  const DecorationImage(
                                    image: AssetImage(
                                        "assets/images/male_default_avatar.jpeg"),
                                    fit: BoxFit.cover)
                                  ,
                                borderRadius: BorderRadius.circular(10),
                              ) 
                            : BoxDecoration(
                                shape: BoxShape.rectangle,
                                image: DecorationImage(
                                    image: FileImage(widget.fileCover),
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(10),
                              ),
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

  Future<void> getCoverImage(ImageSource source, BuildContext context) async {
    final pickedFile = await picker.pickImage(
        source: source, imageQuality: 100, maxHeight: 10000, maxWidth: 10000);
    if (pickedFile != null) {
      widget.changeFileCover(pickedFile.path);
    } else {
      debugPrint("no change");
    }
  }
}

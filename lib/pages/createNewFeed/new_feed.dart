import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import '../../services/app_service.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class NewFeed extends StatefulWidget {
  State<NewFeed> createState() {
    return _NewFeedState();
  }
}

class _NewFeedState extends State<NewFeed> {

  void quitCreateNewFeed() {}

  List<File> selectedImages = [];
  final picker = ImagePicker();


  @override
  Widget build(BuildContext context) {
    final _appService = Provider.of<AppService>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(5),
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey))),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back)),
                    const Expanded(
                      child: Text("Tạo bài viết"),
                    ),
                    OutlinedButton(
                      onPressed: () {},
                      child: const Text(
                        "ĐĂNG",
                        style: const TextStyle(color: Colors.black),
                      ),
                      style: OutlinedButton.styleFrom(side: BorderSide.none),
                    ),
                  ],
                ),
              ),
              Container(
                  child: Row(
                children: [
                  CachedNetworkImage(
                    imageUrl: _appService.avatar,
                    imageBuilder: (context, imageProvider) => Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover)),
                    ),
                    placeholder: (context, url) => Container(
                      height: 100,
                      width: 100,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage(
                                  "assets/images/male_default_avatar.jpeg"),
                              fit: BoxFit.cover)),
                    ),
                    errorWidget: (context, url, error) => Container(
                      height: 100,
                      width: 100,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage(
                                  "assets/images/male_default_avatar.jpeg"),
                              fit: BoxFit.cover)),
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        _appService.username,
                        style: TextStyle(
                          color: Colors.grey[900],
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                      OutlinedButton(
                          onPressed: () {},
                          child: Row(
                            children: [
                              Icon(Icons.circle_rounded),
                              Text("Công khai")
                            ],
                          ))
                    ],
                  ),
                ],
              )),
              Container(
                child: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: "Bạn đang nghĩ gì?"),
                  style: TextStyle(fontSize: 24),
                ),
              ),


              Expanded(
                child: SizedBox(
                  width: 300.0,
                  child: selectedImages.isEmpty
                      ? const Center(child: Text('Sorry nothing selected!!'))
                      : GridView.builder(
                    itemCount: selectedImages.length,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    itemBuilder: (BuildContext context, int index) {
                      return Center(
                          child: kIsWeb
                              ? Image.network(selectedImages[index].path)
                              : Image.file(selectedImages[index]));
                    },
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
      persistentFooterButtons: [
        Expanded(
          child: Container(
            child: Text(
              "Thêm vào bài viết của bạn",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(
          width: 60,
        ),
        IconButton(
            onPressed: () {
              getImages();
            },
            icon: Icon(
              Icons.image,
              color: Colors.green,
            )),
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.emoji_emotions,
              color: Colors.amber,
            ))
      ],
    );
  }

  Future getImages() async {
    final pickedFile = await picker.pickMultiImage(
        imageQuality: 100, maxHeight: 1000, maxWidth: 1000);
    List<XFile> xfilePick = pickedFile;
    setState(
          () {
        if (xfilePick.isNotEmpty) {
          for (var i = 0; i < xfilePick.length; i++) {
            selectedImages.add(File(xfilePick[i].path));
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Nothing is selected')));
        }
      },
    );
  }
}

import 'package:facebook_app/my_widgets/my_image.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import '../../../services/app_service.dart';
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class NewFeed extends StatefulWidget {
  const NewFeed({super.key});

  @override
  State<NewFeed> createState() {
    return _NewFeedState();
  }
}

class _NewFeedState extends State<NewFeed> {
  List<File> selectedImages = [];
  final picker = ImagePicker();

  // late VideoPlayerController _controller;
  // late Future<void>   _initializeVideoPlayerFuture;
  // late File videoFile;

  TextEditingController described = TextEditingController();
  String status = "";

  bool addImage = false;

  // @override
  // void initState() {
  //   // Create and store the VideoPlayerController. The VideoPlayerController
  //   // offers several different constructors to play videos from assets, files,
  //   super.initState();
  // }
  //
  // @override
  // void dispose() {
  //   // Ensure disposing of the VideoPlayerController to free up resources.
  //   _controller.dispose();
  //
  //   super.dispose();
  // }

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
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Container(
                                            child: const Column(
                                              children: [
                                                Text(
                                                  "Bạn muốn hoàn thành bài viết của mình sau?",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18),
                                                ),
                                                Text(
                                                  "Lưu làm bản nháp hoặc bạn có thể tiếp tục chỉnh sửa.",
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                )
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Row(
                                              children: [
                                                Icon(
                                                  Icons.bookmark,
                                                  size: 32,
                                                  color: Colors.black,
                                                ),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                  children: [
                                                    Text(
                                                      "Lưu làm bản nháp",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color:
                                                              Colors.black),
                                                    ),
                                                    Text(
                                                      "Bạn sẽ nhận được thông báo về bản nháp",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.grey),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                            },
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons.delete_forever,
                                                  size: 32,
                                                  color: Colors.black,
                                                ),
                                                const SizedBox(
                                                  width: 15,
                                                ),
                                                Container(
                                                  child: const Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Bỏ bài viết",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons.verified,
                                                  size: 32,
                                                  color: Colors.lightBlue,
                                                ),
                                                const SizedBox(
                                                  width: 15,
                                                ),
                                                Container(
                                                  child: const Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Tiếp tục chỉnh sửa",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color: Colors
                                                                .lightBlue),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                        ]));
                              });
                        },
                        icon: const Icon(Icons.arrow_back)),
                    const Expanded(
                      child: Text("Tạo bài viết"),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        pushPost();
                      },
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
                  MyImage(imageUrl: _appService.avatar, width: 70, height: 70,),
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
                          child: const Row(
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
                  controller: described,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: this.selectedImages.isEmpty
                          ? "Bạn đang nghĩ gì?"
                          : "Hãy nói gì đó về bức ảnh này"),
                  style: TextStyle(fontSize: 24),
                ),
              ),
              addImage
                  ? Expanded(
                      child: SizedBox(
                        width: 300.0,
                        child: selectedImages.isEmpty
                            ? Container()
                            : GridView.builder(
                                itemCount: selectedImages.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2),
                                itemBuilder: (BuildContext context, int index) {
                                  return Center(
                                    child: kIsWeb
                                        ? Stack(
                                            children: <Widget>[
                                              Container(
                                                child: Image.network(
                                                    selectedImages[index].path),
                                              ),
                                              Positioned(
                                                top: 0,
                                                right: 0,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      selectedImages
                                                          .removeAt(index);
                                                    });
                                                  },
                                                  child: const Icon(Icons.close,
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ],
                                          )
                                        : Stack(
                                            children: <Widget>[
                                              Container(
                                                  child: Image.file(
                                                      selectedImages[index])),
                                              Positioned(
                                                top: 0,
                                                right: 0,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      selectedImages
                                                          .removeAt(index);
                                                    });
                                                  },
                                                  child: const Icon(Icons.close,
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ],
                                          ),
                                  );
                                },
                              ),
                      ),
                    )
                  :
                  //   Container(
                  //     child: Column(
                  //       children: <Widget>[
                  //     Visibility(
                  //     visible: _controller != null,
                  //       child: FutureBuilder(
                  //         future: _initializeVideoPlayerFuture,
                  //         builder: (context, snapshot) {
                  //           if (snapshot.connectionState == ConnectionState.done) {
                  //             // If the VideoPlayerController has finished initialization, use
                  //             // the data it provides to limit the aspect ratio of the video.
                  //             return AspectRatio(
                  //               aspectRatio: _controller.value.aspectRatio,
                  //               // Use the VideoPlayer widget to display the video.
                  //               child: VideoPlayer(_controller),
                  //             );
                  //           } else {
                  //             // If the VideoPlayerController is still initializing, show a
                  //             // loading spinner.
                  //             return Center(child: CircularProgressIndicator());
                  //           }
                  //         },
                  //       ),
                  //
                  //     ),
                  //     ]
                  //   ),
                  // )
                  Container()
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
        IconButton(
            onPressed: () {
              addImage = true;
              getImages();
            },
            icon: const Icon(
              Icons.image,
              color: Colors.green,
            )),
        IconButton(
            onPressed: () {
              addImage = false;
              // getVideo();
            },
            icon: const Icon(
              Icons.video_collection,
              color: Colors.green,
            )),
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.emoji_emotions,
              color: Colors.amber,
            ))
      ],
    );
  }

  Future getImages() async {
    final pickedFile = await picker.pickMultiImage();
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

  // Future getVideo() async {
  //   Future<File> _videoFile = await ImagePicker().pickVideo(source: ImageSource.gallery) as Future<File>;
  //   _videoFile.then((file) async {
  //     setState(() {
  //       videoFile = file;
  //       _controller = VideoPlayerController.file(videoFile);
  //
  //       // Initialize the controller and store the Future for later use.
  //       _initializeVideoPlayerFuture = _controller.initialize();
  //       // Use the controller to loop the video.
  //       _controller.setLooping(true);
  //     });
  //   });
  // }

  void pushPost() {}
}

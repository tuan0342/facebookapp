
import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook_app/services/feed_service.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../services/app_service.dart';
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() {
    return _NewFeedState();
  }
}

class _NewFeedState extends State<PostPage> {

  List<File> selectedImages = [];
  final picker = ImagePicker();

  VideoPlayerController? _controller;
  Future<void>? _initializeVideoPlayerFuture;
  late File videofile = File('');


  void initstate() {
    super.initState();
  }

  @override
  void dispose() {
    // ensure disposing of the videoplayercontroller to free up resources.
    _controller?.dispose();
    super.dispose();
  }

  TextEditingController describedController = TextEditingController();

  String status = "Hyped";
  bool addImage = false;

  @override
  Widget build(BuildContext context) {
    final appService = Provider.of<AppService>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(5),
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
                                            child:const Column(
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
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons.bookmark,
                                                  size: 32,
                                                  color: Colors.black,
                                                ),
                                                const SizedBox(
                                                  width: 15,
                                                ),
                                                Container(
                                                  child:const Column(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                    Text(
                                                      "Lưu làm bản nháp",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.black),
                                                    ),
                                                    Text(
                                                      "Bạn sẽ nhận được thông báo về bản nháp",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.grey),
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
                                              context.go('/authenticated');
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
                                                  child:const Column(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                    Text(
                                                      "Bỏ bài viết",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.black),
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
                                                  child:const Column(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,                                                    children: [
                                                    Text(
                                                      "Tiếp tục chỉnh sửa",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.lightBlue),
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
                        this.describedController.text != "" ? addPost(context) : null;
                      },
                      child: const Text(
                        "ĐĂNG",
                        style: TextStyle(
                            color: Colors.black),
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
                    imageUrl: appService.avatar,
                    imageBuilder: (context, imageProvider) => Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover)),
                    ),
                    placeholder: (context, url) => Container(
                      height: 80,
                      width: 80,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage(
                                  "assets/images/male_default_avatar.jpeg"),
                              fit: BoxFit.cover)),
                    ),
                    errorWidget: (context, url, error) => Container(
                      height: 80,
                      width: 80,
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
                      Container(
                        padding:EdgeInsets.only(top: 10),
                        child: Text(
                          appService.username,
                          style: TextStyle(
                            color: Colors.grey[900],
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                      OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            side: BorderSide.none
                          ),
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
                padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                child: TextField(
                  controller: describedController,
                  decoration: InputDecoration(
                      border: InputBorder.none, 
                      hintText: this.selectedImages.isEmpty && this.videofile.path == '' ? "Bạn đang nghĩ gì?" : this.selectedImages.isNotEmpty ? "Hãy nói gì đó về bức ảnh này" : "Hãy nói gì đó về video này"),
                  style: TextStyle(fontSize: 24),
                ),
              ),

              addImage ?
              Expanded(
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
                                                selectedImages.removeAt(index);
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
                                                selectedImages.removeAt(index);
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
              ) :
              Container(
                child: Column(
                  children: <Widget>[
                    Visibility(
                      visible: _controller != null,
                      child: FutureBuilder(
                        future: _initializeVideoPlayerFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
                            // If the VideoPlayerController has finished initialization, use
                            // the data it provides to limit the aspect ratio of the video.
                            return AspectRatio(
                              aspectRatio: _controller!.value.aspectRatio,
                              // Use the VideoPlayer widget to display the video.
                              child: VideoPlayer(_controller!),
                            );
                          } else {
                            // If the VideoPlayerController is still initializing, show a
                            // loading spinner.
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                      ),
                    ),

                  ],
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
        IconButton(
            onPressed: () {
              getImages();
              if (selectedImages.isNotEmpty) addImage = true;
            },
            icon:const Icon(
              Icons.image,
              color: Colors.green,
            )),
        IconButton(
            onPressed: () {
              getVideo();
              if (videofile.path != '') addImage = false;
            },
            icon:const Icon(
              Icons.video_collection,
              color: Colors.green,
            )),
        IconButton(
            onPressed: () {},
            icon:const Icon(
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

  Future getVideo() async {
    Future<File> _videofile =
    ImagePicker().pickVideo(source: ImageSource.gallery) as Future<File>;
    _videofile.then((file) async {
      setState(() {
        videofile = file;
        _controller = VideoPlayerController.file(videofile);

        // initialize the controller and store the future for later use.
        _initializeVideoPlayerFuture  = _controller!.initialize();

        // use the controller to loop the video.
        _controller?.setLooping(true);
      });
    });
  }

  void addPost(BuildContext context) async{
     await FeedService(context: context).addPost(
      context: context,
      imageList: selectedImages,
      video: null,
      described: describedController.text,
      status: status,
    );
  }

}

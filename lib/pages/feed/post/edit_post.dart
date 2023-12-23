
import 'dart:math';

import 'package:facebook_app/models/image_model.dart';
import 'package:facebook_app/models/post_model.dart';
import 'package:facebook_app/pages/feed/post/emotion.dart';
import 'package:facebook_app/pages/feed/post/list_image.dart';
import 'package:facebook_app/pages/feed/post/video_player_file.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../my_widgets/my_image.dart';
import '../../../services/app_service.dart';
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class EditPost extends StatefulWidget {

  final Post postData;
  const EditPost({super.key,required this.postData});

  @override
  State<EditPost> createState() {
    return _EditPostState();
  }
}

class _EditPostState extends State<EditPost> {
  final ImagePicker picker = ImagePicker();
  List<File> selectedImages = [];
  File? videoFile;
  TextEditingController describedController = TextEditingController();
  String status = "";
  set string(String value) => setState(() => status = value);
  bool addImage = false;

  @override
  void initState() {
    super.initState();
    describedController.text = widget.postData.described ;
    status = widget.postData.status;
    debugPrint("${widget.postData.image.length}");
  }

  Future<List<File>> urlToFile(List<ImageModel> imageUrls) async {
    List<File> imageFiles = [];
      for (var imageUrl in imageUrls) {
        // generate random number.
        var rng = new Random();
// get temporary directory of device.
        Directory tempDir = await getTemporaryDirectory();
// get temporary path from temporary directory.
        String tempPath = tempDir.path;
// create a new file in temporary path with random file name.
        File file = new File('$tempPath'+ (rng.nextInt(100)).toString() +'.png');
// call http.get method and pass imageUrl into it to get response.
        http.Response response = await http.get(imageUrl.url as Uri);
// write bodyBytes received in response to file.
        await file.writeAsBytes(response.bodyBytes);
        setState(() {
          selectedImages.add(file);
        });
        imageFiles.add(file);
      }
    return imageFiles;
  }
  @override
  Widget build(BuildContext context) {
    final appService = Provider.of<AppService>(context, listen: false);
      return Scaffold(
        body:
        widget.postData.image.length == 0 ?
        FutureBuilder(
          future: urlToFile(widget.postData.image), // a Future or null
          builder: (BuildContext context, AsyncSnapshot<List<File>> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none: return new Text('Press button to start');
              case ConnectionState.waiting: return new Text('Awaiting result...');
              default:
                if (snapshot.hasError)
                  return new Text('Error: ${snapshot.error}');
                else {
                      debugPrint("async success");
                      debugPrint("${snapshot.data}");
                      return SafeArea(
                        child: SingleChildScrollView(
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            child: Column(
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          bottom:
                                              BorderSide(color: Colors.grey))),
                                  child: Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            if (selectedImages.isEmpty &&
                                                videoFile == null &&
                                                describedController.text ==
                                                    "") {
                                              context.pop();
                                            } else {
                                              showModalBottomSheet(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: <Widget>[
                                                              const Column(
                                                                children: [
                                                                  Text(
                                                                    "Bạn muốn hoàn thành bài viết của mình sau?",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            18),
                                                                  ),
                                                                  Text(
                                                                    "Lưu làm bản nháp hoặc bạn có thể tiếp tục chỉnh sửa.",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .grey,
                                                                        fontSize:
                                                                            15),
                                                                  )
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                height: 15,
                                                              ),
                                                              TextButton(
                                                                onPressed: () {
                                                                  context.push(
                                                                      "/authenticated/personalPage/${appService.uidLoggedIn}");
                                                                },
                                                                child:
                                                                    const Row(
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .delete_forever,
                                                                      size: 32,
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                    SizedBox(
                                                                      width: 15,
                                                                    ),
                                                                    Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          "Thoát chỉnh sửa",
                                                                          style: TextStyle(
                                                                              fontSize: 16,
                                                                              color: Colors.black),
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
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child:
                                                                    const Row(
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .verified,
                                                                      size: 32,
                                                                      color: Colors
                                                                          .lightBlue,
                                                                    ),
                                                                    SizedBox(
                                                                      width: 15,
                                                                    ),
                                                                    Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          "Tiếp tục chỉnh sửa",
                                                                          style: TextStyle(
                                                                              fontSize: 16,
                                                                              color: Colors.lightBlue),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ]));
                                                  });
                                            }
                                          },
                                          icon: const Icon(Icons.arrow_back)),
                                      const Expanded(
                                        child: Text("Tạo bài viết"),
                                      ),
                                      OutlinedButton(
                                        onPressed: (selectedImages.isEmpty &&
                                                videoFile == null &&
                                                status == "")
                                            ? null
                                            : () {},
                                        style: OutlinedButton.styleFrom(
                                            side: BorderSide.none),
                                        child: Text(
                                          "ĐĂNG",
                                          style: TextStyle(
                                              color: (selectedImages.isEmpty &&
                                                      videoFile == null &&
                                                      describedController
                                                              .text ==
                                                          "" &&
                                                      status == "")
                                                  ? Colors.grey
                                                  : Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    MyImage(imageUrl: appService.avatar),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            status == ""
                                                ? appService.username
                                                : ("${appService.username} - Đang cảm thấy $status."),
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Colors.grey[900],
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 1,
                                            ),
                                          ),
                                          Container(
                                            width: 95,
                                            alignment: Alignment.center,
                                            child: ElevatedButton(
                                                onPressed: null,
                                                style: OutlinedButton.styleFrom(
                                                  side: BorderSide.none,
                                                  padding:
                                                      const EdgeInsets.all(2),
                                                ),
                                                child: const Row(
                                                  children: [
                                                    Icon(
                                                      Icons.circle_rounded,
                                                      color: Colors.blue,
                                                    ),
                                                    Text(
                                                      "Công khai",
                                                      style: TextStyle(
                                                          color: Colors.blue),
                                                    )
                                                  ],
                                                )),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(4, 0, 4, 0),
                                  margin: const EdgeInsets.only(bottom: 10),
                                  child: TextField(
                                    controller: describedController,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: selectedImages.isEmpty &&
                                                videoFile == null
                                            ? "Bạn đang nghĩ gì?"
                                            : selectedImages.isNotEmpty
                                                ? "Hãy nói gì đó về bức ảnh này"
                                                : "Hãy nói gì đó về video này"),
                                    style: const TextStyle(fontSize: 24),
                                  ),
                                ),
                                addImage
                                    ? ListImageLayout(
                                        images: selectedImages,
                                        fullHeight: double.infinity,
                                        cbFunction: (val) => setState(
                                            () => selectedImages = val))
                                    : videoFile != null
                                        ? VideoPlayerFile(
                                            videoFile: videoFile,
                                            cbFunction: (val) =>
                                                setState(() => videoFile = val))
                                        : Container(),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                }
          },

        ) :
        SafeArea(
          child: SingleChildScrollView(
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
                              if (selectedImages.isEmpty && videoFile == null && describedController.text == ""){
                                context.pop();
                              } else {
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
                                                const Column(
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
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    context.push(
                                                        "/authenticated/personalPage/${appService.uidLoggedIn}"
                                                    );

                                                  },
                                                  child: const Row(
                                                    children: [
                                                      Icon(
                                                        Icons.delete_forever,
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
                                                        CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            "Thoát chỉnh sửa",
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                color: Colors.black),
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
                                                  },
                                                  child: const Row(
                                                    children: [
                                                      Icon(
                                                        Icons.verified,
                                                        size: 32,
                                                        color: Colors.lightBlue,
                                                      ),
                                                      SizedBox(
                                                        width: 15,
                                                      ),
                                                      Column(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            "Tiếp tục chỉnh sửa",
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                color: Colors.lightBlue),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ]));
                                    });
                              }
                            },

                            icon: const Icon(Icons.arrow_back)),
                        const Expanded(
                          child: Text("Tạo bài viết"),
                        ),
                        OutlinedButton(
                          onPressed: (selectedImages.isEmpty && videoFile == null  && status == "") ? null : () {
                          },
                          style: OutlinedButton.styleFrom(side: BorderSide.none),
                          child:  Text(
                            "ĐĂNG",
                            style: TextStyle(
                                color: (selectedImages.isEmpty && videoFile == null && describedController.text == "" && status == "") ? Colors.grey : Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      MyImage(imageUrl: appService.avatar),
                      Expanded(
                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              status == "" ? appService.username : ("${appService.username} - Đang cảm thấy $status."),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.grey[900],
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                            Container(
                              width: 95,
                              alignment: Alignment.center,
                              child: ElevatedButton(
                                  onPressed: null,
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide.none,
                                    padding: const EdgeInsets.all(2),
                                  ),
                                  child: const Row(
                                    children: [
                                      Icon(Icons.circle_rounded, color: Colors.blue,),
                                      Text("Công khai", style: TextStyle(color: Colors.blue),)
                                    ],
                                  )),
                            )

                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                    margin: const EdgeInsets.only(bottom: 10),
                    child: TextField(
                      controller: describedController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: selectedImages.isEmpty && videoFile == null ? "Bạn đang nghĩ gì?" : selectedImages.isNotEmpty ? "Hãy nói gì đó về bức ảnh này" : "Hãy nói gì đó về video này"),
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),

                  addImage ?
                  ListImageLayout(images: selectedImages, fullHeight: double.infinity, cbFunction: (val) => setState(() => selectedImages = val)) :
                  videoFile != null ? VideoPlayerFile(videoFile: videoFile,cbFunction:(val) => setState(() => videoFile = val)) : Container(),
                ],
              ),
            ),
          ),
        ),
        // body: SafeArea(
        //   child: SingleChildScrollView(
        //     child: Container(
        //       padding: const EdgeInsets.all(5),
        //       child: Column(
        //         children: [
        //           Container(
        //             decoration: const BoxDecoration(
        //                 border: Border(bottom: BorderSide(color: Colors.grey))),
        //             child: Row(
        //               children: [
        //                 IconButton(
        //                     onPressed: () {
        //                       if (selectedImages.isEmpty && videoFile == null && describedController.text == ""){
        //                         context.pop();
        //                       } else {
        //                         showModalBottomSheet(
        //                             context: context,
        //                             builder: (BuildContext context) {
        //                               return Container(
        //                                   padding: const EdgeInsets.all(10),
        //                                   child: Column(
        //                                       mainAxisAlignment:
        //                                       MainAxisAlignment.center,
        //                                       crossAxisAlignment:
        //                                       CrossAxisAlignment.start,
        //                                       mainAxisSize: MainAxisSize.min,
        //                                       children: <Widget>[
        //                                         const Column(
        //                                           children: [
        //                                             Text(
        //                                               "Bạn muốn hoàn thành bài viết của mình sau?",
        //                                               style: TextStyle(
        //                                                   color: Colors.black,
        //                                                   fontSize: 18),
        //                                             ),
        //                                             Text(
        //                                               "Lưu làm bản nháp hoặc bạn có thể tiếp tục chỉnh sửa.",
        //                                               style: TextStyle(
        //                                                   color: Colors.grey,
        //                                                   fontSize: 15),
        //                                             )
        //                                           ],
        //                                         ),
        //                                         const SizedBox(
        //                                           height: 15,
        //                                         ),
        //                                         TextButton(
        //                                           onPressed: () {
        //                                             context.push(
        //                                                 "/authenticated/personalPage/${appService.uidLoggedIn}"
        //                                             );
        //
        //                                           },
        //                                           child: const Row(
        //                                             children: [
        //                                               Icon(
        //                                                 Icons.delete_forever,
        //                                                 size: 32,
        //                                                 color: Colors.black,
        //                                               ),
        //                                               SizedBox(
        //                                                 width: 15,
        //                                               ),
        //                                               Column(
        //                                                 mainAxisAlignment:
        //                                                 MainAxisAlignment.start,
        //                                                 crossAxisAlignment:
        //                                                 CrossAxisAlignment.start,
        //                                                 children: [
        //                                                   Text(
        //                                                     "Thoát chỉnh sửa",
        //                                                     style: TextStyle(
        //                                                         fontSize: 16,
        //                                                         color: Colors.black),
        //                                                   ),
        //                                                 ],
        //                                               ),
        //                                             ],
        //                                           ),
        //                                         ),
        //                                         const SizedBox(
        //                                           height: 15,
        //                                         ),
        //                                         TextButton(
        //                                           onPressed: () {
        //                                             Navigator.pop(context);
        //                                           },
        //                                           child: const Row(
        //                                             children: [
        //                                               Icon(
        //                                                 Icons.verified,
        //                                                 size: 32,
        //                                                 color: Colors.lightBlue,
        //                                               ),
        //                                               SizedBox(
        //                                                 width: 15,
        //                                               ),
        //                                               Column(
        //                                                 mainAxisAlignment:
        //                                                 MainAxisAlignment.start,
        //                                                 crossAxisAlignment:
        //                                                 CrossAxisAlignment.start,
        //                                                 children: [
        //                                                   Text(
        //                                                     "Tiếp tục chỉnh sửa",
        //                                                     style: TextStyle(
        //                                                         fontSize: 16,
        //                                                         color: Colors.lightBlue),
        //                                                   ),
        //                                                 ],
        //                                               ),
        //                                             ],
        //                                           ),
        //                                         ),
        //                                       ]));
        //                             });
        //                       }
        //                     },
        //
        //                     icon: const Icon(Icons.arrow_back)),
        //                 const Expanded(
        //                   child: Text("Tạo bài viết"),
        //                 ),
        //                 OutlinedButton(
        //                   onPressed: (selectedImages.isEmpty && videoFile == null  && status == "") ? null : () {
        //                   },
        //                   style: OutlinedButton.styleFrom(side: BorderSide.none),
        //                   child:  Text(
        //                     "ĐĂNG",
        //                     style: TextStyle(
        //                         color: (selectedImages.isEmpty && videoFile == null && describedController.text == "" && status == "") ? Colors.grey : Colors.black),
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ),
        //           Row(
        //             children: [
        //               MyImage(imageUrl: appService.avatar),
        //               Expanded(
        //                 child:Column(
        //                   crossAxisAlignment: CrossAxisAlignment.start,
        //                   children: <Widget>[
        //                     Text(
        //                       status == "" ? appService.username : ("${appService.username} - Đang cảm thấy $status."),
        //                       maxLines: 3,
        //                       overflow: TextOverflow.ellipsis,
        //                       style: TextStyle(
        //                         color: Colors.grey[900],
        //                         fontSize: 18,
        //                         fontWeight: FontWeight.bold,
        //                         letterSpacing: 1,
        //                       ),
        //                     ),
        //                     Container(
        //                       width: 95,
        //                       alignment: Alignment.center,
        //                       child: ElevatedButton(
        //                           onPressed: null,
        //                           style: OutlinedButton.styleFrom(
        //                             side: BorderSide.none,
        //                             padding: const EdgeInsets.all(2),
        //                           ),
        //                           child: const Row(
        //                             children: [
        //                               Icon(Icons.circle_rounded, color: Colors.blue,),
        //                               Text("Công khai", style: TextStyle(color: Colors.blue),)
        //                             ],
        //                           )),
        //                     )
        //
        //                   ],
        //                 ),
        //               ),
        //             ],
        //           ),
        //           Container(
        //             padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
        //             margin: const EdgeInsets.only(bottom: 10),
        //             child: TextField(
        //               controller: describedController,
        //               decoration: InputDecoration(
        //                   border: InputBorder.none,
        //                   hintText: selectedImages.isEmpty && videoFile == null ? "Bạn đang nghĩ gì?" : selectedImages.isNotEmpty ? "Hãy nói gì đó về bức ảnh này" : "Hãy nói gì đó về video này"),
        //               style: const TextStyle(fontSize: 24),
        //             ),
        //           ),
        //
        //           addImage ?
        //           ListImageLayout(images: selectedImages, fullHeight: double.infinity, cbFunction: (val) => setState(() => selectedImages = val)) :
        //           videoFile != null ? VideoPlayerFile(videoFile: videoFile,cbFunction:(val) => setState(() => videoFile = val)) : Container(),
        //         ],
        //       ),
        //     ),
        //   ),
        // ),,
        persistentFooterButtons: [
          Row(
            children: [
              const Expanded(
                child: Text("Thêm vào bài viết của bạn", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
              ),
              //image button
              IconButton(
                  onPressed: () {
                    getImages();
                  },
                  alignment: Alignment.centerRight,
                  icon:const Icon(
                    Icons.image,
                    color: Colors.green,
                  )),
              // video button
              IconButton(
                  onPressed: () async {
                    // getVideo();
                    try {
                      XFile? video = (await ImagePicker().pickVideo(source: ImageSource.gallery));
                      if (video != null) {
                        setState(() {
                          videoFile= null;
                          videoFile = File(video.path);
                          selectedImages = [];
                          addImage = false;
                        });
                      };
                    } catch(e) {
                      debugPrint('error picking video: $e');
                    }

                  },
                  alignment: Alignment.centerRight,

                  icon:const Icon(
                    Icons.video_collection,
                    color: Colors.green,
                  )),
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Emotions(chosenEmotion: (val) => setState(() => status = val))));
                  },
                  // alignment: Alignment.,

                  icon:const Icon(
                    Icons.emoji_emotions,
                    color: Colors.amber,
                  ))

            ],
          ),

        ],
      );
  }

  Future getImages() async {
    final pickedFile = await picker.pickMultiImage();
    List<XFile> xfilePick = pickedFile;
    setState(
          () {
        if (xfilePick.isNotEmpty) {
          selectedImages = [];
          for (var i = 0; i < xfilePick.length; i++) {
            selectedImages.add(File(xfilePick[i].path));
          }
          addImage = true;
          videoFile = null;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Nothing is selected')));
        }
      },
    );
  }

}

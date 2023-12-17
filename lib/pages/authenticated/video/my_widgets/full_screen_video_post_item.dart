import 'package:facebook_app/my_widgets/my_image.dart';
import 'package:facebook_app/pages/authenticated/video/my_widgets/full_screen_video_player.dart';
import 'package:facebook_app/util/common.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../../../models/video_post_model.dart';
import '../../../../services/video_player_provider.dart';


final ThemeData specialThemeData = ThemeData(
  brightness: Brightness.dark,
  // and so on...
);

class FullScreenVideoPostItem extends StatelessWidget {
  final VideoPost videoPost;
  final bool isInView;
  final int index;
  final VideoPlayerController? controller;

  const FullScreenVideoPostItem({super.key,
    required this.videoPost,
    required this.isInView,
    required this.index,
    required this.controller,
  });

  void _showOptionModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 180,
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              InkWell(
                onTap: () {},
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 48,
                      height: 48,
                      child: Icon(Icons.person_add_outlined),
                    ),
                    SizedBox(width: 16,),
                    Expanded(
                      child: Text("Thêm bạn", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () {},
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 48,
                      height: 48,
                      child: Icon(Icons.block_rounded),
                    ),
                    SizedBox(width: 16,),
                    Expanded(
                      child: Text("Chặn người dùng", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),),
                    )
                  ],
                ),
              ),
              InkWell(
                  onTap: () {},
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 48,
                        height: 48,
                        child: Icon(Icons.warning_amber_rounded),
                      ),
                      SizedBox(width: 16,),
                      Expanded(
                        child: Text("Báo cáo vi phạm", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),),
                      )
                    ],
                  )
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String formattedCreatedAt = getPostCreateAt(videoPost.created);
    return Theme(
      data: specialThemeData,
      child:
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        MyImage(
                            imageUrl: videoPost.author.avatar,
                            width: 44,
                            height: 44
                        ),
                        const SizedBox(width: 8,),
                        Expanded(child:
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(videoPost.author.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),),
                            Text(formattedCreatedAt, style: const TextStyle(fontWeight: FontWeight.w200, fontSize: 12),),
                          ],
                        )
                        ),
                        InkWell(
                          onTap: () { _showOptionModal(context); },
                          child: const Icon(Icons.more_horiz_rounded),
                        )
                      ],
                    ),
                    const SizedBox(height: 4,),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(videoPost.described),
                    )
                  ],
                ),
              ),
              FullScreenVideoPlayer(videoPost: videoPost, isInView: isInView, index: index, videoUrl: videoPost.video.url, vController: controller,),
              // AspectRatio(
              //   aspectRatio: videoPlayerProvider.curController.value.aspectRatio, // You may adjust this ratio as needed
              //   child: Container(
              //     color: Colors.black, // Placeholder color for the video
              //     child: Center(
              //       child: VideoPlayer(videoPlayerProvider.curController),
              //     ),
              //   ),
              // ),
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  "${videoPost.markComment} comment marks",
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Center(child: Text("Thích")),
                  ),
                  Expanded(
                    child: Center(child: Text("Bình luận")),
                  ),
                  Expanded(
                    child: Center(child: Text("Chia sẻ")),
                  )
                ],
              ),
              const SizedBox(height: 4,),
            ],
          ),
        ),
      );
  }
}

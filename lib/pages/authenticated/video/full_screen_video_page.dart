import 'package:facebook_app/models/video_post_model.dart';
import 'package:facebook_app/my_widgets/my_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import '../../../services/video_player_provider.dart';

class FullScreenVideoPage extends StatelessWidget {

  const FullScreenVideoPage({super.key, });

  // void _showOptionModal(BuildContext context) {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Container(
  //         height: 180,
  //         padding: EdgeInsets.all(16),
  //         child: const Column(
  //           children: [
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.start,
  //               children: [
  //                 SizedBox(
  //                   width: 48,
  //                   height: 48,
  //                   child: Icon(Icons.person_add_outlined),
  //                 ),
  //                 SizedBox(width: 16,),
  //                 Expanded(
  //                   child: Text("Thêm bạn", style: TextStyle(
  //                       fontWeight: FontWeight.w600, fontSize: 16),),
  //                 )
  //               ],
  //             ),
  //
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.start,
  //               children: [
  //                 SizedBox(
  //                   width: 48,
  //                   height: 48,
  //                   child: Icon(Icons.block_rounded),
  //                 ),
  //                 SizedBox(width: 16,),
  //                 Expanded(
  //                   child: Text("Chặn người dùng", style: TextStyle(
  //                       fontWeight: FontWeight.w600, fontSize: 16),),
  //                 )
  //               ],
  //             ),
  //
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.start,
  //               children: [
  //                 SizedBox(
  //                   width: 48,
  //                   height: 48,
  //                   child: Icon(Icons.warning_amber_rounded),
  //                 ),
  //                 SizedBox(width: 16,),
  //                 Expanded(
  //                   child: Text("Báo cáo vi phạm", style: TextStyle(
  //                       fontWeight: FontWeight.w600, fontSize: 16),),
  //                 )
  //               ],
  //             )
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  void _showOptionModal(BuildContext context, VideoPlayerProvider videoPlayerProvider) {
    videoPlayerProvider.setIsPlayMiniVideo(true);
    context.pop();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<VideoPlayerProvider>(
        builder: (context, videoPlayerProvider, _) {
        VideoPost videoPost = videoPlayerProvider.curVideoPost;
        return Scaffold(
            body: Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            MyImage(
                                imageUrl: videoPost.author.avatar,
                                width: 40,
                                height: 40
                            ),
                            const SizedBox(width: 8,),
                            Expanded(child:
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(videoPost.author.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),),
                                Text("8 thg 7", style: TextStyle(fontWeight: FontWeight.w200, fontSize: 12),),
                              ],
                            )
                            ),
                            InkWell(
                              onTap: () { _showOptionModal(context, videoPlayerProvider); },
                              child: const Icon(Icons.more_horiz_rounded),
                            )
                          ],
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(videoPost.described),
                        )
                      ],
                    ),
                  ),
                  AspectRatio(
                    aspectRatio: 4 / 3, // You may adjust this ratio as needed
                    child: Container(
                      color: Colors.black, // Placeholder color for the video
                      child: Center(
                          child: VideoPlayer(videoPlayerProvider.curController),
                      ),
                    ),
                  ),
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
                  )
                ],
              ),
            ),
        );
    });
  }
}

import 'package:facebook_app/my_widgets/my_image.dart';
import 'package:facebook_app/pages/authenticated/video/my_widgets/video_player.dart';
import 'package:facebook_app/util/common.dart';
import 'package:flutter/material.dart';

import '../../../../models/video_post_model.dart';

class VideoPostItem extends StatefulWidget {
  final VideoPost videoPost;
  final bool isInView;
  final int index;

  const VideoPostItem({super.key,
    required this.videoPost,
    required this.isInView,
    required this.index
  });

  @override
  _VideoPostItemState createState() => _VideoPostItemState();

}

class _VideoPostItemState extends State<VideoPostItem> {

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
    String formattedCreatedAt = getPostCreateAt(widget.videoPost.created);
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            height: 6,
            width: double.infinity,
            color: Colors.black12,
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    MyImage(
                        imageUrl: widget.videoPost.author.avatar,
                        width: 44,
                        height: 44
                    ),
                    const SizedBox(width: 8,),
                    Expanded(child:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.videoPost.author.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),),
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
                  child: Text(widget.videoPost.described),
                )
              ],
            ),
          ),
          AspectRatio(
            aspectRatio: 4 / 3, // You may adjust this ratio as needed
            child: Container(
              color: Colors.black, // Placeholder color for the video
              child: Center(
                  child: MyVideoPlayer(videoUrl: widget.videoPost.video.url, isInView: widget.isInView, videoPost: widget.videoPost, index: widget.index,)
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              "${widget.videoPost.markComment} comment marks",
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
          const SizedBox(height: 4,)
        ],
      ),
    );
  }
}

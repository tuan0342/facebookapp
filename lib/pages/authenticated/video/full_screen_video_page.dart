import 'package:facebook_app/models/video_post_model.dart';
import 'package:facebook_app/my_widgets/my_image.dart';
import 'package:facebook_app/pages/authenticated/video/my_widgets/full_screen_video_post_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../../services/video_player_provider.dart';
import '../../../services/video_service.dart';
import '../../../util/common.dart';
import 'my_widgets/video_post_item.dart';

final ThemeData specialThemeData = ThemeData(
  brightness: Brightness.dark,
  // and so on...
);
class FullScreenVideoPage extends StatefulWidget {
  const FullScreenVideoPage({super.key,});

  @override
  State<FullScreenVideoPage> createState() => _FullScreenVideoPageState();
}

class _FullScreenVideoPageState extends State<FullScreenVideoPage> {
  late String lastId;
  List<VideoPost> videoPosts = [];
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    VideoPlayerProvider videoPlayerProvider = Provider.of<VideoPlayerProvider>(context, listen: false);
    VideoPost videoPost = videoPlayerProvider.curVideoPost;
    setState(() {
      videoPosts.add(videoPost);
      lastId = videoPost.id.toString();
    });

    getVideoPosts();
    _scrollController.addListener(_loadMore);

  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void getVideoPosts() async {
    final result = await VideoService(context: context).getVideoPost(lastId, count: "2");

    setState(() {
      videoPosts.insertAll(videoPosts.length, result["posts"]);
      lastId = result["last_id"];
    });
  }

  Future<void> _loadMore() async {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      final result = await VideoService(context: context).getVideoPost(lastId, count: "2");

      setState(() {
        videoPosts.insertAll(videoPosts.length, result["posts"]);
        lastId = result["last_id"];
      });
    }
  }

  void onBlockItem(int userId) {
    setState(() {
      videoPosts.retainWhere((videoPost) => videoPost.author.id != userId);
    });
  }


  void _showMiniVideo(BuildContext context, VideoPlayerProvider videoPlayerProvider) {
    videoPlayerProvider.setIsPlayMiniVideo(true);
    context.pop(true);
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<VideoPlayerProvider>(
        builder: (context, videoPlayerProvider, _) {
        return Theme(
            data: specialThemeData,
            child: VisibilityDetector(
              key: Key("full_screen_video"),
              onVisibilityChanged: (VisibilityInfo info) {
                if (videoPlayerProvider.isIsInitialize) {
                  if(info.visibleFraction == 0){
                    videoPlayerProvider.curController.pause();
                  }
                  else{
                    videoPlayerProvider.curController.play();
                  }
                }
              },
              child: Scaffold(
                  appBar: AppBar(
                    title: const Text("Video khác", style: TextStyle(fontSize: 16 )),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: InkWell(
                          onTap: () {
                            _showMiniVideo(context, videoPlayerProvider);
                          },
                          child: const Icon(Icons.window_rounded),
                        ),
                      ),
                    ],
                  ),
                  body: Expanded(
                    child: InViewNotifierList(
                      controller: _scrollController,
                      isInViewPortCondition: (double deltaTop, double deltaBottom, double viewPortDimension) {
                        return deltaTop < (0.5 * viewPortDimension) && deltaBottom > (0.5 * viewPortDimension);
                      },
                      itemCount: videoPosts.length,
                      builder: (BuildContext context, int index) {
                        return InViewNotifierWidget(
                            id: "$index",
                            builder: (BuildContext context, bool isInView, Widget? child) {
                              return FullScreenVideoPostItem(videoPost: videoPosts.elementAt(index), isInView: isInView, index: index, controller: index == 0 ? videoPlayerProvider.curController : null, onBlock: onBlockItem);
                            }
                        );
                      },
                    ),
                  ),
              )
            ),
        );
    });
  }
}

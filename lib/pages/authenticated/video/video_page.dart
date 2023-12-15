import 'dart:async';

import 'package:facebook_app/models/notification_model.dart';
import 'package:facebook_app/models/video_post_model.dart';
import 'package:facebook_app/pages/authenticated/video/my_widgets/overlay_widget.dart';
import 'package:facebook_app/pages/authenticated/video/my_widgets/video_post_item.dart';
import 'package:facebook_app/services/notification_services.dart';
import 'package:facebook_app/services/video_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../../services/video_player_provider.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  bool isLoadingVideos = false;
  List<VideoPost> videoPosts = [];

  void getVideoPosts() async {
    setState(() {
      isLoadingVideos = true;
    });
    final videos = await VideoService(context: context).getVideoPost();
    setState(() {
      videoPosts = videos["posts"];
      isLoadingVideos = false;
    });
  }
  void _onShowFullScreen(BuildContext context) async {
    context.push("/authenticated/fullScreenVideo");
  }

  @override
  void initState() {
    super.initState();
    getVideoPosts();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(child: Text("Watch", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),)),
                      SizedBox(
                        width: 32,
                        height: 32,
                        child: InkWell(
                          onTap: () {
                            _onShowFullScreen(context);
                          },
                          child: Icon(Icons.search),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                if (videoPosts.isNotEmpty) Expanded(
                  child: InViewNotifierList(
                    isInViewPortCondition: (double deltaTop, double deltaBottom, double viewPortDimension) {
                      return deltaTop < (0.5 * viewPortDimension) && deltaBottom > (0.5 * viewPortDimension);
                    },
                    itemCount: videoPosts.length,
                    builder: (BuildContext context, int index) {
                      return InViewNotifierWidget(
                          id: "$index",
                          builder: (BuildContext context, bool isInView, Widget? child) {
                            return VideoPostItem(videoPost: videoPosts.elementAt(index), isInView: isInView);
                          }
                      );
                    },
                  ),
                ),
              ],
            ), // Display the provided background or an empty container
            const OverLayWidget(),
          ],
        )
    );
  }
}

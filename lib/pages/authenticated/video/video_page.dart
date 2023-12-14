import 'package:facebook_app/models/notification_model.dart';
import 'package:facebook_app/models/video_post_model.dart';
import 'package:facebook_app/pages/authenticated/video/my_widgets/video_post_item.dart';
import 'package:facebook_app/services/notification_services.dart';
import 'package:facebook_app/services/video_service.dart';
import 'package:flutter/material.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:provider/provider.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  bool isLoadingVideos = false;
  List<VideoPost> videoPosts = [];

  final FocusNode focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();

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

  @override
  void initState() {
    super.initState();
    getVideoPosts();
  }

  void swithss() {
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
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
                        swithss();
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
        ),
    );
  }
}

import 'dart:async';

import 'package:facebook_app/models/video_post_model.dart';
import 'package:facebook_app/pages/authenticated/video/my_widgets/overlay_widget.dart';
import 'package:facebook_app/pages/authenticated/video/my_widgets/video_post_item.dart';
import 'package:facebook_app/services/video_player_provider.dart';
import 'package:facebook_app/services/video_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  bool isLoadingVideos = true;
  List<VideoPost> videoPosts = [];
  String lastId = "0";
  final _scrollController = ScrollController();

  void getVideoPosts() async {
    setState(() {
      isLoadingVideos = true;
    });
    final result = await VideoService(context: context).getVideoPost(lastId);

    setState(() {
      videoPosts = result["posts"];
      lastId = result["last_id"];
      isLoadingVideos = false;
    });
  }

  void _onShowSearchScreen(BuildContext context) async {
    context.push("/authenticated/search");
  }

  @override
  void initState() {
    super.initState();
    getVideoPosts();
    _scrollController.addListener(_loadMore);
  }

  @override
  void didUpdateWidget(VideoPage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _pullRefresh() async {
    setState(() {
      videoPosts = [];
      lastId = "0";
    });
    getVideoPosts();
  }

  Future<void> _loadMore() async {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      final result = await VideoService(context: context).getVideoPost(lastId);

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

  void onReportItem(int postId) {
    setState(() {
      videoPosts.retainWhere((videoPost) => videoPost.id != postId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: VisibilityDetector(
        key: Key("video_page"),
        onVisibilityChanged: (VisibilityInfo info) {
          final videoProvider =
              Provider.of<VideoPlayerProvider>(context, listen: false);
          if (videoProvider.isIsInitialize) {
            if (info.visibleFraction == 0) {
              videoProvider.curController.pause();
            } else {
              videoProvider.curController.play();
            }
          }
        },
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 16, bottom: 8),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Expanded(
                          child: Text(
                        "Watch",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      )),
                      SizedBox(
                        width: 32,
                        height: 32,
                        child: InkWell(
                          onTap: () {
                            _onShowSearchScreen(context);
                          },
                          child: const Icon(Icons.search),
                        ),
                      )
                    ],
                  ),
                ),
                if (!isLoadingVideos)
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: _pullRefresh,
                      child: InViewNotifierList(
                        controller: _scrollController,
                        isInViewPortCondition: (double deltaTop,
                            double deltaBottom, double viewPortDimension) {
                          return deltaTop < (0.5 * viewPortDimension) &&
                              deltaBottom > (0.5 * viewPortDimension);
                        },
                        itemCount: videoPosts.length,
                        builder: (BuildContext context, int index) {
                          return InViewNotifierWidget(
                              id: "$index",
                              builder: (BuildContext context, bool isInView,
                                  Widget? child) {
                                return VideoPostItem(
                                  videoPost: videoPosts.elementAt(index),
                                  isInView: isInView,
                                  index: index,
                                  onBlock: onBlockItem,
                                  onReport: onReportItem,
                                );
                              });
                        },
                      ),
                    ),
                  )
                else
                  Expanded(
                    child: Skeletonizer(
                      child: Expanded(
                        child: ListView.builder(
                          itemCount: 2,
                          itemBuilder: (context, index) {
                            return Container(
                              color: Colors.white,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Container(
                                    height: 6,
                                    width: double.infinity,
                                    color: Colors.black12,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(12),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                                width: 44,
                                                height: 44,
                                                child: const Icon(
                                                  Icons.add,
                                                  size: 44,
                                                )),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: 80,
                                                    height: 12,
                                                    color: Colors.black26,
                                                  ),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  Container(
                                                    width: 50,
                                                    height: 8,
                                                    color: Colors.black26,
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 28,
                                  ),
                                  AspectRatio(
                                    aspectRatio: 4 / 3,
                                    child: Container(
                                      width: double.infinity,
                                      height: double.infinity,
                                      color: Colors.white12,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 40,
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  )
              ],
            ), // Display the provided background or an empty container
            const OverLayWidget(),
          ],
        ),
      ),
    );
  }
}

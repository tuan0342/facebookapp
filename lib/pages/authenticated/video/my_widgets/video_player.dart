import 'package:facebook_app/models/video_post_model.dart';
import 'package:facebook_app/services/video_player_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

/// Stateful widget to fetch and then display video content.
class MyVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final bool isInView;
  final VideoPost videoPost;
  final int index;
  const MyVideoPlayer({super.key, required this.videoUrl, required this.isInView, required this.videoPost, required this.index});

  @override
  _MyVideoPlayerState createState() => _MyVideoPlayerState();
}

class _MyVideoPlayerState extends State<MyVideoPlayer> with AutomaticKeepAliveClientMixin {
  late VideoPlayerController _controller;
  bool _isInView = false;
  bool isInitialized = false;
  bool shouldKeepAlive = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        setState(() {
          isInitialized = true;
        });
      });
  }

  @override
  void didUpdateWidget(MyVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!oldWidget.isInView && widget.isInView) {
      setState(() {
        _isInView = true;
      });
    } else {
      setState(() {
        _isInView = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<VideoPlayerProvider>(
      builder: (cContext, videoPlayerProvider, _) {
        void changeStateAudio() {
          if (videoPlayerProvider.isMute) {
            videoPlayerProvider.unmute();
          } else {
            videoPlayerProvider.mute();
          }
        }

        if (videoPlayerProvider.isMute) {
          _controller.setVolume(0.0);
        } else {
          _controller.setVolume(1.0);
        }
        if (!videoPlayerProvider.isPlayMiniVideo) {
          if (widget.isInView || !videoPlayerProvider.isIsInitialize) {
            _controller.play();
            videoPlayerProvider.setController(_controller);
            videoPlayerProvider.setVideoPost(widget.videoPost);
          } else {
            _controller.pause();
          }
        }

      return isInitialized
            ? Stack(
                children: [
                  Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: InkWell(
                        onTap: () {
                          videoPlayerProvider.setController(_controller);
                          videoPlayerProvider.unmute();
                          videoPlayerProvider.setVideoPost(widget.videoPost);
                          videoPlayerProvider.setIsPlayMiniVideo(false);
                          context.push("/authenticated/fullScreenVideo").then((value) {
                            if (value != null) {
                              setState(() {
                                shouldKeepAlive = true;
                              });
                              updateKeepAlive();
                            }
                          });
                        },
                        child: videoPlayerProvider.isPlayMiniVideo
                            ? const Center(child: Text("Đang phát", style: TextStyle(color: Colors.white, fontSize: 16),),)
                            : VideoPlayer(_controller),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 24,
                    right: 24,
                    child: InkWell(
                        onTap: () {
                          changeStateAudio();
                        },
                        child: videoPlayerProvider.isMute
                            ? const Icon(
                          Icons.volume_mute_rounded, color: Colors.white,)
                            : const Icon(
                          Icons.volume_up_rounded, color: Colors.white,)
                    ),
                  ),
                ],
              )
            : Container();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  bool get wantKeepAlive => shouldKeepAlive;
}
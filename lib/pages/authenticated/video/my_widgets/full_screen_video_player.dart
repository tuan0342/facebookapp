import 'package:facebook_app/models/video_post_model.dart';
import 'package:facebook_app/services/video_player_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

/// Stateful widget to fetch and then display video content.
class FullScreenVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final bool isInView;
  final VideoPost videoPost;
  final int index;
  final VideoPlayerController? vController;
  const FullScreenVideoPlayer({super.key, required this.videoUrl, required this.isInView, required this.videoPost, required this.index, required this.vController});

  @override
  _FullScreenVideoPlayerState createState() => _FullScreenVideoPlayerState();
}

class _FullScreenVideoPlayerState extends State<FullScreenVideoPlayer> with AutomaticKeepAliveClientMixin {
  late VideoPlayerController _controller;
  bool _isInView = false;
  bool isInitialized = false;
  bool shouldKeepAlive = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.vController != null ? widget.vController! : VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
    if (widget.vController == null) {
      _controller.initialize().then((_) {
        setState(() {
          isInitialized = true;
        });
      });
    } else {
      setState(() {
        isInitialized = true;
        shouldKeepAlive = true;
      });
      updateKeepAlive();
    }
  }

  @override
  void didUpdateWidget(FullScreenVideoPlayer oldWidget) {
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
          if (widget.isInView || widget.vController != null) {
            _controller.play();

            videoPlayerProvider.setController(_controller);
            videoPlayerProvider.setVideoPost(widget.videoPost);
          } else {
            _controller.pause();
          }

          return isInitialized || widget.vController != null
              ? Stack(
            children: [
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
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
    if (!shouldKeepAlive) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  bool get wantKeepAlive => shouldKeepAlive;
}
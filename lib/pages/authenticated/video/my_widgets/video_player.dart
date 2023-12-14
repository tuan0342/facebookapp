import 'package:facebook_app/services/video_player_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

/// Stateful widget to fetch and then display video content.
class MyVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final bool isInView;
  const MyVideoPlayer({super.key, required this.videoUrl, required this.isInView,});

  @override
  _MyVideoPlayerState createState() => _MyVideoPlayerState();
}

class _MyVideoPlayerState extends State<MyVideoPlayer> {
  late VideoPlayerController _controller;
  bool _isInView = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        _isInView = widget.isInView;
        if (widget.isInView) {
          _controller.play();
        }
      });
  }

  @override
  void didUpdateWidget(MyVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!oldWidget.isInView && widget.isInView) {
      setState(() {
        _isInView = true;
      });
      _controller.play();
    } else {
      setState(() {
        _isInView = false;
      });
      _controller.pause();
    }
  }

  @override
  void onDispose() {
    _controller.pause();
  }



  @override
  Widget build(BuildContext context) {
    return Consumer<VideoPlayerProvider>(
      builder: (context, videoPlayerProvider, _) {
        void changeStateAudio() {
          print("changeAudio");
          if (videoPlayerProvider.isMute) {
            videoPlayerProvider.unmute();
          } else {
            videoPlayerProvider.mute();
          }
          print(videoPlayerProvider.isMute);
        }

        if (videoPlayerProvider.isMute) {
          _controller.setVolume(0.0);
        } else {
          _controller.setVolume(1.0);
        }

      return Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: Stack(
              children: [
                VideoPlayer(_controller),
                Positioned(
                  bottom: 16,
                  right: 16,
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
                )
              ],
            )
        )
            : Container(),
      );
    });
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     setState(() {
        //       _controller.value.isPlaying
        //           ? _controller.pause()
        //           : _controller.play();
        //     });
        //   },
        //   child: Icon(
        //     _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        //   ),
        // ),
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
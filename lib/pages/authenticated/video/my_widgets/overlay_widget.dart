import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../../../services/video_player_provider.dart';

class OverLayWidget extends StatefulWidget {
  const OverLayWidget({ super.key });

  @override
  State<StatefulWidget> createState() => _OverLayState();
}

class _OverLayState extends State<OverLayWidget> {
  Offset position = Offset(16, 16);
  int animation_speed = 0;

  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;

    return Consumer<VideoPlayerProvider>(
        builder: (cContext, videoPlayerProvider, _) {
          if (videoPlayerProvider.isPlayMiniVideo) {
            videoPlayerProvider.curController.play();
          }
          return videoPlayerProvider.isPlayMiniVideo
              ? AnimatedPositioned(
            duration: Duration(milliseconds: animation_speed),
            curve: Curves.fastOutSlowIn,
            top: position.dy,
            // Adjust top position as needed
            left: position.dx,
            // Adjust left position as needed
            child: Draggable(
              onDragStarted: () {},
              onDragUpdate: (details) =>
              {
                setState(() {
                  animation_speed = 0;
                  position = Offset(position.dx + details.delta.dx,
                      position.dy + details.delta.dy);
                })
              },
              onDraggableCanceled: (velocity, offset) {
                double dx,
                    dy = 0;
                if (offset.dx + 160 / 2 - width / 2.0 < 0) {
                  dx = 16.0;
                } else {
                  dx = width - 160 - 16;
                }
                if (offset.dy + 90 / 2 - height / 2.0 < 0) {
                  dy = 16.0;
                } else {
                  dy = height - 180 - 16;
                }

                if (velocity.pixelsPerSecond.dx > 1000 &&
                    offset.dx + 160 / 2 - width / 3.0 * 2.0 >= 0) {
                  setState(() {
                    animation_speed = 80;
                    position = Offset(offset.dx + width * 2 / 3, offset.dy);
                  });
                  Future.delayed(const Duration(milliseconds: 500), () {
                    videoPlayerProvider.setIsPlayMiniVideo(false);
                    setState(() {
                      animation_speed = 0;
                      position = Offset(16, 16);
                    });

                  });
                } else {
                  setState(() {
                    animation_speed = 320;

                    position = Offset(dx, dy);
                  });
                }
              },
              onDragEnd: (details) {},
              feedback: Container(
                width: 160, // Adjust width as needed
                height: 90,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: VideoPlayer(videoPlayerProvider.curController)
                ),// Adjust color as needed
              ),
              childWhenDragging: Container(),
              child: Container(
                width: 160,
                height: 90,
                child: InkWell(
                    onTap: () {
                      videoPlayerProvider.setIsPlayMiniVideo(false);
                      context.push("/authenticated/fullScreenVideo");
                    },
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: VideoPlayer(videoPlayerProvider.curController)
                  ),
                )
              ),
            ),
          )
              : Container();
        }
    );
  }
}
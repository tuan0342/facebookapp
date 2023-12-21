import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerFile extends StatefulWidget {
  final String videoPath;
  VideoPlayerFile({required this.videoPath});


  @override
  State<StatefulWidget> createState() {
    return _VideoPlayerFileState();
  }
}

class _VideoPlayerFileState extends State<VideoPlayerFile> {
   late VideoPlayerController _controller;
   late Future<void> _video;

  @override
  void initState() {
    _controller = VideoPlayerController.file(File(widget.videoPath));
    _video = _controller.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          widget.videoPath != '' ?
          FutureBuilder(
              future: _video,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // If the VideoPlayerController has finished initialization, use
                  // the data it provides to limit the aspect ratio of the video.
                  return AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    // Use the VideoPlayer widget to display the video.
                    child: VideoPlayer( _controller),
                  );
                } else {
                  // If the VideoPlayerController is still initializing, show a
                  // loading spinner.
                  return Center(child: CircularProgressIndicator());
                }
              }
          ):
          Container(),


        ],
      )
    );
  }

}
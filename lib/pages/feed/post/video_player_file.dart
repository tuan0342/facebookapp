import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerFile extends StatefulWidget {
  File? videoFile;
  final FileCallback cbFunction;

  VideoPlayerFile({required this.videoFile, required this.cbFunction});


  @override
  State<StatefulWidget> createState() {
    return _VideoPlayerFileState();
  }
}

typedef void FileCallback(File? val);

class _VideoPlayerFileState extends State<VideoPlayerFile> {
   late VideoPlayerController? _controller;
   late Future<void>? _video;
  @override
  void initState() {
    _controller = VideoPlayerController.file(File(widget.videoFile!.path));
    _video = _controller!.initialize();
  }

   void dispose() {
     // Ensure disposing of the VideoPlayerController to free up resources.
     _controller!.dispose();

     super.dispose();
   }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          widget.videoFile!.path != '' ?
              Stack(
                children: [
                  FutureBuilder(
                      future: _video,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          // If the VideoPlayerController has finished initialization, use
                          // the data it provides to limit the aspect ratio of the video.
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                // If the video is playing, pause it.
                                if (_controller!.value.isPlaying) {
                                  _controller?.pause();
                                } else {
                                  // If the video is paused, play it.
                                  _controller?.play();
                                }
                              });
                            },
                            // Use the VideoPlayer widget to display the video.
                            child: Stack(alignment: Alignment.center, children: [
                              AspectRatio(
                                aspectRatio: _controller!.value.aspectRatio,
                                // Use the VideoPlayer widget to display the video.
                                child: VideoPlayer(_controller!),
                              ),
                              if (!_controller!.value.isPlaying)
                                Center(
                                    child: Icon(
                                      Icons.play_circle_outline,
                                      color: Colors.grey[400],
                                      size: 60,
                                    ))
                            ]),

                          );
                        } else {
                          // If the VideoPlayerController is still initializing, show a
                          // loading spinner.
                          return Center(child: CircularProgressIndicator());
                        }
                      }
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.videoFile = null;
                          widget.cbFunction(widget.videoFile);
                          _controller = null;
                          _video = null;
                        });
                      },
                      child: const Icon(Icons.close,
                          color: Colors.black),
                    ),
                  ),

                ],
              )

              :
          Container(),

        ],
      )
    );
  }

}
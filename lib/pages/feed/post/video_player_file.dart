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
    debugPrint("1");
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
                          return AspectRatio(
                            aspectRatio: _controller!.value.aspectRatio,
                            // Use the VideoPlayer widget to display the video.
                            child: VideoPlayer( _controller!),
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
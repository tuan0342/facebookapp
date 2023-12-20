import 'package:facebook_app/models/video_post_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerProvider extends ChangeNotifier {
  bool _isInVideoTab = false;
  bool get isInVideoTab => _isInVideoTab;

  bool _isMute = true;
  bool get isMute => _isMute;

  bool _isIsInitialize = false;
  bool get isIsInitialize => _isIsInitialize;

  late VideoPost _videopost;
  VideoPost get curVideoPost => _videopost;

  late VideoPlayerController _controller;
  VideoPlayerController get curController => _controller;

  bool _isPlayMiniVideo = false;
  bool get isPlayMiniVideo => _isPlayMiniVideo;

  List<VideoPost> _videoPosts = [];
  List<VideoPost> get videoPosts => _videoPosts;

  void setIsInVideoPage(value) {
    _isInVideoTab = value;
    if (_isIsInitialize) {
      if (value == true) {
        curController.play();
      } else {
        curController.pause();
      }
    }
  }

  void mute() {
    _isMute = true;
    notifyListeners();
  }

  void unmute() {
    _isMute = false;
    notifyListeners();
  }

  void setController(VideoPlayerController controller) {
    _controller = controller;
    _isIsInitialize = true;
    notifyListeners();
  }

  void setVideoPost(VideoPost videoPost) {
    _videopost = videoPost;
  }

  void setIsPlayMiniVideo(bool value) {
    _isPlayMiniVideo = value;
    notifyListeners();
  }

  void setVideoPosts(List<VideoPost> videoPosts) {
    _videoPosts = videoPosts;
  }
}
import 'package:facebook_app/models/video_post_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerProvider extends ChangeNotifier {
  bool _isMute = true;
  bool get isMute => _isMute;

  late VideoPost _videopost;
  VideoPost get curVideoPost => _videopost;

  late VideoPlayerController _controller;
  VideoPlayerController get curController => _controller;

  bool _isPlayMiniVideo = false;
  bool get isPlayMiniVideo => _isPlayMiniVideo;

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
    notifyListeners();
  }

  void setVideoPost(VideoPost videoPost) {
    _videopost = videoPost;
  }

  void setIsPlayMiniVideo(bool value) {
    _isPlayMiniVideo = value;
    notifyListeners();
  }
}
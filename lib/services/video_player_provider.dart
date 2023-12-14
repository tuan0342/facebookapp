import 'package:flutter/cupertino.dart';

class VideoPlayerProvider extends ChangeNotifier {
  bool _isMute = true;
  bool get isMute => _isMute;

  void mute() {
    _isMute = true;
    notifyListeners();
  }

  void unmute() {
    _isMute = false;
    notifyListeners();
  }
}
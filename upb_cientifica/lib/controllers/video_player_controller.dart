import 'package:flutter/foundation.dart';

/// Controlador de reproducción simulada para la pantalla de video.
class VideoPlayerController extends ChangeNotifier {
  bool _playing = false;
  double _progress = 0.32;

  bool get playing => _playing;
  double get progress => _progress;

  void togglePlay() {
    _playing = !_playing;
    notifyListeners();
  }

  void setProgress(double value) {
    _progress = value.clamp(0.0, 1.0);
    notifyListeners();
  }

  void skip(double delta) => setProgress(_progress + delta);
}

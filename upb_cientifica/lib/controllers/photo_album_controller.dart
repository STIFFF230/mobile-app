import 'package:flutter/foundation.dart';

class PhotoAlbumController extends ChangeNotifier {
  String _tab = 'Recientes';

  String get tab => _tab;

  void setTab(String tab) {
    _tab = tab;
    notifyListeners();
  }
}

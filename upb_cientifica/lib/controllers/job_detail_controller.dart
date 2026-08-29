import 'package:flutter/foundation.dart';

class JobDetailController extends ChangeNotifier {
  static const List<String> tabs = ['Registro', 'Salida', 'Errores', 'Resultados', 'Métricas'];

  String _tab = tabs.first;
  String get tab => _tab;

  void setTab(String tab) {
    _tab = tab;
    notifyListeners();
  }
}

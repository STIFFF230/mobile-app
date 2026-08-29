import 'package:flutter/foundation.dart';

/// Controlador del asistente de creación de trabajos HPC (4 pasos).
class CreateJobController extends ChangeNotifier {
  static const int totalSteps = 4;

  int _step = 0;
  int get step => _step;

  bool get isLastStep => _step == totalSteps - 1;

  /// Avanza de paso o, en el último paso, retorna true indicando que el
  /// trabajo debe enviarse y la vista debe navegar de vuelta a la lista.
  bool next() {
    if (_step < totalSteps - 1) {
      _step++;
      notifyListeners();
      return false;
    }
    return true;
  }

  void back() {
    if (_step > 0) {
      _step--;
      notifyListeners();
    }
  }

  void reset() {
    _step = 0;
    notifyListeners();
  }
}

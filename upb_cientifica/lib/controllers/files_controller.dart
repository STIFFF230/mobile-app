import 'package:flutter/foundation.dart';

enum FilesViewMode { grid, list }

/// Controlador del explorador de archivos: vista, filtro activo y menú
/// contextual abierto.
class FilesController extends ChangeNotifier {
  FilesViewMode _viewMode = FilesViewMode.list;
  String _filter = 'Todos';
  int? _openMenuIndex;

  FilesViewMode get viewMode => _viewMode;
  String get filter => _filter;
  int? get openMenuIndex => _openMenuIndex;

  void setViewMode(FilesViewMode mode) {
    _viewMode = mode;
    notifyListeners();
  }

  void setFilter(String filter) {
    _filter = filter;
    notifyListeners();
  }

  void toggleMenu(int index) {
    _openMenuIndex = _openMenuIndex == index ? null : index;
    notifyListeners();
  }

  void closeMenu() {
    if (_openMenuIndex != null) {
      _openMenuIndex = null;
      notifyListeners();
    }
  }
}

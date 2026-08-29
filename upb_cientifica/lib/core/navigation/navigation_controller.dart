import 'package:flutter/foundation.dart';

import 'screen.dart';

/// Controlador central de navegación (equivalente al estado `screen` /
/// `activeTab` que se manejaba en App.tsx con useState).
class NavigationController extends ChangeNotifier {
  AppScreen _screen = AppScreen.splash;
  NavTab _activeTab = NavTab.inicio;

  AppScreen get screen => _screen;
  NavTab get activeTab => _activeTab;

  bool get showChrome => !noChromeScreens.contains(_screen);

  bool get showBack => !rootScreens.contains(_screen);

  String get title => screenTitles[_screen] ?? '';

  void navigate(AppScreen destination) {
    _screen = destination;
    final tab = screenTabs[destination];
    if (tab != null) _activeTab = tab;
    notifyListeners();
  }

  void handleTabPress(NavTab tab) {
    _activeTab = tab;
    _screen = navScreens[tab]!;
    notifyListeners();
  }

  void goBack() {
    final tab = screenTabs[_screen];
    _screen = tab != null ? navScreens[tab]! : AppScreen.dashboard;
    notifyListeners();
  }
}

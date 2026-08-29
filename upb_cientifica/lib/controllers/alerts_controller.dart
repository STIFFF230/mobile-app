import 'package:flutter/foundation.dart';

import '../models/alert_item.dart';

class AlertsController extends ChangeNotifier {
  String _filter = 'Todos';
  List<AlertItem> _alerts = List.of(mockAlerts);

  String get filter => _filter;
  List<AlertItem> get alerts => _alerts;
  int get unreadCount => _alerts.where((a) => !a.read).length;

  List<AlertItem> get filteredAlerts =>
      _filter == 'Todos' ? _alerts : _alerts.where((a) => a.type == _filter).toList();

  void setFilter(String filter) {
    _filter = filter;
    notifyListeners();
  }

  void markAllRead() {
    _alerts = _alerts
        .map(
          (a) => AlertItem(
            icon: a.icon,
            color: a.color,
            bg: a.bg,
            title: a.title,
            sub: a.sub,
            time: a.time,
            type: a.type,
            read: true,
          ),
        )
        .toList();
    notifyListeners();
  }
}

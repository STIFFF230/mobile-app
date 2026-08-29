import 'package:flutter/material.dart';

class ActivityItem {
  const ActivityItem({
    required this.icon,
    required this.color,
    required this.label,
    required this.time,
    required this.sub,
  });

  final IconData icon;
  final Color color;
  final String label;
  final String time;
  final String sub;
}

const List<ActivityItem> mockActivity = [
  ActivityItem(
    icon: Icons.upload_outlined,
    color: Color(0xFF34A853),
    label: 'simulacion_climatica.py subido',
    time: 'hace 2 min',
    sub: 'Proyecto Clima 2025',
  ),
  ActivityItem(
    icon: Icons.memory,
    color: Color(0xFF1A73E8),
    label: 'Job MPI completado',
    time: 'hace 15 min',
    sub: 'modelo_molecular — 48 procesos',
  ),
  ActivityItem(
    icon: Icons.share_outlined,
    color: Color(0xFF9C27B0),
    label: 'datos_sensores.csv compartido',
    time: 'hace 1 h',
    sub: 'Con grupo Bioinformática',
  ),
  ActivityItem(
    icon: Icons.notifications_none,
    color: Color(0xFFFBBC04),
    label: 'Cuota al 85% de capacidad',
    time: 'hace 3 h',
    sub: 'Almacenamiento · Advertencia',
  ),
  ActivityItem(
    icon: Icons.arrow_upward,
    color: Color(0xFFEA4335),
    label: 'resultados_genomica.zip procesado',
    time: 'Ayer',
    sub: 'Job completado · 2.1 GB',
  ),
];

class QuickLinkData {
  const QuickLinkData({
    required this.icon,
    required this.label,
    required this.color,
    required this.bg,
  });

  final IconData icon;
  final String label;
  final Color color;
  final Color bg;
}

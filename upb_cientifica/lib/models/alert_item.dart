import 'package:flutter/material.dart';

class AlertItem {
  const AlertItem({
    required this.icon,
    required this.color,
    required this.bg,
    required this.title,
    required this.sub,
    required this.time,
    required this.type,
    required this.read,
  });

  final IconData icon;
  final Color color;
  final Color bg;
  final String title;
  final String sub;
  final String time;
  final String type;
  final bool read;
}

const List<String> alertFilters = ['Todos', 'Sistema', 'Seguridad', 'Archivos', 'HPC', 'Sync'];

const List<AlertItem> mockAlerts = [
  AlertItem(
    icon: Icons.memory,
    color: Color(0xFF34A853),
    bg: Color(0xFFE6F4EA),
    title: 'Trabajo HPC completado',
    sub: 'JOB-2045 — Genómica comparativa',
    time: 'hace 1 min',
    type: 'HPC',
    read: false,
  ),
  AlertItem(
    icon: Icons.warning_amber_outlined,
    color: Color(0xFFEA4335),
    bg: Color(0xFFFDE8E7),
    title: 'CPU al 94% en nodo 15',
    sub: 'Alerta de rendimiento crítico',
    time: 'hace 4 min',
    type: 'Sistema',
    read: false,
  ),
  AlertItem(
    icon: Icons.sd_storage_outlined,
    color: Color(0xFFFBBC04),
    bg: Color(0xFFFEF9E7),
    title: 'Cuota al 85% de capacidad',
    sub: '12.75 GB de 15 GB utilizados',
    time: 'hace 18 min',
    type: 'Sistema',
    read: false,
  ),
  AlertItem(
    icon: Icons.refresh,
    color: Color(0xFFEA4335),
    bg: Color(0xFFFDE8E7),
    title: 'Error de sincronización',
    sub: 'modelo_molecular.cpp — Conflicto v38 vs v39',
    time: 'hace 1 h',
    type: 'Sync',
    read: true,
  ),
  AlertItem(
    icon: Icons.share_outlined,
    color: Color(0xFF1A73E8),
    bg: Color(0xFFE8F0FE),
    title: 'Archivo compartido',
    sub: 'datos_sensores.csv compartido por M. López',
    time: 'hace 2 h',
    type: 'Archivos',
    read: true,
  ),
  AlertItem(
    icon: Icons.login,
    color: Color(0xFF9C27B0),
    bg: Color(0xFFF3E5F5),
    title: 'Nuevo inicio de sesión',
    sub: 'PC-Lab-UPB-02 · Medellín, CO',
    time: 'hace 3 h',
    type: 'Seguridad',
    read: true,
  ),
  AlertItem(
    icon: Icons.build_outlined,
    color: Color(0xFFFBBC04),
    bg: Color(0xFFFEF9E7),
    title: 'Streaming en mantenimiento',
    sub: 'Restauración estimada: 22:00',
    time: 'hace 4 h',
    type: 'Sistema',
    read: true,
  ),
  AlertItem(
    icon: Icons.insights_outlined,
    color: Color(0xFFEA4335),
    bg: Color(0xFFFDE8E7),
    title: 'Trabajo HPC fallido',
    sub: 'JOB-2043 — Redes neuronales sísmicas',
    time: 'Ayer',
    type: 'HPC',
    read: true,
  ),
];

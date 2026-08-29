import 'package:flutter/material.dart';

enum SyncStatus { synced, pending, conflict, error, syncing, offline }

class SyncStatusStyle {
  const SyncStatusStyle({required this.label, required this.color, required this.bg});

  final String label;
  final Color color;
  final Color bg;
}

const Map<SyncStatus, SyncStatusStyle> syncStatusStyles = {
  SyncStatus.synced: SyncStatusStyle(
    label: 'Sincronizado',
    color: Color(0xFF34A853),
    bg: Color(0xFFE6F4EA),
  ),
  SyncStatus.pending: SyncStatusStyle(
    label: 'Pendiente',
    color: Color(0xFFFBBC04),
    bg: Color(0xFFFEF9E7),
  ),
  SyncStatus.conflict: SyncStatusStyle(
    label: 'Conflicto',
    color: Color(0xFFEA4335),
    bg: Color(0xFFFDE8E7),
  ),
  SyncStatus.error: SyncStatusStyle(
    label: 'Error',
    color: Color(0xFFEA4335),
    bg: Color(0xFFFDE8E7),
  ),
  SyncStatus.syncing: SyncStatusStyle(
    label: 'Sincronizando…',
    color: Color(0xFF1A73E8),
    bg: Color(0xFFE8F0FE),
  ),
  SyncStatus.offline: SyncStatusStyle(
    label: 'Sin conexión',
    color: Color(0xFF5F6368),
    bg: Color(0xFFF8F9FA),
  ),
};

class SyncItem {
  const SyncItem({required this.name, required this.status});

  final String name;
  final SyncStatus status;
}

const List<SyncItem> mockSyncItems = [
  SyncItem(name: 'Proyecto Clima 2025', status: SyncStatus.synced),
  SyncItem(name: 'datos_sensores.csv', status: SyncStatus.pending),
  SyncItem(name: 'modelo_molecular.cpp', status: SyncStatus.conflict),
  SyncItem(name: 'Scripts HPC', status: SyncStatus.error),
  SyncItem(name: 'Resultados Genómica', status: SyncStatus.syncing),
];

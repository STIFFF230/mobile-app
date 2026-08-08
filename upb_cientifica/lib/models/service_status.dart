import 'package:flutter/material.dart';

enum ServiceHealth { ok, warn, error }

extension ServiceHealthColor on ServiceHealth {
  Color get color {
    switch (this) {
      case ServiceHealth.ok:
        return const Color(0xFF34A853);
      case ServiceHealth.warn:
        return const Color(0xFFFBBC04);
      case ServiceHealth.error:
        return const Color(0xFFEA4335);
    }
  }
}

class ServiceStatusEntry {
  const ServiceStatusEntry({
    required this.name,
    required this.status,
    required this.responseTime,
    required this.checkedAt,
  });

  final String name;
  final ServiceHealth status;
  final String responseTime;
  final String checkedAt;
}

const List<ServiceStatusEntry> mockServices = [
  ServiceStatusEntry(name: 'Shared File', status: ServiceHealth.ok, responseTime: '12 ms', checkedAt: 'hace 1 min'),
  ServiceStatusEntry(name: 'File Sync', status: ServiceHealth.ok, responseTime: '28 ms', checkedAt: 'hace 1 min'),
  ServiceStatusEntry(name: 'Photo Album', status: ServiceHealth.ok, responseTime: '18 ms', checkedAt: 'hace 1 min'),
  ServiceStatusEntry(name: 'Streaming', status: ServiceHealth.warn, responseTime: '284 ms', checkedAt: 'hace 2 min'),
  ServiceStatusEntry(name: 'Autenticación', status: ServiceHealth.ok, responseTime: '9 ms', checkedAt: 'hace 1 min'),
  ServiceStatusEntry(name: 'Clúster HPC', status: ServiceHealth.ok, responseTime: '41 ms', checkedAt: 'hace 1 min'),
  ServiceStatusEntry(name: 'API principal', status: ServiceHealth.ok, responseTime: '7 ms', checkedAt: 'hace 1 min'),
];

class MetricCardData {
  const MetricCardData({
    required this.label,
    required this.value,
    required this.color,
    required this.data,
  });

  final String label;
  final String value;
  final Color color;
  final List<double> data;
}

const List<MetricCardData> mockMetricCards = [
  MetricCardData(label: 'CPU', value: '74%', color: Color(0xFF1A73E8), data: [45, 62, 58, 71, 68, 74, 74]),
  MetricCardData(label: 'Memoria', value: '68%', color: Color(0xFF9C27B0), data: [50, 55, 60, 62, 65, 67, 68]),
  MetricCardData(label: 'Almacenamiento', value: '16%', color: Color(0xFF34A853), data: [12, 13, 14, 14, 15, 16, 16]),
  MetricCardData(label: 'Red I/O', value: '2.1 GB/s', color: Color(0xFFFBBC04), data: [0.8, 1.2, 1.8, 2.4, 1.6, 2.0, 2.1]),
];

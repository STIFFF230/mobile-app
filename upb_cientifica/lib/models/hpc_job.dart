import 'package:flutter/material.dart';

enum HpcJobStatus { queue, running, done, failed }

class HpcStatusStyle {
  const HpcStatusStyle({required this.label, required this.color, required this.bg});

  final String label;
  final Color color;
  final Color bg;
}

const Map<HpcJobStatus, HpcStatusStyle> hpcStatusStyles = {
  HpcJobStatus.queue: HpcStatusStyle(
    label: 'En cola',
    color: Color(0xFF856D00),
    bg: Color(0xFFFEF9E7),
  ),
  HpcJobStatus.running: HpcStatusStyle(
    label: 'Ejecutando',
    color: Color(0xFF1A73E8),
    bg: Color(0xFFE8F0FE),
  ),
  HpcJobStatus.done: HpcStatusStyle(
    label: 'Completado',
    color: Color(0xFF34A853),
    bg: Color(0xFFE6F4EA),
  ),
  HpcJobStatus.failed: HpcStatusStyle(
    label: 'Fallido',
    color: Color(0xFFEA4335),
    bg: Color(0xFFFDE8E7),
  ),
};

class HpcJob {
  const HpcJob({
    required this.id,
    required this.name,
    required this.language,
    required this.processes,
    required this.sentAt,
    required this.elapsed,
    required this.status,
    required this.progress,
    required this.user,
  });

  final String id;
  final String name;
  final String language;
  final int processes;
  final String sentAt;
  final String elapsed;
  final HpcJobStatus status;
  final int progress;
  final String user;
}

const List<HpcJob> mockHpcJobs = [
  HpcJob(
    id: 'JOB-2047',
    name: 'Análisis climático ENSO',
    language: 'Python',
    processes: 64,
    sentAt: '30 jul, 09:14',
    elapsed: '2h 18m',
    status: HpcJobStatus.running,
    progress: 68,
    user: 'S. García',
  ),
  HpcJob(
    id: 'JOB-2046',
    name: 'Plegamiento proteína β',
    language: 'C++',
    processes: 128,
    sentAt: '30 jul, 07:00',
    elapsed: '4h 32m',
    status: HpcJobStatus.running,
    progress: 91,
    user: 'M. López',
  ),
  HpcJob(
    id: 'JOB-2045',
    name: 'Genómica comparativa',
    language: 'R',
    processes: 32,
    sentAt: '29 jul, 23:00',
    elapsed: '8h 12m',
    status: HpcJobStatus.done,
    progress: 100,
    user: 'P. Herrera',
  ),
  HpcJob(
    id: 'JOB-2044',
    name: 'Monte Carlo partículas',
    language: 'Fortran',
    processes: 256,
    sentAt: '29 jul, 18:30',
    elapsed: '—',
    status: HpcJobStatus.queue,
    progress: 0,
    user: 'S. García',
  ),
  HpcJob(
    id: 'JOB-2043',
    name: 'Redes neuronales sísmicas',
    language: 'Python',
    processes: 48,
    sentAt: '29 jul, 12:00',
    elapsed: '3h 04m',
    status: HpcJobStatus.failed,
    progress: 38,
    user: 'C. Reyes',
  ),
  HpcJob(
    id: 'JOB-2042',
    name: 'Simulación fluidos CFD',
    language: 'C++',
    processes: 96,
    sentAt: '28 jul, 08:00',
    elapsed: '11h 22m',
    status: HpcJobStatus.done,
    progress: 100,
    user: 'M. López',
  ),
];

const List<String> hpcJobFilters = ['Todos', 'En cola', 'Ejecutando', 'Completados', 'Fallidos'];

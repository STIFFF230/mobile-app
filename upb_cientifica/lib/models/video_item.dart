import 'package:flutter/material.dart';

class VideoItem {
  const VideoItem({
    required this.title,
    required this.project,
    required this.author,
    required this.duration,
    required this.access,
    required this.date,
    required this.color,
    required this.emoji,
  });

  final String title;
  final String project;
  final String author;
  final String duration;
  final String access;
  final String date;
  final Color color;
  final String emoji;
}

const List<VideoItem> mockVideos = [
  VideoItem(
    title: 'Simulación de dinámica molecular: Proteínas de membrana',
    project: 'Bioinformática UPB',
    author: 'Dr. M. López',
    duration: '48:32',
    access: 'Grupo',
    date: '28 jul 2025',
    color: Color(0xFFE8F0FE),
    emoji: '🧬',
  ),
  VideoItem(
    title: 'Análisis de datos climáticos con Python y Dask',
    project: 'Clima 2025',
    author: 'S. García',
    duration: '1:12:04',
    access: 'Público',
    date: '25 jul 2025',
    color: Color(0xFFE6F4EA),
    emoji: '🌍',
  ),
  VideoItem(
    title: 'Introducción a MPI: Paralelización científica',
    project: 'HPC Education',
    author: 'Ing. C. Reyes',
    duration: '2:03:17',
    access: 'Institucional',
    date: '20 jul 2025',
    color: Color(0xFFF3E5F5),
    emoji: '💻',
  ),
  VideoItem(
    title: 'Resultados: Genómica comparativa de hongos patógenos',
    project: 'Genómica UPB',
    author: 'Dra. P. Herrera',
    duration: '34:58',
    access: 'Restringido',
    date: '15 jul 2025',
    color: Color(0xFFFDE8E7),
    emoji: '🔬',
  ),
];

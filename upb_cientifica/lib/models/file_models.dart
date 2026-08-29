import 'package:flutter/material.dart';

class FolderEntry {
  const FolderEntry({
    required this.name,
    required this.fileCount,
    required this.modified,
  });

  final String name;
  final int fileCount;
  final String modified;
}

class FileEntry {
  const FileEntry({
    required this.name,
    required this.type,
    required this.size,
    required this.date,
    required this.owner,
    required this.synced,
    required this.icon,
    required this.color,
  });

  final String name;
  final String type;
  final String size;
  final String date;
  final String owner;
  final bool synced;
  final IconData icon;
  final Color color;
}

const List<FolderEntry> mockFolders = [
  FolderEntry(name: 'Proyecto Clima 2025', fileCount: 48, modified: '30 jul'),
  FolderEntry(name: 'Genómica UPB', fileCount: 203, modified: '29 jul'),
  FolderEntry(name: 'Modelos Moleculares', fileCount: 17, modified: '28 jul'),
];

const List<FileEntry> mockFiles = [
  FileEntry(
    name: 'simulacion_climatica.py',
    type: 'Código',
    size: '14 KB',
    date: '30 jul',
    owner: 'S. García',
    synced: true,
    icon: Icons.code,
    color: Color(0xFF1A73E8),
  ),
  FileEntry(
    name: 'datos_sensores.csv',
    type: 'Dataset',
    size: '2.4 MB',
    date: '30 jul',
    owner: 'S. García',
    synced: true,
    icon: Icons.storage,
    color: Color(0xFF34A853),
  ),
  FileEntry(
    name: 'modelo_molecular.cpp',
    type: 'Código',
    size: '38 KB',
    date: '29 jul',
    owner: 'S. García',
    synced: false,
    icon: Icons.code,
    color: Color(0xFF1A73E8),
  ),
  FileEntry(
    name: 'resultados_genomica.zip',
    type: 'Archivo',
    size: '2.1 GB',
    date: '28 jul',
    owner: 'M. López',
    synced: true,
    icon: Icons.description_outlined,
    color: Color(0xFF5F6368),
  ),
  FileEntry(
    name: 'presentacion_proyecto.mp4',
    type: 'Video',
    size: '480 MB',
    date: '27 jul',
    owner: 'S. García',
    synced: true,
    icon: Icons.videocam_outlined,
    color: Color(0xFFEA4335),
  ),
  FileEntry(
    name: 'histologia_muestra01.tif',
    type: 'Imagen',
    size: '128 MB',
    date: '26 jul',
    owner: 'C. Reyes',
    synced: true,
    icon: Icons.image_outlined,
    color: Color(0xFFFBBC04),
  ),
];

const List<String> fileFilters = [
  'Todos',
  'Documentos',
  'Imágenes',
  'Videos',
  'Código',
  'Datasets',
];

const List<String> fileMenuActions = [
  'Abrir',
  'Descargar',
  'Compartir',
  'Renombrar',
  'Mover',
  'Versiones',
  'Permisos',
  'Eliminar',
];

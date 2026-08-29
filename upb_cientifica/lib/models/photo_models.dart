import 'package:flutter/material.dart';

class PhotoAlbum {
  const PhotoAlbum({required this.name, required this.count, required this.color});

  final String name;
  final int count;
  final Color color;
}

const List<PhotoAlbum> mockAlbums = [
  PhotoAlbum(name: 'Análisis Histológico', count: 128, color: Color(0xFFE8F0FE)),
  PhotoAlbum(name: 'Microscopía Electrónica', count: 64, color: Color(0xFFE6F4EA)),
  PhotoAlbum(name: 'Muestras de Campo', count: 37, color: Color(0xFFFEF9E7)),
  PhotoAlbum(name: 'Presentaciones', count: 22, color: Color(0xFFF3E5F5)),
];

const List<String> photoTabs = ['Álbumes', 'Recientes', 'Proyectos', 'Favoritos', 'Compartidos'];

/// Colores de relleno usados como miniaturas de fotografías científicas
/// (evita depender de imágenes remotas de terceros).
const List<Color> mockPhotoSwatches = [
  Color(0xFFB8CFF3),
  Color(0xFFA8D8B9),
  Color(0xFFF6D488),
  Color(0xFFE8B4C8),
  Color(0xFFC9B8E8),
  Color(0xFF9AD0D6),
  Color(0xFFE0A6A0),
  Color(0xFFB3C7E6),
  Color(0xFFCDE0A3),
];

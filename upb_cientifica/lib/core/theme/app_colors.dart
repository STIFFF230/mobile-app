import 'package:flutter/material.dart';

/// Paleta de colores de UPB Científica, tomada del boceto de referencia.
abstract final class AppColors {
  // Color principal
  static const Color blue = Color(0xFF1A73E8);
  static const Color blueDark = Color(0xFF0D47A1);
  static const Color blueLight = Color(0xFFE8F0FE);

  // Fondos
  static const Color white = Color(0xFFFFFFFF);
  static const Color background = Color(0xFFF8F9FA);

  // Textos
  static const Color textPrimary = Color(0xFF202124);
  static const Color textSecondary = Color(0xFF5F6368);
  static const Color textMuted = Color(0xFF9AA0A6);

  // Bordes
  static const Color border = Color(0xFFDADCE0);
  static const Color divider = Color(0xFFF0F0F0);

  // Estados
  static const Color success = Color(0xFF34A853);
  static const Color successLight = Color(0xFFE6F4EA);
  static const Color warning = Color(0xFFFBBC04);
  static const Color warningDark = Color(0xFF856D00);
  static const Color warningLight = Color(0xFFFEF9E7);
  static const Color error = Color(0xFFEA4335);
  static const Color errorLight = Color(0xFFFDE8E7);

  // Acentos adicionales usados en tarjetas de acceso rápido / categorías
  static const Color purple = Color(0xFF9C27B0);
  static const Color purpleLight = Color(0xFFF3E5F5);
  static const Color teal = Color(0xFF00897B);
  static const Color tealLight = Color(0xFFE0F2F1);

  static const LinearGradient brandGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [blue, blueDark],
  );
}

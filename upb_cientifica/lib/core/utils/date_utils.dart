const List<String> _weekdaysEs = [
  'lunes',
  'martes',
  'miércoles',
  'jueves',
  'viernes',
  'sábado',
  'domingo',
];

const List<String> _monthsEs = [
  'enero',
  'febrero',
  'marzo',
  'abril',
  'mayo',
  'junio',
  'julio',
  'agosto',
  'septiembre',
  'octubre',
  'noviembre',
  'diciembre',
];

/// Formatea una fecha como "viernes, 8 de agosto" (es-CO), sin depender del
/// paquete intl.
String formatSpanishLongDate(DateTime date) {
  final weekday = _weekdaysEs[date.weekday - 1];
  final month = _monthsEs[date.month - 1];
  return '$weekday, ${date.day} de $month';
}

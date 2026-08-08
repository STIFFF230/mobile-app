// Prueba de humo: verifica que la app arranca y muestra el splash inicial.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:upb_cientifica/app.dart';

void main() {
  testWidgets('La app arranca y muestra la pantalla de splash', (WidgetTester tester) async {
    await tester.pumpWidget(const UpbCientificaApp());

    expect(find.text('UPB Científica'), findsOneWidget);
    expect(find.byIcon(Icons.cloud), findsOneWidget);

    // Deja que el temporizador del splash (3s) se complete para no dejar
    // timers pendientes al finalizar la prueba.
    await tester.pump(const Duration(seconds: 4));
  });
}

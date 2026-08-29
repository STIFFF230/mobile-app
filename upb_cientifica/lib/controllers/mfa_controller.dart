import 'package:flutter/material.dart';

/// Controlador del código de verificación de 6 dígitos (MFA).
class MfaController extends ChangeNotifier {
  MfaController({required this.onComplete});

  /// Se invoca automáticamente cuando los 6 dígitos han sido ingresados.
  final VoidCallback onComplete;

  final List<TextEditingController> digitControllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());

  String get code => digitControllers.map((c) => c.text).join();

  void onDigitChanged(int index, String value) {
    if (value.isNotEmpty && index < 5) {
      focusNodes[index + 1].requestFocus();
    }
    notifyListeners();
    if (digitControllers.every((c) => c.text.isNotEmpty)) {
      Future.delayed(const Duration(milliseconds: 400), onComplete);
    }
  }

  void onBackspace(int index) {
    if (digitControllers[index].text.isEmpty && index > 0) {
      focusNodes[index - 1].requestFocus();
    }
  }

  @override
  void dispose() {
    for (final c in digitControllers) {
      c.dispose();
    }
    for (final f in focusNodes) {
      f.dispose();
    }
    super.dispose();
  }
}

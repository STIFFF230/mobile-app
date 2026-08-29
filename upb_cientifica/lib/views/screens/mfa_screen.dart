import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../controllers/mfa_controller.dart';
import '../../core/navigation/navigation_controller.dart';
import '../../core/navigation/screen.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';

/// Verificación en dos pasos con código de 6 dígitos, equivalente a
/// screens/MFAScreen.tsx.
class MfaScreen extends StatelessWidget {
  const MfaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = context.read<NavigationController>();
    return ChangeNotifierProvider(
      create: (_) => MfaController(onComplete: () => nav.navigate(AppScreen.dashboard)),
      child: const _MfaView(),
    );
  }
}

class _MfaView extends StatelessWidget {
  const _MfaView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
          child: Column(
            children: [
              Container(
                width: 72,
                height: 72,
                alignment: Alignment.center,
                decoration: BoxDecoration(color: AppColors.blueLight, borderRadius: BorderRadius.circular(20)),
                child: const Icon(Icons.shield_outlined, color: AppColors.blue, size: 36),
              ),
              const SizedBox(height: 24),
              const Text(
                'Verificación en dos pasos',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  'Ingresa el código de 6 dígitos enviado a tu dispositivo registrado',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13, color: AppColors.textSecondary, height: 1.5),
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 0; i < 6; i++) ...[
                    _DigitField(index: i),
                    if (i < 5) const SizedBox(width: 10),
                  ],
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('¿No recibiste el código? ', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: Size.zero),
                    child: const Text('Reenviar', style: TextStyle(fontSize: 12)),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => context.read<NavigationController>().navigate(AppScreen.dashboard),
                  child: const Text('Verificar'),
                ),
              ),
              const Spacer(),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(AppRadius.sm)),
                child: const Row(
                  children: [
                    Icon(Icons.shield_outlined, size: 14, color: AppColors.success),
                    SizedBox(width: 8),
                    Text(
                      'Sesión protegida · Expira en 4:58',
                      style: TextStyle(fontSize: 11, color: AppColors.success, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DigitField extends StatelessWidget {
  const _DigitField({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MfaController>();
    final filled = controller.digitControllers[index].text.isNotEmpty;

    return SizedBox(
      width: 44,
      height: 54,
      child: Focus(
        skipTraversal: true,
        canRequestFocus: false,
        onKeyEvent: (node, event) {
          if (event is KeyDownEvent && event.logicalKey == LogicalKeyboardKey.backspace) {
            controller.onBackspace(index);
          }
          return KeyEventResult.ignored;
        },
        child: TextField(
        controller: controller.digitControllers[index],
        focusNode: controller.focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700, fontFamily: monoFontFamily),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onChanged: (value) => controller.onDigitChanged(index, value),
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: filled ? AppColors.blueLight : AppColors.background,
          contentPadding: EdgeInsets.zero,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
            borderSide: BorderSide(color: filled ? AppColors.blue : AppColors.border, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
            borderSide: BorderSide(color: filled ? AppColors.blue : AppColors.border, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
            borderSide: const BorderSide(color: AppColors.blue, width: 2),
          ),
        ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/navigation/navigation_controller.dart';
import '../../core/navigation/screen.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../models/admin_models.dart';
import '../widgets/common_widgets.dart';

/// Perfil y seguridad del usuario, equivalente a screens/ProfileScreen.tsx.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = context.read<NavigationController>();

    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 36),
          decoration: const BoxDecoration(gradient: AppColors.brandGradient),
          child: const Column(
            children: [
              _AvatarLarge(),
              SizedBox(height: 12),
              Text('Stiven García', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white)),
              SizedBox(height: 4),
              Text('stiven.garcia@upb.edu.co', style: TextStyle(fontSize: 13, color: Colors.white70)),
              SizedBox(height: 10),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 12,
                children: [
                  _ProfileTag('Investigador'),
                  _ProfileTag('Grupo Clima · UPB'),
                ],
              ),
            ],
          ),
        ),
        Transform.translate(
          offset: const Offset(0, -16),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: AppCard(
              radius: AppRadius.xl,
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionLabel('Servicios autorizados'),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      for (final s in authorizedServices)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(color: AppColors.blueLight, borderRadius: BorderRadius.circular(AppRadius.round)),
                          child: Text(s, style: const TextStyle(fontSize: 11, color: AppColors.blue, fontWeight: FontWeight.w500)),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
          child: AppCard(
            radius: AppRadius.lg,
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('DISPOSITIVOS', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textSecondary, letterSpacing: 0.4)),
                  ),
                ),
                const Divider(height: 1),
                for (var i = 0; i < mockDevices.length; i++)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    decoration: i < mockDevices.length - 1 ? const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.divider))) : null,
                    child: Row(
                      children: [
                        Icon(Icons.desktop_windows_outlined, size: 18, color: mockDevices[i].active ? AppColors.blue : AppColors.textMuted),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(mockDevices[i].name, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.textPrimary)),
                              Text(mockDevices[i].type, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                            ],
                          ),
                        ),
                        if (mockDevices[i].active) const StatusPill(label: 'Activo', color: AppColors.success, background: AppColors.successLight, fontSize: 10),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
          child: AppCard(
            radius: AppRadius.lg,
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                for (var i = 0; i < securityOptions.length; i++)
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: i < securityOptions.length - 1 ? const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.divider))) : null,
                    child: Row(
                      children: [
                        Icon(securityOptions[i].icon, size: 18, color: securityOptions[i].color ?? AppColors.textSecondary),
                        const SizedBox(width: 12),
                        Expanded(child: Text(securityOptions[i].label, style: const TextStyle(fontSize: 13, color: AppColors.textPrimary))),
                        const Icon(Icons.chevron_right, size: 14, color: AppColors.border),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(color: AppColors.successLight, borderRadius: BorderRadius.circular(AppRadius.md)),
            child: const Row(
              children: [
                Icon(Icons.lock_outline, size: 16, color: AppColors.success),
                SizedBox(width: 10),
                Expanded(
                  child: Text('Copias de seguridad protegidas mediante cifrado GPG', style: TextStyle(fontSize: 12, color: AppColors.success, fontWeight: FontWeight.w500)),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
          child: ElevatedButton(
            onPressed: () => nav.navigate(AppScreen.admin),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.textPrimary),
            child: const Text('Administración del sistema →'),
          ),
        ),
      ],
    );
  }
}

class _AvatarLarge extends StatelessWidget {
  const _AvatarLarge();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      height: 72,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.25),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withValues(alpha: 0.5), width: 3),
      ),
      child: const Text('SG', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: Colors.white)),
    );
  }
}

class _ProfileTag extends StatelessWidget {
  const _ProfileTag(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(12)),
      child: Text(label, style: const TextStyle(fontSize: 11, color: Colors.white)),
    );
  }
}

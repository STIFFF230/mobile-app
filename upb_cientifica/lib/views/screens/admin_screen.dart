import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../models/admin_models.dart';
import '../widgets/common_widgets.dart';
import '../widgets/logo_mark.dart';

class _AdminBadge {
  const _AdminBadge(this.label, this.color);

  final String label;
  final Color color;
}

const List<_AdminBadge> _headerBadges = [
  _AdminBadge('47 usuarios', AppColors.success),
  _AdminBadge('16 nodos', AppColors.blue),
  _AdminBadge('3 alertas', AppColors.error),
];

/// Vista de administrador del sistema, equivalente a
/// screens/AdminScreen.tsx.
class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Container(
          width: double.infinity,
          color: AppColors.textPrimary,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('PANEL DE', style: TextStyle(fontSize: 11, color: AppColors.textMuted, letterSpacing: 0.6)),
              const SizedBox(height: 4),
              const Text('Administración', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white)),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                children: [
                  for (final b in _headerBadges)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(color: b.color.withValues(alpha: 0.13), borderRadius: BorderRadius.circular(AppRadius.round)),
                      child: Text(b.label, style: TextStyle(fontSize: 11, color: b.color)),
                    ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: AppCard(
            radius: AppRadius.lg,
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.divider))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Usuarios recientes', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: Size.zero),
                        child: const Text('Ver todos', style: TextStyle(fontSize: 12)),
                      ),
                    ],
                  ),
                ),
                for (var i = 0; i < mockAdminUsers.length; i++)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: i < mockAdminUsers.length - 1 ? const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.divider))) : null,
                    child: Row(
                      children: [
                        UserAvatar(size: 36, initials: mockAdminUsers[i].initials),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(mockAdminUsers[i].name, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.textPrimary)),
                              Text(mockAdminUsers[i].role, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                            ],
                          ),
                        ),
                        StatusPill(
                          label: mockAdminUsers[i].active ? 'activo' : 'suspendido',
                          color: mockAdminUsers[i].active ? AppColors.success : AppColors.error,
                          background: mockAdminUsers[i].active ? AppColors.successLight : AppColors.errorLight,
                          fontSize: 10,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: AppCard(
            radius: AppRadius.lg,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Almacenamiento global', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                const SizedBox(height: 12),
                for (final q in mockQuotas) ...[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(q.name, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                            Text('${q.used}/${q.total} GB', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: q.color)),
                          ],
                        ),
                        const SizedBox(height: 4),
                        ThinProgressBar(
                          value: q.used / q.total,
                          color: (q.used / q.total) > 0.8 ? AppColors.error : q.color,
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
          child: AppCard(
            radius: AppRadius.lg,
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                for (var i = 0; i < adminOptions.length; i++)
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: i < adminOptions.length - 1 ? const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.divider))) : null,
                    child: Row(
                      children: [
                        IconTile(icon: adminOptions[i].icon, color: adminOptions[i].color, size: 36, iconSize: 18),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(adminOptions[i].label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.textPrimary)),
                              Text(adminOptions[i].sub, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                            ],
                          ),
                        ),
                        const Icon(Icons.chevron_right, size: 14, color: AppColors.border),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

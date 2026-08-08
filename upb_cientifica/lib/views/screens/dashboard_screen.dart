import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/navigation/navigation_controller.dart';
import '../../core/navigation/screen.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/date_utils.dart';
import '../../models/activity_item.dart';
import '../widgets/common_widgets.dart';

class _QuickLink {
  const _QuickLink(this.icon, this.label, this.color, this.bg, this.screen);

  final IconData icon;
  final String label;
  final Color color;
  final Color bg;
  final AppScreen screen;
}

const List<_QuickLink> _quickLinks = [
  _QuickLink(Icons.share_outlined, 'Compartidos', AppColors.blue, AppColors.blueLight, AppScreen.fileDetail),
  _QuickLink(Icons.refresh, 'Sincronización', AppColors.success, AppColors.successLight, AppScreen.sync),
  _QuickLink(Icons.image_outlined, 'Álbum', AppColors.warning, AppColors.warningLight, AppScreen.photos),
  _QuickLink(Icons.play_circle_outline, 'Streaming', AppColors.error, AppColors.errorLight, AppScreen.streaming),
  _QuickLink(Icons.memory, 'HPC', AppColors.purple, AppColors.purpleLight, AppScreen.hpc),
  _QuickLink(Icons.monitor_heart_outlined, 'Monitoreo', AppColors.teal, AppColors.tealLight, AppScreen.monitoring),
];

/// Pantalla principal / dashboard, equivalente a screens/DashboardScreen.tsx.
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const used = 2.4;
    const total = 15.0;
    const pct = used / total;
    final nav = context.read<NavigationController>();

    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  formatSpanishLongDate(DateTime.now()),
                  style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Buenos días, Stiven',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Almacenamiento', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                            const SizedBox(height: 4),
                            RichText(
                              text: const TextSpan(
                                children: [
                                  TextSpan(
                                    text: '$used GB ',
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                                  ),
                                  TextSpan(
                                    text: 'de $total GB',
                                    style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: const [
                          _StatusRow(label: 'Sincronizado'),
                          SizedBox(height: 4),
                          _StatusRow(label: 'Red UPB activa'),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  ThinProgressBar(value: pct, color: pct > 0.8 ? AppColors.warning : AppColors.blue),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('1.847 archivos', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                      Text('${(pct * 100).toStringAsFixed(0)}% utilizado', style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Divider(height: 1),
                  const SizedBox(height: 12),
                  const Row(
                    children: [
                      _StorageStat(value: '423', label: 'Documentos'),
                      _StorageStat(value: '689', label: 'Imágenes'),
                      _StorageStat(value: '312', label: 'Código'),
                      _StorageStat(value: '98', label: 'Datasets'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Acceso rápido', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                const SizedBox(height: 12),
                GridView.count(
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1.05,
                  children: [
                    for (final link in _quickLinks)
                      AppCard(
                        radius: AppRadius.lg,
                        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
                        onTap: () => nav.navigate(link.screen),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconTile(icon: link.icon, color: link.color, background: link.bg, size: 40, iconSize: 20, radius: AppRadius.md),
                            const SizedBox(height: 8),
                            Text(
                              link.label,
                              style: const TextStyle(fontSize: 11, color: AppColors.textPrimary, fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Actividad reciente', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                const SizedBox(height: 12),
                Column(
                  children: [
                    for (final item in mockActivity) ...[
                      _ActivityTile(item: item),
                      if (item != mockActivity.last) const SizedBox(height: 8),
                    ],
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: AppColors.brandGradient,
                borderRadius: BorderRadius.circular(AppRadius.xl),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Clúster HPC', style: TextStyle(fontSize: 12, color: Colors.white70)),
                            SizedBox(height: 4),
                            Text('3 trabajos activos', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white)),
                          ],
                        ),
                      ),
                      const Icon(Icons.memory, color: Colors.white54, size: 32),
                    ],
                  ),
                  const SizedBox(height: 14),
                  const Row(
                    children: [
                      _HpcStat(value: '3', label: 'Ejecutando', color: Color(0xFF69F0AE)),
                      SizedBox(width: 16),
                      _HpcStat(value: '7', label: 'En cola', color: AppColors.warning),
                      SizedBox(width: 16),
                      _HpcStat(value: '12', label: 'Completados hoy', color: Colors.white70),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Material(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () => nav.navigate(AppScreen.hpc),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Text('Ver trabajos →', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusRow extends StatelessWidget {
  const _StatusRow({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const StatusDot(color: AppColors.success),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 11, color: AppColors.success, fontWeight: FontWeight.w500)),
      ],
    );
  }
}

class _StorageStat extends StatelessWidget {
  const _StorageStat({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(value, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
          const SizedBox(height: 2),
          Text(label, style: const TextStyle(fontSize: 10, color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}

class _ActivityTile extends StatelessWidget {
  const _ActivityTile({required this.item});

  final ActivityItem item;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      radius: AppRadius.md,
      child: Row(
        children: [
          IconTile(icon: item.icon, color: item.color, size: 36, iconSize: 18),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.textPrimary), maxLines: 1, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 2),
                Text(item.sub, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(item.time, style: const TextStyle(fontSize: 10, color: AppColors.textMuted)),
        ],
      ),
    );
  }
}

class _HpcStat extends StatelessWidget {
  const _HpcStat({required this.value, required this.label, required this.color});

  final String value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: color)),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(fontSize: 10, color: Colors.white70)),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/navigation/navigation_controller.dart';
import '../../core/navigation/screen.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../models/service_status.dart';
import '../widgets/common_widgets.dart';

/// Dashboard de monitoreo del sistema, equivalente a
/// screens/MonitoringScreen.tsx.
class MonitoringScreen extends StatelessWidget {
  const MonitoringScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = context.read<NavigationController>();

    return Column(
      children: [
        Container(
          color: AppColors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.monitor_heart_outlined, size: 16, color: AppColors.success),
                  SizedBox(width: 8),
                  Text('Tiempo real', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.textPrimary)),
                  SizedBox(width: 8),
                  StatusDot(color: AppColors.success),
                ],
              ),
              Text('Actualizado: ahora', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 1.4,
                children: [for (final m in mockMetricCards) _MetricCard(data: m)],
              ),
              const SizedBox(height: 16),
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Nodos del clúster', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        for (var i = 0; i < 16; i++) _NodeTile(index: i),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Wrap(
                      spacing: 16,
                      runSpacing: 6,
                      children: [
                        _NodeLegend('Disponibles', 13, AppColors.success),
                        _NodeLegend('En mantenimiento', 2, AppColors.warning),
                        _NodeLegend('Fuera de servicio', 1, AppColors.error),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: _JobsSummaryCard(label: 'Trabajos en ejecución', value: '3', color: AppColors.blue, bg: AppColors.blueLight, onTap: () => nav.navigate(AppScreen.hpc))),
                  const SizedBox(width: 8),
                  Expanded(child: _JobsSummaryCard(label: 'Trabajos en cola', value: '7', color: AppColors.warningDark, bg: AppColors.warningLight, onTap: () => nav.navigate(AppScreen.hpc))),
                ],
              ),
              const SizedBox(height: 16),
              const Text('Estado de servicios', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
              const SizedBox(height: 10),
              for (final s in mockServices) ...[
                _ServiceTile(service: s),
                const SizedBox(height: 6),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({required this.data});

  final MetricCardData data;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(data.label, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary, fontWeight: FontWeight.w500)),
              Text(data.value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: data.color)),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(child: _MiniBarChart(data: data.data, color: data.color)),
        ],
      ),
    );
  }
}

class _MiniBarChart extends StatelessWidget {
  const _MiniBarChart({required this.data, required this.color});

  final List<double> data;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final max = data.reduce((a, b) => a > b ? a : b);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        for (var i = 0; i < data.length; i++)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1.5),
              child: FractionallySizedBox(
                heightFactor: (data[i] / max).clamp(0.05, 1.0),
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: i == data.length - 1 ? 1 : 0.5 + (i / data.length) * 0.5),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _NodeTile extends StatelessWidget {
  const _NodeTile({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final health = index < 13 ? ServiceHealth.ok : index < 15 ? ServiceHealth.warn : ServiceHealth.error;
    final bg = switch (health) {
      ServiceHealth.ok => AppColors.successLight,
      ServiceHealth.warn => AppColors.warningLight,
      ServiceHealth.error => AppColors.errorLight,
    };

    return Container(
      width: 36,
      height: 36,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(AppRadius.sm)),
      child: Text(
        '${index + 1}'.padLeft(2, '0'),
        style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: health.color, fontFamily: monoFontFamily),
      ),
    );
  }
}

class _NodeLegend extends StatelessWidget {
  const _NodeLegend(this.label, this.count, this.color);

  final String label;
  final int count;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        StatusDot(color: color),
        const SizedBox(width: 4),
        Text.rich(
          TextSpan(
            text: '$label: ',
            style: const TextStyle(fontSize: 10, color: AppColors.textSecondary),
            children: [TextSpan(text: '$count', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: color))],
          ),
        ),
      ],
    );
  }
}

class _JobsSummaryCard extends StatelessWidget {
  const _JobsSummaryCard({required this.label, required this.value, required this.color, required this.bg, required this.onTap});

  final String label;
  final String value;
  final Color color;
  final Color bg;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: bg,
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value, style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: color)),
              const SizedBox(height: 4),
              Text(label, style: TextStyle(fontSize: 11, color: color.withValues(alpha: 0.8))),
            ],
          ),
        ),
      ),
    );
  }
}

class _ServiceTile extends StatelessWidget {
  const _ServiceTile({required this.service});

  final ServiceStatusEntry service;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      radius: AppRadius.md,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: [
          StatusDot(color: service.status.color, size: 10, ring: true),
          const SizedBox(width: 10),
          Expanded(child: Text(service.name, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.textPrimary))),
          Text(service.responseTime, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary, fontFamily: monoFontFamily)),
          const SizedBox(width: 8),
          Text(service.checkedAt, style: const TextStyle(fontSize: 10, color: AppColors.textMuted)),
        ],
      ),
    );
  }
}

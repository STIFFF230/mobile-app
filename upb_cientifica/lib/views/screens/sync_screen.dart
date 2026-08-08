import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../models/sync_item.dart';
import '../widgets/common_widgets.dart';

class _SyncOption {
  const _SyncOption(this.icon, this.label, this.sub, {this.toggle = false});

  final IconData icon;
  final String label;
  final String sub;
  final bool toggle;
}

const List<_SyncOption> _options = [
  _SyncOption(Icons.calendar_today_outlined, 'Programar horario', 'Cada día a las 11:00 p. m.'),
  _SyncOption(Icons.folder_open_outlined, 'Elegir carpetas', '3 carpetas seleccionadas'),
  _SyncOption(Icons.wifi, 'Solo por Wi-Fi', 'Activo', toggle: true),
];

/// Centro de sincronización, equivalente a screens/SyncScreen.tsx.
class SyncScreen extends StatelessWidget {
  const SyncScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Container(
          color: AppColors.white,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          StatusDot(color: AppColors.success, size: 10),
                          SizedBox(width: 8),
                          Text('Sincronización activa', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                        ],
                      ),
                      SizedBox(height: 4),
                      Text('Última sync: hoy, 10:42 a. m.', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                    ],
                  ),
                  const Icon(Icons.refresh, color: AppColors.blue, size: 20),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Progreso general', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                  Text('78%', style: TextStyle(fontSize: 12, color: AppColors.blue, fontWeight: FontWeight.w600)),
                ],
              ),
              const SizedBox(height: 6),
              const ThinProgressBar(value: 0.78, color: AppColors.blue),
              const SizedBox(height: 14),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 3.6,
                children: const [
                  _MetaField('Dispositivo', 'PC-Lab-UPB-01'),
                  _MetaField('Carpeta local', '/home/sgarcia/investigacion', mono: true),
                  _MetaField('Repositorio', 'repo://cluster-upb/sgarcia', mono: true),
                  _MetaField('Pendientes', '14 archivos'),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.refresh, size: 14),
                  label: const Text('Sincronizar ahora'),
                  style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(44), textStyle: const TextStyle(fontSize: 13)),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.pause, size: 14),
                  label: const Text('Pausar'),
                  style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(44), textStyle: const TextStyle(fontSize: 13)),
                ),
              ),
            ],
          ),
        ),
        Container(
          color: AppColors.white,
          margin: const EdgeInsets.symmetric(vertical: 4),
          child: Column(
            children: [
              for (var i = 0; i < _options.length; i++)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: i < _options.length - 1
                      ? const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.divider)))
                      : null,
                  child: Row(
                    children: [
                      Icon(_options[i].icon, size: 18, color: AppColors.textSecondary),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(_options[i].label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.textPrimary)),
                            const SizedBox(height: 2),
                            Text(_options[i].sub, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                          ],
                        ),
                      ),
                      if (_options[i].toggle) const SimpleToggle(value: true),
                    ],
                  ),
                ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionLabel('Estado de archivos'),
              const SizedBox(height: 10),
              for (final item in mockSyncItems) ...[
                _SyncTile(item: item),
                const SizedBox(height: 6),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _MetaField extends StatelessWidget {
  const _MetaField(this.label, this.value, {this.mono = false});

  final String label;
  final String value;
  final bool mono;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(label, style: const TextStyle(fontSize: 10, color: AppColors.textMuted)),
        const SizedBox(height: 2),
        Text(
          value,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: mono ? 10 : 12,
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimary,
            fontFamily: mono ? monoFontFamily : null,
          ),
        ),
      ],
    );
  }
}

class _SyncTile extends StatelessWidget {
  const _SyncTile({required this.item});

  final SyncItem item;

  @override
  Widget build(BuildContext context) {
    final style = syncStatusStyles[item.status]!;
    final isProblem = item.status == SyncStatus.conflict || item.status == SyncStatus.error;

    return AppCard(
      radius: AppRadius.md,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: [
          Icon(isProblem ? Icons.warning_amber_outlined : Icons.refresh, size: 18, color: style.color),
          const SizedBox(width: 10),
          Expanded(child: Text(item.name, style: const TextStyle(fontSize: 13, color: AppColors.textPrimary))),
          StatusPill(label: style.label, color: style.color, background: style.bg),
        ],
      ),
    );
  }
}

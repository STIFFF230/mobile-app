import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/job_detail_controller.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../widgets/common_widgets.dart';

const List<String> _logLines = [
  '[09:14:02] Trabajo iniciado en nodo compute-01',
  '[09:14:05] MPI: 64 procesos inicializados',
  '[09:14:08] Cargando datos: datos_sensores.csv',
  '[09:15:32] Iteración 1/1000 completada',
  '[10:22:47] Iteración 680/1000 completada',
  '[10:22:47] Uso de memoria: 87.3 GB / 128 GB',
  '[10:22:48] Checkpointing en /scratch/JOB-2047/ckpt_680.h5',
];

/// Detalle de un trabajo HPC, equivalente a screens/JobDetailScreen.tsx.
class JobDetailScreen extends StatelessWidget {
  const JobDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => JobDetailController(),
      child: const _JobDetailView(),
    );
  }
}

class _JobDetailView extends StatelessWidget {
  const _JobDetailView();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<JobDetailController>();

    return Column(
      children: [
        Container(
          width: double.infinity,
          color: AppColors.blue,
          padding: const EdgeInsets.all(16),
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
                        Text('JOB-2047', style: TextStyle(fontSize: 12, color: Colors.white70, fontFamily: monoFontFamily)),
                        SizedBox(height: 4),
                        Text('Análisis climático ENSO', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)),
                      ],
                    ),
                  ),
                  const StatusPill(label: 'Ejecutando', color: AppColors.blue, background: Colors.white),
                ],
              ),
              const SizedBox(height: 14),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Progreso: 68%', style: TextStyle(fontSize: 12, color: Colors.white70)),
                  Text('~45 min restantes', style: TextStyle(fontSize: 12, color: Colors.white70)),
                ],
              ),
              const SizedBox(height: 6),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: 0.68,
                  minHeight: 8,
                  backgroundColor: Colors.white.withValues(alpha: 0.25),
                  valueColor: const AlwaysStoppedAnimation(Color(0xFF69F0AE)),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: AppColors.white,
            border: Border(bottom: BorderSide(color: AppColors.border)),
          ),
          child: Column(
            children: [
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 3.4,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                children: const [
                  _StatTile(Icons.memory, 'CPU utilizada', '74%', AppColors.blue),
                  _StatTile(Icons.storage, 'Memoria', '87.3 / 128 GB', AppColors.purple),
                  _StatTile(Icons.dns_outlined, 'Nodo asignado', 'compute-01', AppColors.success),
                  _StatTile(Icons.access_time, 'Tiempo transcurrido', '2h 18m', AppColors.warning),
                ],
              ),
              const SizedBox(height: 12),
              const Divider(height: 1),
              const SizedBox(height: 12),
              const Row(
                children: [
                  _MiniField('Procesos MPI', '64'),
                  SizedBox(width: 16),
                  _MiniField('Inicio', '30 jul, 09:14'),
                  SizedBox(width: 16),
                  _MiniField('Usuario', 'S. García'),
                ],
              ),
            ],
          ),
        ),
        UnderlineTabs(options: JobDetailController.tabs, selected: controller.tab, onSelected: controller.setTab),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: _TabContent(tab: controller.tab),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.close, size: 14, color: AppColors.error),
                  label: const Text('Cancelar', style: TextStyle(color: AppColors.error)),
                  style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(44), side: const BorderSide(color: AppColors.error, width: 1.5), textStyle: const TextStyle(fontSize: 13)),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.download_outlined, size: 14),
                  label: const Text('Descargar'),
                  style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(44), textStyle: const TextStyle(fontSize: 13)),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.share_outlined, size: 14),
                  label: const Text('Compartir'),
                  style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(44), textStyle: const TextStyle(fontSize: 13)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile(this.icon, this.label, this.value, this.color);

  final IconData icon;
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconTile(icon: icon, color: color, size: 36, iconSize: 18),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 10, color: AppColors.textMuted)),
              const SizedBox(height: 2),
              Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
            ],
          ),
        ),
      ],
    );
  }
}

class _MiniField extends StatelessWidget {
  const _MiniField(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 10, color: AppColors.textMuted)),
          const SizedBox(height: 2),
          Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.textPrimary)),
        ],
      ),
    );
  }
}

class _TabContent extends StatelessWidget {
  const _TabContent({required this.tab});

  final String tab;

  @override
  Widget build(BuildContext context) {
    switch (tab) {
      case 'Registro':
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(AppRadius.md)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final line in _logLines)
                Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: Text(
                    line,
                    style: TextStyle(
                      fontSize: 11,
                      height: 1.6,
                      fontFamily: monoFontFamily,
                      color: line.contains('completada') ? const Color(0xFF69F0AE) : Colors.white70,
                    ),
                  ),
                ),
              const Text('█', style: TextStyle(fontSize: 11, color: Color(0xFF4CAF50), fontFamily: monoFontFamily)),
            ],
          ),
        );
      case 'Salida':
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(AppRadius.md)),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('ENSO Análisis v2.1 — Modo paralelo', style: TextStyle(fontSize: 11, color: Colors.white70, fontFamily: monoFontFamily, height: 1.6)),
              Text('Cargados 2.847.392 registros de sensores', style: TextStyle(fontSize: 11, color: Colors.white70, fontFamily: monoFontFamily, height: 1.6)),
              Text('Correlación Niño-3.4: 0.847 (p<0.001)', style: TextStyle(fontSize: 11, color: Color(0xFF69F0AE), fontFamily: monoFontFamily, height: 1.6)),
              Text('Anomalía SST máxima: +1.8°C (enero 2024)', style: TextStyle(fontSize: 11, color: Colors.white70, fontFamily: monoFontFamily, height: 1.6)),
            ],
          ),
        );
      case 'Errores':
        return AppCard(
          child: const Center(
            child: Text('✓ Sin errores registrados', style: TextStyle(fontSize: 13, color: AppColors.success)),
          ),
        );
      case 'Resultados':
        const files = ['resultados_parciales_680.h5', 'checkpoint_680.h5', 'figura_correlacion.png'];
        return Column(
          children: [
            for (final f in files) ...[
              AppCard(
                radius: AppRadius.md,
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                child: Row(
                  children: [
                    Expanded(child: Text(f, style: const TextStyle(fontSize: 12, color: AppColors.textPrimary, fontFamily: monoFontFamily))),
                    const Icon(Icons.download_outlined, size: 16, color: AppColors.blue),
                  ],
                ),
              ),
              const SizedBox(height: 8),
            ],
          ],
        );
      default:
        const metrics = [
          ['Eficiencia paralela', '92.3%', 0.923, AppColors.success],
          ['Uso CPU promedio', '74%', 0.74, AppColors.blue],
          ['Uso memoria pico', '68.2%', 0.682, AppColors.purple],
          ['I/O throughput', '2.1 GB/s', 0.6, AppColors.warning],
        ];
        return AppCard(
          child: Column(
            children: [
              for (final m in metrics) ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(m[0] as String, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                        Text(m[1] as String, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: m[3] as Color)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    ThinProgressBar(value: m[2] as double, color: m[3] as Color, height: 6),
                  ],
                ),
                if (m != metrics.last) const SizedBox(height: 14),
              ],
            ],
          ),
        );
    }
  }
}

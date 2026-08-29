import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/video_player_controller.dart' as vp;
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';

/// Reproductor de video científico, equivalente a
/// screens/VideoPlayerScreen.tsx.
class VideoPlayerScreen extends StatelessWidget {
  const VideoPlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => vp.VideoPlayerController(),
      child: const _VideoPlayerView(),
    );
  }
}

class _VideoPlayerView extends StatelessWidget {
  const _VideoPlayerView();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<vp.VideoPlayerController>();

    return Container(
      color: Colors.black,
      child: Column(
        children: [
          GestureDetector(
            onTap: controller.togglePlay,
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF0D1B2A), Color(0xFF1A3A6E)],
                  ),
                ),
                alignment: Alignment.center,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const Text('🧬', style: TextStyle(fontSize: 64)),
                    if (!controller.playing)
                      Container(
                        width: 56,
                        height: 56,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), shape: BoxShape.circle),
                        child: const Icon(Icons.play_arrow, color: Colors.white, size: 24),
                      ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            color: const Color(0xFF111111),
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                GestureDetector(
                  onHorizontalDragUpdate: (details) {
                    final box = context.findRenderObject() as RenderBox?;
                    if (box == null) return;
                    final local = box.globalToLocal(details.globalPosition);
                    controller.setProgress(local.dx / box.size.width);
                  },
                  child: Container(
                    height: 4,
                    decoration: BoxDecoration(color: const Color(0xFF333333), borderRadius: BorderRadius.circular(2)),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: FractionallySizedBox(
                        widthFactor: controller.progress.clamp(0.0, 1.0),
                        child: Container(
                          decoration: BoxDecoration(color: AppColors.blue, borderRadius: BorderRadius.circular(2)),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('15:32', style: TextStyle(fontSize: 11, color: Colors.white54, fontFamily: monoFontFamily)),
                    Text('48:32', style: TextStyle(fontSize: 11, color: Colors.white54, fontFamily: monoFontFamily)),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () => controller.skip(-0.1),
                      icon: const Icon(Icons.skip_previous, color: Colors.white70, size: 22),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      width: 52,
                      height: 52,
                      decoration: const BoxDecoration(color: AppColors.blue, shape: BoxShape.circle),
                      child: IconButton(
                        onPressed: controller.togglePlay,
                        icon: Icon(controller.playing ? Icons.pause : Icons.play_arrow, color: Colors.white, size: 22),
                      ),
                    ),
                    const SizedBox(width: 12),
                    IconButton(
                      onPressed: () => controller.skip(0.1),
                      icon: const Icon(Icons.skip_next, color: Colors.white70, size: 22),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.settings_outlined, size: 14, color: Colors.white54),
                      label: const Text('1080p', style: TextStyle(fontSize: 12, color: Colors.white54)),
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.share_outlined, size: 14, color: Colors.white54),
                      label: const Text('Compartir', style: TextStyle(fontSize: 12, color: Colors.white54)),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.fullscreen, color: Colors.white54, size: 18),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              color: const Color(0xFF1A1A1A),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Simulación de dinámica molecular: Proteínas de membrana',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white, height: 1.4),
                  ),
                  const SizedBox(height: 6),
                  const Text('Dr. M. López · Bioinformática UPB · 28 jul 2025', style: TextStyle(fontSize: 12, color: Colors.white54)),
                  const SizedBox(height: 14),
                  const Row(
                    children: [
                      _InfoField('Acceso', 'Grupo de investigación'),
                      SizedBox(width: 16),
                      _InfoField('Formato', 'MP4 · H.264 · 1080p'),
                      SizedBox(width: 16),
                      _InfoField('Tamaño', '480 MB'),
                    ],
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

class _InfoField extends StatelessWidget {
  const _InfoField(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 10, color: Colors.white38)),
        const SizedBox(height: 2),
        Text(value, style: const TextStyle(fontSize: 12, color: Colors.white70)),
      ],
    );
  }
}

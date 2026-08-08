import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/navigation/navigation_controller.dart';
import '../../core/navigation/screen.dart';
import '../../core/theme/app_colors.dart';

class _TabDef {
  const _TabDef(this.tab, this.label, this.icon);

  final NavTab tab;
  final String label;
  final IconData icon;
}

const List<_TabDef> _tabs = [
  _TabDef(NavTab.inicio, 'Inicio', Icons.home_outlined),
  _TabDef(NavTab.archivos, 'Archivos', Icons.folder_open_outlined),
  _TabDef(NavTab.hpc, 'HPC', Icons.memory_outlined),
  _TabDef(NavTab.monitoreo, 'Monitoreo', Icons.monitor_heart_outlined),
  _TabDef(NavTab.perfil, 'Perfil', Icons.person_outline),
];

/// Barra inferior con 5 pestañas y botón flotante central de acción.
/// Equivalente a components/BottomNav.tsx.
class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = context.watch<NavigationController>();
    final midpoint = _tabs.length ~/ 2;

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      padding: const EdgeInsets.only(bottom: 8),
      child: SafeArea(
        top: false,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            for (final t in _tabs.sublist(0, midpoint))
              _TabButton(tab: t, active: nav.activeTab == t.tab, onTap: () => nav.handleTabPress(t.tab)),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 0),
                  Transform.translate(
                    offset: const Offset(0, -16),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        customBorder: const CircleBorder(),
                        onTap: () => nav.navigate(AppScreen.createJob),
                        child: Container(
                          width: 52,
                          height: 52,
                          decoration: BoxDecoration(
                            color: AppColors.blue,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.blue.withValues(alpha: 0.4),
                                blurRadius: 14,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Icon(Icons.add, color: Colors.white, size: 24),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 3),
                  const Text(
                    'Nuevo',
                    style: TextStyle(fontSize: 10, color: AppColors.blue, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            for (final t in _tabs.sublist(midpoint))
              _TabButton(tab: t, active: nav.activeTab == t.tab, onTap: () => nav.handleTabPress(t.tab)),
          ],
        ),
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  const _TabButton({required this.tab, required this.active, required this.onTap});

  final _TabDef tab;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = active ? AppColors.blue : AppColors.textSecondary;
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 2),
          child: Column(
            children: [
              SizedBox(
                height: 3,
                child: active
                    ? Container(
                        width: 32,
                        decoration: const BoxDecoration(
                          color: AppColors.blue,
                          borderRadius: BorderRadius.vertical(bottom: Radius.circular(4)),
                        ),
                      )
                    : null,
              ),
              const SizedBox(height: 3),
              Icon(tab.icon, size: 22, color: color),
              const SizedBox(height: 3),
              Text(
                tab.label,
                style: TextStyle(fontSize: 10, color: color, fontWeight: active ? FontWeight.w600 : FontWeight.w400),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

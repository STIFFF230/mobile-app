import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/navigation/navigation_controller.dart';
import '../../core/navigation/screen.dart';
import '../../core/theme/app_colors.dart';
import 'logo_mark.dart';

/// Barra superior: logo o botón atrás, título de sección, búsqueda,
/// notificaciones y avatar. Equivalente a components/TopBar.tsx.
class TopBar extends StatelessWidget implements PreferredSizeWidget {
  const TopBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    final nav = context.watch<NavigationController>();

    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          if (nav.showBack)
            IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: nav.goBack,
              icon: const Icon(Icons.chevron_left, color: AppColors.textSecondary, size: 26),
            )
          else
            const LogoMark(size: 28),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              nav.title,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: AppColors.textSecondary, size: 20),
          ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              IconButton(
                onPressed: () => nav.navigate(AppScreen.alerts),
                icon: const Icon(Icons.notifications_none, color: AppColors.textSecondary, size: 20),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: AppColors.error,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1.5),
                  ),
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () => nav.navigate(AppScreen.profile),
            child: const Padding(
              padding: EdgeInsets.only(left: 4),
              child: UserAvatar(),
            ),
          ),
        ],
      ),
    );
  }
}

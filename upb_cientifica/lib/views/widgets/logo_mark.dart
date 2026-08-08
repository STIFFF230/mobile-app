import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

/// Ícono de nube tecnológica de UPB Científica, usado en splash, login,
/// barra superior y encabezado de perfil.
class LogoMark extends StatelessWidget {
  const LogoMark({super.key, this.size = 28, this.iconSize, this.radius});

  final double size;
  final double? iconSize;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: AppColors.brandGradient,
        borderRadius: BorderRadius.circular(radius ?? size * 0.3),
      ),
      child: Icon(Icons.cloud, color: Colors.white, size: iconSize ?? size * 0.55),
    );
  }
}

/// Avatar circular con las iniciales del usuario (SG por defecto).
class UserAvatar extends StatelessWidget {
  const UserAvatar({super.key, this.size = 32, this.initials = 'SG'});

  final double size;
  final String initials;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        gradient: AppColors.brandGradient,
        shape: BoxShape.circle,
      ),
      child: Text(
        initials,
        style: TextStyle(
          color: Colors.white,
          fontSize: size * 0.4,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

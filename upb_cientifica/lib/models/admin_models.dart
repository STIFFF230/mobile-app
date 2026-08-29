import 'package:flutter/material.dart';

class AdminUserEntry {
  const AdminUserEntry({
    required this.name,
    required this.role,
    required this.active,
    required this.initials,
    required this.color,
  });

  final String name;
  final String role;
  final bool active;
  final String initials;
  final Color color;
}

const List<AdminUserEntry> mockAdminUsers = [
  AdminUserEntry(name: 'Stiven García', role: 'Investigador', active: true, initials: 'SG', color: Color(0xFF1A73E8)),
  AdminUserEntry(name: 'María López', role: 'Investigadora', active: true, initials: 'ML', color: Color(0xFF34A853)),
  AdminUserEntry(name: 'Carlos Reyes', role: 'Estudiante', active: true, initials: 'CR', color: Color(0xFF9C27B0)),
  AdminUserEntry(name: 'Paula Herrera', role: 'Investigadora', active: false, initials: 'PH', color: Color(0xFFFBBC04)),
];

class AdminOptionEntry {
  const AdminOptionEntry({
    required this.icon,
    required this.label,
    required this.sub,
    required this.color,
  });

  final IconData icon;
  final String label;
  final String sub;
  final Color color;
}

const List<AdminOptionEntry> adminOptions = [
  AdminOptionEntry(icon: Icons.groups_outlined, label: 'Gestión de usuarios', sub: '47 usuarios activos', color: Color(0xFF1A73E8)),
  AdminOptionEntry(icon: Icons.shield_outlined, label: 'Roles y permisos', sub: '5 roles definidos', color: Color(0xFF9C27B0)),
  AdminOptionEntry(icon: Icons.sd_storage_outlined, label: 'Cuotas de almacenamiento', sub: 'Total: 2.4 TB asignados', color: Color(0xFF34A853)),
  AdminOptionEntry(icon: Icons.dns_outlined, label: 'Servicios del clúster', sub: '6 activos · 1 advertencia', color: Color(0xFFFBBC04)),
  AdminOptionEntry(icon: Icons.notifications_none, label: 'Alertas del sistema', sub: '3 alertas activas', color: Color(0xFFEA4335)),
  AdminOptionEntry(icon: Icons.description_outlined, label: 'Registro de auditoría', sub: '12.847 eventos hoy', color: Color(0xFF5F6368)),
  AdminOptionEntry(icon: Icons.hub_outlined, label: 'Mapa de servicios', sub: 'Visualizar topología', color: Color(0xFF00897B)),
];

class QuotaEntry {
  const QuotaEntry({required this.name, required this.used, required this.total, required this.color});

  final String name;
  final double used;
  final double total;
  final Color color;
}

const List<QuotaEntry> mockQuotas = [
  QuotaEntry(name: 'S. García', used: 2.4, total: 15, color: Color(0xFF1A73E8)),
  QuotaEntry(name: 'M. López', used: 11.2, total: 15, color: Color(0xFF34A853)),
  QuotaEntry(name: 'C. Reyes', used: 4.8, total: 10, color: Color(0xFF9C27B0)),
];

class DeviceEntry {
  const DeviceEntry({required this.name, required this.type, required this.active});

  final String name;
  final String type;
  final bool active;
}

const List<DeviceEntry> mockDevices = [
  DeviceEntry(name: 'PC-Lab-UPB-01', type: 'Escritorio', active: true),
  DeviceEntry(name: 'Laptop Personal', type: 'Portátil', active: false),
  DeviceEntry(name: 'Tablet Samsung', type: 'Tableta', active: false),
];

class SecurityOptionEntry {
  const SecurityOptionEntry({required this.icon, required this.label, this.color});

  final IconData icon;
  final String label;
  final Color? color;
}

const List<SecurityOptionEntry> securityOptions = [
  SecurityOptionEntry(icon: Icons.vpn_key_outlined, label: 'Cambiar contraseña'),
  SecurityOptionEntry(icon: Icons.shield_outlined, label: 'Autenticación de dos factores'),
  SecurityOptionEntry(icon: Icons.vpn_key_outlined, label: 'Administrar tokens API'),
  SecurityOptionEntry(icon: Icons.desktop_windows_outlined, label: 'Sesiones activas'),
  SecurityOptionEntry(icon: Icons.logout, label: 'Cerrar sesión en otros dispositivos', color: Color(0xFFFBBC04)),
  SecurityOptionEntry(icon: Icons.shield_outlined, label: 'Actividad de seguridad'),
];

const List<String> authorizedServices = ['Shared File', 'File Sync', 'Photo Album', 'Streaming', 'HPC'];

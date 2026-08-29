import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../widgets/logo_mark.dart';

class _AccessUser {
  const _AccessUser(this.initials, this.name, this.role, this.color);

  final String initials;
  final String name;
  final String role;
  final Color color;
}

const List<_AccessUser> _users = [
  _AccessUser('SG', 'Stiven García', 'Propietario', AppColors.blue),
  _AccessUser('ML', 'María López', 'Lectura', AppColors.success),
  _AccessUser('CR', 'Carlos Reyes', 'Escritura', AppColors.purple),
];

/// Detalle y uso compartido de un archivo, con permisos Unix (rwx).
/// Equivalente a screens/FileDetailScreen.tsx.
class FileDetailScreen extends StatefulWidget {
  const FileDetailScreen({super.key});

  @override
  State<FileDetailScreen> createState() => _FileDetailScreenState();
}

class _FileDetailScreenState extends State<FileDetailScreen> {
  final List<List<bool>> _perms = [
    [true, true, true], // Propietario: r w x
    [true, true, false], // Grupo
    [true, false, false], // Otros
  ];
  static const List<String> _roles = ['Propietario', 'Grupo', 'Otros'];

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: AppColors.blueLight, borderRadius: BorderRadius.circular(AppRadius.lg)),
                    child: const Icon(Icons.code, color: AppColors.blue, size: 28),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('simulacion_climatica.py', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                        SizedBox(height: 4),
                        Text('Código Python · 14 KB', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                        SizedBox(height: 2),
                        Text(
                          '/repositorio/proyecto_clima_2025/src/',
                          style: TextStyle(fontSize: 11, color: AppColors.textSecondary, fontFamily: monoFontFamily),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 4.2,
                children: const [
                  _MetaField('Propietario', 'Stiven García'),
                  _MetaField('Creado', '15 mar 2025'),
                  _MetaField('Modificado', '30 jul 2025'),
                  _MetaField('Versión', 'v.38'),
                ],
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          color: AppColors.white,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Acceso', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.person_add_alt_outlined, size: 14),
                    label: const Text('Agregar', style: TextStyle(fontSize: 12)),
                    style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: Size.zero),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              for (final u in _users) ...[
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      UserAvatar(size: 36, initials: u.initials),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(u.name, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.textPrimary)),
                            Text(u.role, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 8),
          color: AppColors.white,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Enlace compartido', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(AppRadius.sm)),
                child: Row(
                  children: [
                    const Icon(Icons.link, size: 14, color: AppColors.textSecondary),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        'https://cloud.upb.edu.co/s/xK7mNp3qR',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 11, color: AppColors.textSecondary, fontFamily: monoFontFamily),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Enlace copiado al portapapeles')),
                        );
                      },
                      child: const Icon(Icons.copy_outlined, size: 14, color: AppColors.blue),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              const Text('⚠ Expira el 15 de agosto de 2025', style: TextStyle(fontSize: 11, color: AppColors.warning)),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 8),
          color: AppColors.white,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Permisos Unix', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.border),
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    Container(
                      color: AppColors.background,
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      child: const Row(
                        children: [
                          Expanded(child: Text('Rol', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textSecondary))),
                          _PermHeaderCell('R'),
                          _PermHeaderCell('W'),
                          _PermHeaderCell('X'),
                        ],
                      ),
                    ),
                    for (var i = 0; i < _roles.length; i++)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: i < _roles.length - 1
                            ? const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.divider)))
                            : null,
                        child: Row(
                          children: [
                            Expanded(child: Text(_roles[i], style: const TextStyle(fontSize: 13, color: AppColors.textPrimary))),
                            for (var j = 0; j < 3; j++)
                              SizedBox(
                                width: 48,
                                child: Center(
                                  child: GestureDetector(
                                    onTap: () => setState(() => _perms[i][j] = !_perms[i][j]),
                                    child: Container(
                                      width: 20,
                                      height: 20,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: _perms[i][j] ? AppColors.blue : Colors.transparent,
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(color: _perms[i][j] ? AppColors.blue : AppColors.border, width: 2),
                                      ),
                                      child: _perms[i][j] ? const Icon(Icons.check, size: 12, color: Colors.white) : null,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Permisos guardados correctamente')),
                  );
                },
                icon: const Icon(Icons.save_outlined, size: 16),
                label: const Text('Guardar permisos'),
              ),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.close, size: 16, color: AppColors.error),
                label: const Text('Dejar de compartir', style: TextStyle(color: AppColors.error)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MetaField extends StatelessWidget {
  const _MetaField(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
        const SizedBox(height: 2),
        Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.textPrimary)),
      ],
    );
  }
}

class _PermHeaderCell extends StatelessWidget {
  const _PermHeaderCell(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      child: Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/navigation/navigation_controller.dart';
import 'core/navigation/screen.dart';
import 'core/theme/app_theme.dart';
import 'views/screens/admin_screen.dart';
import 'views/screens/alerts_screen.dart';
import 'views/screens/create_job_screen.dart';
import 'views/screens/dashboard_screen.dart';
import 'views/screens/file_detail_screen.dart';
import 'views/screens/files_screen.dart';
import 'views/screens/hpc_jobs_screen.dart';
import 'views/screens/job_detail_screen.dart';
import 'views/screens/login_screen.dart';
import 'views/screens/mfa_screen.dart';
import 'views/screens/monitoring_screen.dart';
import 'views/screens/photo_album_screen.dart';
import 'views/screens/profile_screen.dart';
import 'views/screens/splash_screen.dart';
import 'views/screens/streaming_screen.dart';
import 'views/screens/sync_screen.dart';
import 'views/screens/video_player_screen.dart';
import 'views/widgets/bottom_nav.dart';
import 'views/widgets/top_bar.dart';

/// Raíz de la aplicación UPB Científica. Reproduce la lógica de navegación
/// de App.tsx: un único árbol con una pantalla activa, barra superior e
/// inferior condicionales según la pantalla.
class UpbCientificaApp extends StatelessWidget {
  const UpbCientificaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NavigationController(),
      child: MaterialApp(
        title: 'UPB Científica',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        home: const _RootShell(),
      ),
    );
  }
}

class _RootShell extends StatelessWidget {
  const _RootShell();

  @override
  Widget build(BuildContext context) {
    final nav = context.watch<NavigationController>();

    return Scaffold(
      appBar: nav.showChrome ? const TopBar() : null,
      body: SafeArea(
        top: !nav.showChrome,
        bottom: false,
        child: _buildScreen(nav.screen),
      ),
      bottomNavigationBar: nav.showChrome ? const BottomNav() : null,
    );
  }

  Widget _buildScreen(AppScreen screen) {
    return switch (screen) {
      AppScreen.splash => const SplashScreen(),
      AppScreen.login => const LoginScreen(),
      AppScreen.mfa => const MfaScreen(),
      AppScreen.dashboard => const DashboardScreen(),
      AppScreen.files => const FilesScreen(),
      AppScreen.fileDetail => const FileDetailScreen(),
      AppScreen.sync => const SyncScreen(),
      AppScreen.photos => const PhotoAlbumScreen(),
      AppScreen.streaming => const StreamingScreen(),
      AppScreen.videoPlayer => const VideoPlayerScreen(),
      AppScreen.hpc => const HpcJobsScreen(),
      AppScreen.createJob => const CreateJobScreen(),
      AppScreen.jobDetail => const JobDetailScreen(),
      AppScreen.monitoring => const MonitoringScreen(),
      AppScreen.alerts => const AlertsScreen(),
      AppScreen.profile => const ProfileScreen(),
      AppScreen.admin => const AdminScreen(),
    };
  }
}

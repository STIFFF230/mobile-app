/// Pantallas de la aplicación, equivalentes al tipo `Screen` de App.tsx.
enum AppScreen {
  splash,
  login,
  mfa,
  dashboard,
  files,
  fileDetail,
  sync,
  photos,
  streaming,
  videoPlayer,
  hpc,
  createJob,
  jobDetail,
  alerts,
  profile,
  admin,
}

/// Pestañas de la barra inferior, equivalentes al tipo `NavTab`.
enum NavTab { inicio, archivos, hpc, perfil }

const Map<NavTab, AppScreen> navScreens = {
  NavTab.inicio: AppScreen.dashboard,
  NavTab.archivos: AppScreen.files,
  NavTab.hpc: AppScreen.hpc,
  NavTab.perfil: AppScreen.profile,
};

const Map<AppScreen, NavTab> screenTabs = {
  AppScreen.dashboard: NavTab.inicio,
  AppScreen.sync: NavTab.inicio,
  AppScreen.photos: NavTab.inicio,
  AppScreen.streaming: NavTab.inicio,
  AppScreen.videoPlayer: NavTab.inicio,
  AppScreen.files: NavTab.archivos,
  AppScreen.fileDetail: NavTab.archivos,
  AppScreen.hpc: NavTab.hpc,
  AppScreen.createJob: NavTab.hpc,
  AppScreen.jobDetail: NavTab.hpc,
  AppScreen.profile: NavTab.perfil,
  AppScreen.admin: NavTab.perfil,
};

const List<AppScreen> noChromeScreens = [
  AppScreen.splash,
  AppScreen.login,
  AppScreen.mfa,
];

/// Pantallas donde el botón "atrás" de la barra superior no se muestra,
/// porque son destinos raíz de cada pestaña.
const List<AppScreen> rootScreens = [
  AppScreen.dashboard,
  AppScreen.files,
  AppScreen.hpc,
  AppScreen.profile,
];

const Map<AppScreen, String> screenTitles = {
  AppScreen.dashboard: 'UPB Científica',
  AppScreen.files: 'Archivos',
  AppScreen.fileDetail: 'Detalle',
  AppScreen.sync: 'Sincronización',
  AppScreen.photos: 'Álbum de fotos',
  AppScreen.streaming: 'Streaming',
  AppScreen.videoPlayer: 'Reproducción',
  AppScreen.hpc: 'Trabajos HPC',
  AppScreen.createJob: 'Nuevo trabajo',
  AppScreen.jobDetail: 'Detalle del trabajo',
  AppScreen.alerts: 'Alertas',
  AppScreen.profile: 'Perfil',
  AppScreen.admin: 'Administración',
};

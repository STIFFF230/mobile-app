import 'package:flutter/foundation.dart';

import '../models/hpc_job.dart';

class HpcJobsController extends ChangeNotifier {
  String _filter = 'Todos';

  String get filter => _filter;

  List<HpcJob> get filteredJobs {
    switch (_filter) {
      case 'En cola':
        return mockHpcJobs.where((j) => j.status == HpcJobStatus.queue).toList();
      case 'Ejecutando':
        return mockHpcJobs.where((j) => j.status == HpcJobStatus.running).toList();
      case 'Completados':
        return mockHpcJobs.where((j) => j.status == HpcJobStatus.done).toList();
      case 'Fallidos':
        return mockHpcJobs.where((j) => j.status == HpcJobStatus.failed).toList();
      default:
        return mockHpcJobs;
    }
  }

  void setFilter(String filter) {
    _filter = filter;
    notifyListeners();
  }
}

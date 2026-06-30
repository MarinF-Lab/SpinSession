enum JobStatus {
  pending,
  queued,
  running,
  completed,
  failed,
  retrying;

  static JobStatus fromString(String v) =>
      JobStatus.values.firstWhere((e) => e.name == v,
          orElse: () => JobStatus.pending);

  String get label => switch (this) {
        JobStatus.pending => 'Pendiente',
        JobStatus.queued => 'En cola',
        JobStatus.running => 'Procesando',
        JobStatus.completed => 'Completado',
        JobStatus.failed => 'Error',
        JobStatus.retrying => 'Reintentando',
      };
}

enum SessionStatus {
  registered,
  recording,
  pendingConfirmation,
  confirmed,
  pendingProcessing,
  pendingSync,
  syncing,
  synced,
  sent,
  completed;

  String get label => switch (this) {
        SessionStatus.registered => 'Registrada',
        SessionStatus.recording => 'Grabando',
        SessionStatus.pendingConfirmation => 'Pendiente de confirmación',
        SessionStatus.confirmed => 'Confirmada',
        SessionStatus.pendingProcessing => 'Pendiente de procesamiento',
        SessionStatus.pendingSync => 'Pendiente de sincronización',
        SessionStatus.syncing => 'Sincronizando',
        SessionStatus.synced => 'Sincronizada',
        SessionStatus.sent => 'Enviada',
        SessionStatus.completed => 'Completada',
      };

  String get value => switch (this) {
        SessionStatus.pendingConfirmation => 'pending_confirmation',
        SessionStatus.pendingProcessing => 'pending_processing',
        SessionStatus.pendingSync => 'pending_sync',
        _ => name,
      };

  static SessionStatus fromString(String v) => switch (v) {
        'recording' => SessionStatus.recording,
        'pending_confirmation' => SessionStatus.pendingConfirmation,
        'confirmed' => SessionStatus.confirmed,
        'pending_processing' => SessionStatus.pendingProcessing,
        'pending_sync' => SessionStatus.pendingSync,
        'syncing' => SessionStatus.syncing,
        'synced' => SessionStatus.synced,
        'sent' => SessionStatus.sent,
        'completed' => SessionStatus.completed,
        _ => SessionStatus.registered,
      };
}

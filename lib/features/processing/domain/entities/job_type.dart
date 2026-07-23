enum JobType {
  // Sprint 4 — procesamiento local
  generateThumbnail,
  generateSlowMotion,
  generateReverse,
  generateBoomerang,
  generateBurst,

  // Sprint 5 — sincronización y distribución
  uploadAsset,
  syncSession,
  generateGallery,
  sendWhatsapp,
  cleanupStorage,
  deleteExpiredAssets;

  String get value => switch (this) {
        JobType.generateThumbnail => 'generate_thumbnail',
        JobType.generateSlowMotion => 'generate_slow_motion',
        JobType.generateReverse => 'generate_reverse',
        JobType.generateBoomerang => 'generate_boomerang',
        JobType.generateBurst => 'generate_burst',
        JobType.uploadAsset => 'upload_asset',
        JobType.syncSession => 'sync_session',
        JobType.generateGallery => 'generate_gallery',
        JobType.sendWhatsapp => 'send_whatsapp',
        JobType.cleanupStorage => 'cleanup_storage',
        JobType.deleteExpiredAssets => 'delete_expired_assets',
      };

  static JobType fromString(String v) => switch (v) {
        'generate_slow_motion' => generateSlowMotion,
        'generate_reverse' => generateReverse,
        'generate_boomerang' => generateBoomerang,
        'generate_burst' => generateBurst,
        'upload_asset' => uploadAsset,
        'sync_session' => syncSession,
        'generate_gallery' => generateGallery,
        'send_whatsapp' => sendWhatsapp,
        'cleanup_storage' => cleanupStorage,
        'delete_expired_assets' => deleteExpiredAssets,
        _ => generateThumbnail,
      };

  String get label => switch (this) {
        JobType.generateThumbnail => 'Miniatura',
        JobType.generateSlowMotion => 'Cámara lenta',
        JobType.generateReverse => 'Reverse',
        JobType.generateBoomerang => 'Boomerang',
        JobType.generateBurst => 'Ráfaga',
        JobType.uploadAsset => 'Subiendo archivo',
        JobType.syncSession => 'Sincronizando sesión',
        JobType.generateGallery => 'Actualizando galería',
        JobType.sendWhatsapp => 'Enviando WhatsApp',
        JobType.cleanupStorage => 'Limpieza de archivos',
        JobType.deleteExpiredAssets => 'Eliminando expirados',
      };

  bool get isMediaJob => switch (this) {
        JobType.generateThumbnail ||
        JobType.generateSlowMotion ||
        JobType.generateReverse ||
        JobType.generateBoomerang ||
        JobType.generateBurst =>
          true,
        _ => false,
      };
}

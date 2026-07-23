/// URL base de la página web de la galería pública (`gallery.html`), alojada
/// en GitHub Pages a partir de la carpeta `web_gallery/` del repo (Supabase
/// Storage no sirve: fuerza `Content-Type: text/plain` en archivos `.html`
/// de buckets públicos por seguridad, así que nunca renderizan). Ver
/// `.github/workflows/deploy-gallery.yml`.
///
/// No existe una página de sesión privada — se eliminó a favor de compartir
/// el video directamente por WhatsApp (ver `SyncService.sendWhatsapp`).
abstract final class WebGalleryConfig {
  static const baseUrl = String.fromEnvironment(
    'WEB_GALLERY_BASE_URL',
    defaultValue: 'https://marinf-lab.github.io/SpinSession',
  );

  static String gallery(String eventId) => '$baseUrl/gallery.html?event=$eventId';
}

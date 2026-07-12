/// URL base de las páginas web de la galería (`gallery.html`, `session.html`),
/// alojadas en GitHub Pages a partir de la carpeta `web_gallery/` del repo
/// (Supabase Storage no sirve: fuerza `Content-Type: text/plain` en archivos
/// `.html` de buckets públicos por seguridad, así que nunca renderizan).
/// Ver `.github/workflows/deploy-gallery.yml`.
abstract final class WebGalleryConfig {
  static const baseUrl = String.fromEnvironment(
    'WEB_GALLERY_BASE_URL',
    defaultValue: 'https://marinf-lab.github.io/SpinSession',
  );

  static String gallery(String eventId) => '$baseUrl/gallery.html?event=$eventId';

  static String privateSession(String sessionId) =>
      '$baseUrl/session.html?session=$sessionId';
}

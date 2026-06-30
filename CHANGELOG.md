# Changelog

Todos los cambios importantes del proyecto **SpinSession** deberán documentarse en este archivo.

El proyecto sigue la especificación de **Semantic Versioning (SemVer)**.

Formato:

MAJOR.MINOR.PATCH

Ejemplo:

1.0.0

---

## [Unreleased]

### Agregado

- Sprint 4: tabla Drift `processing_jobs` (schemaVersion → 4).
- Sprint 4: entidades `JobType`, `JobStatus`, `ProcessingJobEntity`.
- Sprint 4: `FFmpegService` con miniatura, cámara lenta gradual, reverse, boomerang y ráfaga.
- Sprint 4: `TaskQueueService` con cola secuencial, reintentos automáticos y recuperación tras reinicio.
- Sprint 4: `ProcessingRepository` con creación de jobs por sesión y prioridades por tipo de efecto.
- Sprint 4: `ProcessingScreen` con visualización en tiempo real de la cola de procesamiento.
- Sprint 4: ruta `/processing/:sessionId` en GoRouter.
- Sprint 5: `StorageService` para subir archivos a Supabase Storage (bucket `spinsession`) y generar URLs firmadas de 7 días.
- Sprint 5: `SyncService` para sincronizar sesiones y assets a Supabase, y enviar WhatsApp vía `share_plus`.
- Sprint 5: `SyncRepository` que crea automáticamente jobs de sync (uploadAsset, syncSession, generatePrivateSession, generateGallery, sendWhatsapp, cleanupStorage) al completar todos los jobs de media.
- Sprint 5: `SyncScreen` con progreso agrupado por estado (en progreso / pendiente / completado / fallido).
- Sprint 5: `GalleryScreen` con grilla de sesiones por evento y diálogo de código QR para galería pública.
- Sprint 5: `PrivateSessionScreen` con lista de archivos procesados y compartir individual vía `share_plus`.
- Sprint 5: dependencia `share_plus ^10.0.0` y `path ^1.9.0`.
- Sprint 5: rutas `/sync/:sessionId`, `/gallery/:eventId` y `/private/:sessionId` en GoRouter.
- Sprint 5: `SessionStatus` extendido con estados `pendingSync`, `syncing`, `synced`, `sent`, `completed`.
- Sprint 5: `JobType` extendido con `uploadAsset`, `syncSession`, `generatePrivateSession`, `generateGallery`, `sendWhatsapp`, `cleanupStorage`, `deleteExpiredAssets`.

### Cambiado

- Sprint 4: al confirmar una sesión se crean automáticamente los jobs de procesamiento y se navega a la pantalla de procesamiento.
- Fix: validación de campos vacíos en LoginScreen y RegisterScreen antes de llamar a Supabase.
- Fix: redirect loop en GoRouter cuando el usuario está autenticado pero sin modo de dispositivo seleccionado.

### Corregido

- No hay cambios registrados.

### Eliminado

- No hay cambios registrados.

---

## Tipos de cambios

Utilizar las siguientes categorías:

### Agregado

Nuevas funcionalidades.

### Cambiado

Cambios en funcionalidades existentes.

### Corregido

Corrección de errores.

### Eliminado

Funcionalidades eliminadas.

### Seguridad

Correcciones relacionadas con seguridad.

### Rendimiento

Optimizaciones de rendimiento.

### Documentación

Cambios únicamente en documentación.

---

# Reglas

Toda modificación importante deberá registrarse.

Cada nueva versión deberá mover los cambios desde **Unreleased** hacia su versión correspondiente.

Nunca eliminar versiones anteriores.

El historial del proyecto debe conservarse permanentemente.

---

# Ejemplo

## [1.0.0] - YYYY-MM-DD

### Agregado

- Sistema de autenticación.
- Gestión de eventos.
- Calendario.
- Grabación de sesiones.
- Procesamiento multimedia.
- Sincronización con Supabase.
- Galería pública.
- Sesiones privadas.
- Envío mediante WhatsApp.

### Rendimiento

- Optimización del procesamiento multimedia.
- Optimización del consumo de memoria.

### Corregido

- Correcciones menores antes de la primera versión estable.

---

Fin del documento.
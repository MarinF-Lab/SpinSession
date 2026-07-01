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

- Sprint 6: `AppLogger` — registro centralizado en memoria (info/warning/error) sin datos sensibles.
- Sprint 6: manejo global de errores — `runZonedGuarded`, `FlutterError.onError` y `ErrorWidget.builder` con `AppErrorWidget` amigable en vez de la pantalla roja de Flutter.
- Sprint 6: botón "Abrir estudio" en `EventDetailScreen`, visible solo cuando el evento está `active` — corrige un punto muerto de navegación: el Estudio de grabación (Sprint 3) no tenía forma de alcanzarse desde la UI.
- Sprint 6: `EventRepository.pullFromRemote()` — trae eventos desde Supabase al dispositivo local; antes la sincronización solo empujaba datos locales, nunca los traía de vuelta, por lo que un dispositivo nuevo nunca veía eventos creados en otro.
- Sprint 6: `docs/supabase_schema.sql` — script de creación de tablas (`events`, `sessions`, `session_assets`) y bucket de Storage (`spinsession`), ausentes en el proyecto de Supabase desde el inicio (causa raíz de que la sincronización remota nunca funcionara).
- Diseño: paleta de colores oficial del Design System (morado `#8A2BE2`, secundario `#B894DF`, acento neón `#FF4DDA`) aplicada en `AppColors`/`AppTheme`.
- Diseño: navegación inferior persistente (`AppBottomNav`) con 4 pestañas — Calendario, Estudio, Registro, Ajustes — reemplazando la pantalla "Inicio" como landing tras el login.
- Diseño: `EstudioTabScreen` y `RegistroTabScreen` — muestran automáticamente el evento activo del usuario (`activeEventProvider`) sin navegación manual.
- Diseño: botones, FAB y tarjetas con esquinas redondeadas (pill/16px) y `StatusChip` con colores de estado del mockup (Reservado, Pagado, Activo, Finalizado).
- Diseño: `CalendarScreen` con topbar de dos filas (título + navegación de mes), `EventCard` restilizado (hora/nombre/chip inline), FAB circular.
- Diseño: `EstudioTabScreen` con card "Evento activo" morada, formulario embebido de nueva sesión y "Configuración rápida" (duración, efectos, tomas máx.) leídos de `RecordingConfigEntity`.
- Diseño: `ConfirmationScreen` con fila "Vista previa" de miniaturas y botones REPETIR/ACEPTAR; `RecordingScreen` con temporizador morado y badge REC.
- Diseño: `RegistroTabScreen` con chips de filtro (Todos/Pendientes/Enviadas) y lista de invitados con avatar, tomas/videos e ícono de estado de sincronización.

### Cambiado

- Sprint 4: al confirmar una sesión se crean automáticamente los jobs de procesamiento y se navega a la pantalla de procesamiento.
- Fix: validación de campos vacíos en LoginScreen y RegisterScreen antes de llamar a Supabase.
- Fix: redirect loop en GoRouter cuando el usuario está autenticado pero sin modo de dispositivo seleccionado.
- Sprint 6: logging agregado en puntos clave (login, registro, cierre de sesión, jobs de procesamiento y sincronización) y en `catch` que antes fallaban silenciosamente.
- Sprint 6: corregidos varios textos sin tilde (Configuración, Iniciar sesión, Cerrar sesión, Administración, Operación, Grabación).

### Corregido

- Fix: `DateFormat(..., 'es')` lanzaba excepción no capturada (pantalla roja) en Calendario, Detalle de evento y selectores de fecha — faltaba `initializeDateFormatting('es')` en `main.dart`.
- Sprint 6: eliminado código muerto (`_updateSignedUrlForWhatsapp` no-op) en `TaskQueueService`.
- Fix: `EventController.syncPending()` nunca se llamaba desde ningún lugar de la app — ahora se dispara junto con `pullFromRemote()` al abrir el Calendario.

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
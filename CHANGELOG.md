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
- Fix (revisión de código): `pullFromRemote()` podía sobrescribir y marcar como sincronizado un evento local con cambios pendientes aún no confirmados en Supabase, perdiéndolos para siempre. Ahora se omite el pull si el evento local tiene `synced == false`.
- Fix (revisión de código): botones de búsqueda y filtro en `RegistroTabScreen` no hacían nada al tocarlos. Se implementó búsqueda real por nombre de invitado y se quitó el ícono de filtro redundante (los chips ya filtran).

**Sprint 6 cerrado.** Próximo: Sprint 7 (Release, Publicación y Cierre del Proyecto).

### Corregido (cumplimiento Anexo/Coding Rules)

- Restauradas `connectivity_plus` y `mobile_scanner` al `pubspec.yaml`: son stack oficial (Anexo A.2.2) y quitarlas violaba las Reglas 26/27 y A.4.20. No eran código muerto sino piezas del stack aún no consumidas.
- Detección de conexión implementada correctamente en `lib/core/network/connectivity_provider.dart` (responsabilidad del Sync Engine, Anexo A.1.12).
- Movida la lógica de sincronización fuera de `CalendarScreen` (accedía directo al repositorio, violando la Regla 6 / A.4.5) a `EventController.syncWithRemote()`, que verifica conexión antes de empujar pendientes y traer remotos.

### Corregido (pruebas en dispositivo)

- Bug: los eventos aparecían un día antes de la fecha elegida. Causa: `event_date` (fecha de calendario) se serializaba mezclando hora local con la columna `timestamptz` de Supabase, desplazándose al ida-y-vuelta según la zona horaria. Ahora la fecha viaja como medianoche UTC del día y se lee por componentes año-mes-día; los instantes reales (inicio/fin/timestamps) viajan en UTC y se reconvierten a local.
- Bug: un evento recién creado no aparecía hasta cerrar y reabrir la app. Causa: `eventsForDateProvider` era un `FutureProvider` cacheado. Ahora deriva del estado del `EventController`, refrescándose al instante tras crear/editar/pagar.
- Mejora UX: el calendario marca con un punto los días que tienen eventos (`eventDaysProvider`).
- Mejora UX: al crear un evento ya no se pide la fecha (se usa el día seleccionado en el calendario, mostrado como encabezado de solo lectura).
- Mejora UX: los selectores de hora abren en modo teclado (`TimePickerEntryMode.input`) — escribir "14:30" en vez del reloj.
- Bug: al editar un evento, los cambios no se reflejaban al reabrir el detalle. Causa: `eventByIdProvider` era un `FutureProvider` cacheado. Ahora deriva del `EventController` (detalle, edición, estudio y galería actualizados en consecuencia).
- Bug crítico: la pantalla de grabación quedaba en negro cargando indefinidamente. Causa: `RecordingScreen` nunca llamaba a `initCamera()`. Ahora inicializa la cámara en `initState` con la config del evento (o valores por defecto).
- Permisos explícitos `CAMERA`, `RECORD_AUDIO` e `INTERNET` en el `AndroidManifest` (evita fallos en build release).
- Nuevo `PhoneInputField`: selector de país (Chile `+56` por defecto) con prefijo `9` y formato automático `+56 9 xxxx xxxx`. Integrado en el registro de invitado del Estudio.
- Configuración rápida del Estudio ahora interactiva: Duración y Tomas máx. editables y persistidas por evento. La config nueva genera un id propio al guardarse.
- Duración de toma ahora es entrada manual (3–300 s) y recuerda el último valor guardado.
- La grabación se detiene automáticamente al alcanzar la duración configurada (auto-stop timer en `RecordingController`).
- Bug crítico de procesamiento: los efectos (cámara lenta, reverse, boomerang, ráfaga) siempre fallaban. Causa: se leía `getReturnCode()` justo tras `FFmpegKit.executeAsync`, antes de que el proceso terminara. Ahora un `Completer` espera al callback de finalización antes de evaluar el resultado.
- Bug: miniatura, cámara lenta, reverse y boomerang fallaban porque su carpeta de salida (`processing/<sesión>/<toma>/`) no existía antes de que FFmpeg escribiera (solo burst la creaba). Ahora se crea la carpeta contenedora antes de cada efecto; esto también desbloquea la "sesión privada", que dependía del thumbnail subido.
- Envío por WhatsApp ahora abre el chat del invitado directamente (esquema `whatsapp://` con respaldo `wa.me`), en vez del menú de compartir genérico que obligaba a elegir el destinatario. Nueva dependencia `url_launcher` (autorizada) y `<queries>` de WhatsApp en el `AndroidManifest`.
- Bug: cámara lenta, reverse y boomerang seguían fallando porque el build de FFmpeg no incluye libx264 (GPL) y no se especificaba encoder. Ahora usan el encoder nativo `mpeg4`. Se agregó logging del error real de FFmpeg (`AppLogger.error('FFmpeg', …)`) para diagnóstico.
- Bug: el límite de tomas por sesión no se respetaba (dejaba agregar tomas de más). Ahora `RecordingController` conoce `maxTakes`, bloquea grabar al alcanzarlo y la pantalla de confirmación oculta "Agregar otra toma".
- El envío por WhatsApp dejó de encolarse automáticamente en el pipeline y pasó a ser una acción del usuario (semiautomática, requiere primer plano).
- Al confirmar las tomas ahora se elige: **"Esperar y enviar por WhatsApp"** (procesa y abre el chat al terminar) o **"Procesar en segundo plano"** (vuelve al Estudio para seguir registrando; se envía luego desde el Registro).
- Registro interactivo: cada sesión abre un detalle (`SessionDetailScreen`) con sus videos, los errores de procesamiento y un botón para **enviar/reenviar por WhatsApp**. Nueva ruta `/session/:id` y `sessionByIdProvider`.
- Registro: el filtro "Enviadas" ahora cuenta solo las sesiones realmente enviadas (`sent`); las procesadas pero sin enviar quedan como pendientes.

### Cambiado (modos de dispositivo — Fase 1)

- Los modos de dispositivo pasan de 3 a **2**: se elimina "Ambos". Quedan **Operador** (control completo, futuro anfitrión de la cámara) y **Cámara** (solo grabación). El modo Operador cumple el rol del antiguo "Ambos".
- La barra de navegación inferior ahora depende del modo: Operador ve Calendario/Estudio/Registro/Ajustes; Cámara ve solo Estudio/Ajustes.
- El arranque enruta según el modo: Cámara entra directo al Estudio; Operador al Calendario.
- Nota: la vinculación operador↔cámara y la sincronización en tiempo real del evento/cola de invitados quedan para la Fase 2.
- Ajustes: nueva sección "Dispositivo" con el modo actual, un botón para **cambiar de modo** y una vista de **dispositivos vinculados** (por ahora este dispositivo; la vinculación de cámaras llega en la Fase 2).

### Sprint 7 (en curso)

- Configuración de firma release vía `android/key.properties` (ignorado por Git; ver `key.properties.example`).
- Minificación R8/ProGuard y `isShrinkResources` habilitados en el build type `release`.
- Splits por ABI (`armeabi-v7a`, `arm64-v8a`, `x86_64`) para reducir el tamaño del APK universal.
- `LICENSE` (software propietario) y versión fijada en `1.0.0+1`.
- Fix: `test/widget_test.dart` fallaba porque Supabase nunca se inicializaba en el entorno de test, y esperaba el texto `'Iniciar sesion'` sin tilde (ya corregido en Sprint 6).
- `DOCS/supabase_schema.sql` documentado como referencia de infraestructura.
- Bug: al cambiar de modo de dispositivo desde Ajustes, el router forzaba el regreso a `/calendar` incluso en modo Cámara, y la selección de modo nunca surtía efecto. Causa: el `redirect` de GoRouter trataba `/device-selection` como una ruta de la que siempre había que salir una vez que existía un modo guardado, y el destino de rebote estaba fijo en `/calendar` sin mirar el modo actual. Ahora `/device-selection` puede revisitarse para cambiar de modo, y el rebote depende del modo (Cámara → Estudio, Operador → Calendario).
- Galería web pública (`gallery.html`) y sesión privada (`session.html`), alojadas en un nuevo bucket público de Supabase (`spinsession-web`). El QR del evento apunta a la galería pública; el link de WhatsApp ahora apunta a la sesión privada del invitado (antes era una signed URL de un solo archivo, a veces rota).
- Nuevas políticas RLS anónimas (`events`, `sessions`, `session_assets`, `storage.objects`) que permiten a invitados sin sesión iniciada leer **solo** datos de eventos con `payment_status = 'paid'` — agregado a `DOCS/supabase_schema.sql`.
- Fix: `SyncService.syncAsset()` nunca se llamaba — `_executeUploadAsset` subía el archivo a Storage pero jamás registraba la fila en la tabla remota `session_assets`, dejando la galería web sin datos. Ahora se registra tras cada subida exitosa.
- Nueva constante `WebGalleryConfig` (`lib/core/config/web_gallery_config.dart`) centraliza la URL base de la galería web, reemplazando el dominio placeholder `spinsession.app` que estaba repetido (y desactualizado) en tres archivos distintos.
- Conocido, fuera de este alcance: las fotos de ráfaga (burst) probablemente nunca se suben a Storage porque la comprobación de existencia del archivo local falla para directorios — queda pendiente como tarea aparte.
- **Pago con Mercado Pago** (reemplaza el botón manual de "pago simulado"): cada evento genera su propio link de pago con precio fijo (mismo monto, `external_reference` = id del evento) vía la nueva Edge Function `create-payment-preference`. La confirmación es **automática**: la nueva Edge Function `mercadopago-webhook` verifica el pago real contra la API de Mercado Pago (nunca confía en la notificación entrante) y marca el evento como pagado. La app se entera al instante vía Supabase Realtime, sin polling, y muestra el QR de la galería automáticamente. Ver `DOCS/MERCADOPAGO_SETUP.md` para los pasos de despliegue (cuenta, Access Token, `supabase functions deploy`).
- Nueva columna `events.payment_link` (Drift schemaVersion → 5, con migración `addColumn`) y `payment_status`/`event_status` ya no se marcan manualmente al pagar — quedan a cargo del webhook.
- Defaults del Estudio cambiados a **10 segundos** de duración y **1 toma máxima** por sesión.
- El tile "Efectos activos" del Estudio, que no hacía nada, ahora abre un selector múltiple y **se conecta de verdad** con el procesamiento: `ProcessingRepository.createJobsForSession` ahora filtra los efectos generados según la configuración del evento (antes generaba cámara lenta/reverse/boomerang/ráfaga siempre, sin importar la config).
- Nueva dependencia `video_player`: vista previa funcional de las tomas recién grabadas (`confirmation_screen.dart`) y de los videos ya procesados en el detalle de sesión del Registro (`session_detail_screen.dart`) — antes ambas eran solo íconos estáticos sin reproducción.
- **Eliminada la galería privada por sesión** (`session.html`, ruta `/private/:sessionId`, job `generatePrivateSession`): se simplifica a un solo modelo — galería pública por evento (QR) + el video se comparte directamente por WhatsApp.
- Compartir por WhatsApp ahora manda el **video real**, no un link: abre primero la conversación del invitado vía `wa.me` (funciona sin tenerlo agendado) y a los pocos milisegundos dispara el selector nativo de Compartir con los archivos adjuntos — WhatsApp no acepta archivos por deep link, así que esta es la única forma de mandar el archivo en vez de un enlace.

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
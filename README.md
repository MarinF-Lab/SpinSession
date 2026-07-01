# SpinSession

Sistema profesional para la gestión de eventos, captura multimedia, procesamiento local y distribución automática de contenido.

**Estado:** 🚧 En desarrollo

**Versión:** 1.0.0-dev

---

# Descripción

SpinSession es una aplicación móvil desarrollada con **Flutter** cuyo objetivo es gestionar eventos, capturar fotografías y videos, procesarlos localmente y sincronizarlos con la nube para compartirlos mediante galerías públicas y sesiones privadas.

La aplicación está diseñada siguiendo una arquitectura **Offline First**, permitiendo que la mayor parte del trabajo continúe funcionando incluso sin conexión a Internet.

---

# Objetivos

- Gestión profesional de eventos.
- Captura multimedia.
- Procesamiento local mediante FFmpeg.
- Sincronización inteligente con Supabase.
- Distribución mediante QR y WhatsApp.
- Arquitectura modular y escalable.

---

# Tecnologías

## Frontend

- Flutter
- Dart

## Gestión de Estado

- Riverpod

## Base de Datos Local

- Drift

## Backend

- Supabase
- Supabase Storage

## Procesamiento Multimedia

- FFmpeg Kit

## Control de Versiones

- Git
- GitHub

---

# Requisitos

Antes de ejecutar el proyecto se requiere tener instalado:

- Flutter SDK
- Android SDK
- Git
- Visual Studio Code
- Android Studio (solo para administrar el SDK)

Verificar instalación:

```bash
flutter doctor
```

Todos los componentes deben aparecer correctamente configurados.

---

# Primer Inicio

Instalar dependencias:

```bash
flutter pub get
```

Ejecutar la aplicación:

```bash
flutter run
```

Compilar APK:

```bash
flutter build apk
```

Compilar Android App Bundle:

```bash
flutter build appbundle
```

---

# Flujo de Trabajo

Actualizar el repositorio:

```bash
git pull
```

Guardar cambios:

```bash
git add .
git commit -m "tipo: descripción"
git push
```

Ejemplos:

```text
feat: create event module

fix: resolve camera initialization

refactor: simplify task queue

docs: update sprint 2

chore: upgrade dependencies
```

---

# Estructura del Proyecto

```text
SpinSession/

android/
ios/
linux/
macos/
windows/
web/

assets/
docs/
lib/
test/

.github/

README.md
PRD.md
CHANGELOG.md
LICENSE

pubspec.yaml
analysis_options.yaml
```

---

# Documentación

Toda la documentación del proyecto se encuentra dentro de la carpeta **docs/**.

Documentos principales:

- PRD
- ANEXO_TECNICO
- CODING_RULES
- ARCHITECTURE_DECISIONS
- TASK_TYPES
- SPRINT_1
- SPRINT_2
- SPRINT_3
- SPRINT_4
- SPRINT_5
- SPRINT_6
- SPRINT_7

Antes de implementar cualquier funcionalidad deberá revisarse la documentación correspondiente.

---

# Flujo de Trabajo con IA

Reglas obligatorias para cualquier sesión de trabajo asistido por IA en este proyecto:

1. Antes de comenzar a trabajar, leer este README y los documentos adjuntos en `DOCS/`.
2. Al finalizar una tarea, registrar el avance en `CHANGELOG.md` y volver a leer este README antes de la siguiente acción.
3. La misión es codificar de manera correcta, usando todas las herramientas disponibles.
4. Los resúmenes deben ser breves: solo errores, aciertos, cómo se arreglaron, y qué quedó listo. Sin explicaciones de más.
5. No usar los emuladores repetidamente para verificar cada cambio menor — consume tiempo y baja la calidad de la codificación.
6. Usar las herramientas y agentes de Gstack para corroborar el funcionamiento del código.
7. Una vez que todos los sprints estén listos, se probará el funcionamiento en los emuladores con guía directa del usuario para corregir bugs y fallos.
8. Una vez terminado el código base, se implementarán los diseños visuales finales.

---

# Orden de Desarrollo

El desarrollo del proyecto seguirá estrictamente el siguiente orden:

```text
PRD

↓

Anexo Técnico

↓

Coding Rules

↓

Sprint correspondiente

↓

Implementación

↓

Pruebas

↓

Commit

↓

Siguiente Sprint
```

No deben implementarse funcionalidades pertenecientes a Sprints posteriores.

---

# Principios del Proyecto

- Offline First.
- Clean Architecture.
- Arquitectura modular.
- Bajo acoplamiento.
- Alta cohesión.
- Procesamiento local antes que remoto.
- Componentes reutilizables.
- Código documentado.
- Una única responsabilidad por clase.
- Calidad antes que velocidad.

---

# Estado Actual

## Documentación

- ✅ PRD finalizado.
- ✅ Anexo Técnico finalizado.
- ✅ Coding Rules finalizadas.
- ✅ Sprints definidos.

## Infraestructura

- ✅ Repositorio GitHub.
- ✅ Proyecto Flutter inicializado.
- ✅ Android SDK configurado.

## Desarrollo

### Sprint 1 — Completado ✅

- ✅ Inicialización de Supabase con credenciales de desarrollo.
- ✅ Fuente Poppins integrada.
- ✅ Guards de navegación con GoRouter (auth + device mode).
- ✅ AppDatabase con Drift (tablas base).
- ✅ Tema global con Material 3.

### Sprint 2 — Completado ✅

- ✅ Tablas Drift: eventos, plantillas, configuración de evento, sync jobs.
- ✅ Entidades de dominio: EventEntity, TemplateEntity, EventStatus, PaymentStatus.
- ✅ Repositorios: EventRepository (Offline First + sync background), TemplateRepository.
- ✅ Datasources locales (Drift) y remotos (Supabase) para eventos y plantillas.
- ✅ Providers y controllers: EventController, TemplatesController con Riverpod.
- ✅ Widgets compartidos: DatePickerField, TimePickerField, StatusChip, EventCard.
- ✅ Pantallas: CalendarScreen, CreateEventScreen, EventDetailScreen, EditEventScreen, HistoryScreen, TemplatesScreen, CreateTemplateScreen.
- ✅ Rutas GoRouter actualizadas con todas las pantallas del Sprint 2.
- ✅ `flutter analyze` sin errores.

### Sprint 3 — Completado ✅

- ✅ Tablas Drift: sessions, session_assets, recording_configs (schemaVersion → 3).
- ✅ Entidades de dominio: SessionStatus, SessionEntity, SessionAssetEntity, RecordingConfigEntity.
- ✅ Repositorios: SessionRepository, RecordingConfigRepository (Offline First).
- ✅ CameraService: permisos, inicialización, grabación start/stop.
- ✅ Controllers: SessionController (CRUD sesiones), RecordingController (countdown, grab, takes).
- ✅ Estudio de grabación (StudioScreen) con validación de acceso (activo + pagado + en horario).
- ✅ Modos Operator/Camera/Both correctamente implementados.
- ✅ Formulario de registro de invitado con validación.
- ✅ Configuración general de grabación (RecordingConfigScreen).
- ✅ Configuración individual por sesión (SessionConfigScreen).
- ✅ Pantalla de grabación con cámara en vivo, cuenta regresiva y múltiples tomas.
- ✅ Pantalla de confirmación (confirmar / agregar toma / repetir / cancelar).
- ✅ Registro de sesiones (SessionsListScreen).
- ✅ SpinLab completamente funcional (modo prueba sin persistencia, auto-limpieza).
- ✅ Rutas GoRouter actualizadas con todas las pantallas del Sprint 3.
- ✅ `flutter analyze` sin errores ni warnings.

Próximo objetivo:

**Implementar Sprint 4.**

---

# Licencia

Este proyecto corresponde a un software propietario.

Todos los derechos reservados.

Consultar el archivo **LICENSE** para conocer los términos de uso y distribución.

---

# Autor

**Isaac Marin**

Proyecto desarrollado como software propietario.

© 2026 Isaac Marin. Todos los derechos reservados.
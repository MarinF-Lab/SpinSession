# SPRINT 5

# Sincronización, Distribución y Compartición

Versión: 2.0

---

# Objetivo

Implementar toda la infraestructura de sincronización de SpinSession utilizando el TaskQueueService.

Al finalizar este Sprint, todas las sesiones procesadas deberán sincronizarse automáticamente con Supabase, generar enlaces privados, publicar la galería del evento y enviar automáticamente el acceso mediante WhatsApp.

---

# Objetivos específicos

Durante este Sprint la IA deberá:

- Integrar Supabase Storage.
- Implementar sincronización automática.
- Crear Jobs de subida.
- Crear Jobs de sincronización.
- Crear Jobs de limpieza.
- Crear URLs firmadas.
- Implementar la galería pública.
- Implementar sesiones privadas.
- Integrar WhatsApp.
- Eliminar automáticamente archivos expirados.

---

# Extensión del TaskQueueService

Agregar los siguientes tipos de Jobs:

- upload_asset
- sync_session
- generate_gallery
- generate_private_session
- send_whatsapp
- cleanup_storage
- delete_expired_assets

Todo el sistema utilizará la misma cola creada en el Sprint 4.

---

# Flujo Oficial

```text
Sesión Procesada
        │
        ▼
Crear Jobs
        │
        ▼
TaskQueueService
        │
        ├────────► Subir archivos
        │
        ├────────► Actualizar Supabase
        │
        ├────────► Crear galería
        │
        ├────────► Crear sesión privada
        │
        ├────────► Enviar WhatsApp
        │
        └────────► Limpieza automática
```

---

# Sincronización

Toda sincronización seguirá este flujo:

Drift

↓

TaskQueueService

↓

Supabase Storage

↓

Supabase Database

↓

Actualizar estado

↓

Finalizar

Nunca depender directamente de Internet.

---

# Supabase Storage

Subir automáticamente:

- Video original.
- Cámara lenta.
- Reverse.
- Boomerang.
- Ráfaga.
- Miniaturas.

Todos los archivos deberán conservar su relación con la sesión correspondiente.

---

# Galería Pública

Cada evento dispondrá de una galería pública.

Características:

- Acceso mediante QR.
- Solo lectura.
- Compatible con dispositivos móviles.
- Actualización automática.

---

# Sesión Privada

Cada invitado dispondrá de una sesión privada.

Deberá mostrar:

- Videos generados.
- Miniaturas.
- Fecha de grabación.
- Descarga individual.
- Descarga completa.

El acceso será mediante URLs firmadas.

---

# WhatsApp

Al finalizar la sincronización:

Generar automáticamente un mensaje.

Ejemplo:

Gracias por participar.

Tus videos ya están disponibles.

Descárgalos aquí:

https://...

Enviar únicamente el enlace privado.

Nunca enviar archivos multimedia directamente.

---

# URLs Firmadas

Todas las sesiones privadas utilizarán Signed URLs.

Características:

- Tiempo de expiración configurable.
- Renovables.
- No indexables.
- Acceso privado.

---

# Reintentos

Si una tarea falla:

- Registrar el error.
- Esperar.
- Reintentar automáticamente.
- Evitar duplicados.

---

# Limpieza Automática

Crear Jobs para eliminar:

- Archivos temporales.
- Caché innecesaria.
- Procesamientos incompletos.
- Archivos expirados según la configuración del evento.

---

# Estados

Implementar los siguientes estados:

Pending

↓

Queued

↓

Uploading

↓

Uploaded

↓

Shared

↓

Completed

↓

Cleanup

---

# Interfaz

Crear una pantalla de sincronización donde el operador pueda visualizar:

- Pendientes.
- Subiendo.
- Completadas.
- Errores.
- Reintentos.

---

# Manejo de Errores

Registrar:

- Errores de red.
- Errores de Storage.
- Errores de Supabase.
- Errores de WhatsApp.

Siempre permitir reintentar.

---

# Qué NO debe implementar

No implementar:

- Testing automatizado.
- Optimización avanzada.
- Accesibilidad.
- Release.
- Publicación.

Todo esto pertenece al Sprint 6.

---

# Criterios de aceptación

- Sincronización completamente funcional.
- Supabase Storage integrado.
- URLs firmadas funcionando.
- Galería pública funcional.
- Sesiones privadas funcionales.
- Envío automático por WhatsApp.
- Reintentos funcionando.
- Limpieza automática funcionando.
- Proyecto compilando sin errores.
- Sin TODOs.
- Cumplimiento del PRD, Anexo Técnico y Coding Rules.

---

# Entregables

- Sincronización automática.
- Integración con Supabase Storage.
- Galería pública.
- Sesiones privadas.
- Enlaces firmados.
- Integración con WhatsApp.
- Limpieza automática.
- Proyecto preparado para el Sprint 6.

---

# Definición de Terminado

El Sprint finalizará cuando una sesión pueda completar automáticamente todo el flujo de sincronización: subir archivos, generar la galería pública, crear la sesión privada, enviar el enlace por WhatsApp y ejecutar la limpieza correspondiente sin intervención del operador.

---

Fin del Sprint 5.
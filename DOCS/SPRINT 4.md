# SPRINT 4

# Motor de Procesamiento Multimedia

Versión: 2.0

---

# Objetivo

Desarrollar el motor de procesamiento multimedia de SpinSession utilizando un sistema centralizado de tareas (Task Queue Engine).

Al finalizar este Sprint, la aplicación será capaz de procesar automáticamente todas las sesiones confirmadas, generar los efectos seleccionados y dejar cada sesión preparada para su sincronización, todo ello de manera local y sin depender de conexión a Internet.

---

# Objetivos específicos

Durante este Sprint la IA deberá:

- Implementar el TaskQueueService.
- Crear el sistema de Jobs.
- Integrar FFmpeg Kit.
- Procesar videos en segundo plano.
- Generar múltiples efectos.
- Crear miniaturas.
- Mantener el video original.
- Registrar el progreso de cada tarea.
- Permitir reanudar tareas tras reiniciar la aplicación.
- Preparar toda la infraestructura para el Sprint 5.

---

# Arquitectura

Todo el procesamiento multimedia será administrado por un único servicio.

```text
Session Confirmed
        │
        ▼
 Crear Jobs
        │
        ▼
 TaskQueueService
        │
        ▼
 Ejecutar FFmpeg
        │
        ▼
 Guardar archivos
        │
        ▼
 Actualizar Drift
        │
        ▼
 Job Completado
```

---

# TaskQueueService

El TaskQueueService será el motor central del proyecto.

Será responsable de:

- Administrar la cola de tareas.
- Ejecutar tareas en orden.
- Registrar estados.
- Registrar progreso.
- Gestionar reintentos.
- Recuperar tareas pendientes.

Ningún otro módulo podrá ejecutar FFmpeg directamente.

---

# Tipos de Jobs

Implementar los siguientes tipos:

- generate_thumbnail
- generate_slow_motion
- generate_reverse
- generate_boomerang
- generate_burst

Todos utilizarán el mismo motor.

---

# Modelo de Job

Cada Job deberá contener:

- id
- type
- priority
- payload
- status
- progress
- attempts
- created_at
- updated_at

---

# Estados del Job

Implementar exactamente:

Pending

↓

Queued

↓

Running

↓

Completed

↓

Failed

↓

Retrying

---

# Flujo de Procesamiento

Cada sesión confirmada deberá generar automáticamente los Jobs necesarios.

Ejemplo:

Video Original

↓

Miniatura

↓

Cámara Lenta

↓

Reverse

↓

Boomerang

↓

Ráfaga

↓

Actualizar Base de Datos

↓

Finalizar

---

# Video Original

El video original nunca deberá modificarse.

Todos los efectos deberán generarse como archivos independientes.

---

# Cámara Lenta

Generar un efecto cinematográfico.

El flujo deberá ser:

Velocidad Normal

↓

Reducción gradual

↓

Cámara lenta

↓

Aumento gradual

↓

Velocidad Normal

No generar un video completamente lento.

---

# Reverse

Crear una copia invertida del video.

Mantener resolución y calidad.

---

# Boomerang

Crear automáticamente:

Normal

↓

Reverse

↓

Unión

↓

Video Final

---

# Ráfaga

Extraer múltiples imágenes del video.

Cada imagen deberá conservar la calidad original.

---

# Miniaturas

Generar automáticamente una miniatura para cada toma.

Será utilizada posteriormente por:

- Registro de sesiones.
- Galería pública.
- Sesión privada.

---

# Varias Tomas

Si una sesión contiene múltiples tomas:

- Procesar cada toma individualmente.
- No mezclar archivos.
- Mantener relación entre toma y efectos.

---

# Recuperación

Si la aplicación se cierra inesperadamente:

Al iniciar nuevamente deberá:

- Detectar Jobs pendientes.
- Continuar automáticamente.
- No repetir tareas ya completadas.

---

# Persistencia

Registrar en Drift:

- Estado.
- Progreso.
- Archivos generados.
- Tiempo de procesamiento.
- Errores.

---

# Rendimiento

Optimizar para:

- Bajo consumo de memoria.
- Procesamiento secuencial.
- Interfaz siempre fluida.
- Liberación inmediata de recursos.

---

# Interfaz

Crear una pantalla de procesamiento que permita visualizar:

- Jobs pendientes.
- Jobs ejecutándose.
- Jobs completados.
- Jobs con error.
- Progreso individual.

---

# Manejo de Errores

Controlar:

- Error de FFmpeg.
- Archivo inexistente.
- Archivo corrupto.
- Espacio insuficiente.
- Error de escritura.

Nunca eliminar el video original.

---

# Qué NO debe implementar

No implementar:

- Sincronización.
- Supabase Storage.
- WhatsApp.
- URLs firmadas.
- Galería pública.
- Sesiones privadas.
- Descargas.
- Limpieza automática.

Todo esto pertenece al Sprint 5.

---

# Criterios de aceptación

- TaskQueueService completamente funcional.
- FFmpeg integrado.
- Jobs funcionando.
- Cámara lenta implementada.
- Reverse implementado.
- Boomerang implementado.
- Ráfaga implementada.
- Miniaturas generadas.
- Recuperación tras reinicio funcionando.
- Proyecto compilando sin errores.
- Sin TODOs.
- Cumplimiento del PRD, Anexo Técnico y Coding Rules.

---

# Entregables

- TaskQueueService.
- Sistema de Jobs.
- Motor multimedia.
- Integración con FFmpeg.
- Todos los efectos implementados.
- Proyecto preparado para el Sprint 5.

---

# Definición de Terminado

El Sprint finalizará cuando una sesión confirmada pueda generar automáticamente todos sus efectos mediante el TaskQueueService, manteniendo el video original intacto y dejando toda la información preparada para sincronización.

---

Fin del Sprint 4.
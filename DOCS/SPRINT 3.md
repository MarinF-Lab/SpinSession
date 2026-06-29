# SPRINT 3

# Estudio de Grabación y Gestión de Sesiones

Versión: 1.0

---

# Objetivo

Desarrollar el núcleo operativo de SpinSession.

Al finalizar este Sprint el operador deberá ser capaz de iniciar un evento activo, registrar invitados, configurar cada sesión de grabación, realizar múltiples tomas, confirmar el material generado y dejar las sesiones listas para su procesamiento.

Este Sprint aún no incluye la generación de efectos mediante FFmpeg ni la sincronización de archivos.

---

# Objetivos específicos

Durante este Sprint la IA deberá:

✓ Crear el Estudio de Grabación.

✓ Crear el sistema de Sesiones.

✓ Crear el formulario de registro del invitado.

✓ Crear la configuración general del evento.

✓ Crear la configuración individual por sesión.

✓ Implementar la grabación de video.

✓ Permitir múltiples tomas por sesión.

✓ Crear el sistema de confirmación.

✓ Registrar todas las sesiones en Drift.

✓ Crear el registro de sesiones.

✓ Implementar el modo Operador, Cámara y Ambos.

✓ Crear SpinLab (zona de pruebas).

---

# Dependencias

Utilizar únicamente las dependencias aprobadas.

No instalar nuevas librerías.

---

# Acceso al Estudio

El Estudio de Grabación únicamente podrá abrirse cuando:

- El evento exista.
- El evento esté pagado.
- El evento se encuentre dentro del horario configurado.

Si alguna condición no se cumple deberá mostrarse un mensaje explicativo indicando el motivo.

---

# Modos de Dispositivo

Implementar completamente los tres modos.

## Camera

Permite únicamente:

- Ver la configuración recibida.
- Iniciar grabación.
- Detener grabación.

No podrá modificar eventos.

---

## Operator

Permite:

- Configurar el evento.
- Registrar invitados.
- Configurar sesiones.
- Iniciar grabación.
- Confirmar sesiones.
- Consultar el registro.

---

## Both

Reúne todas las funciones disponibles en un único dispositivo.

---

# Configuración General

Antes de comenzar las sesiones el operador podrá configurar:

- Duración de grabación.
- Resolución.
- Cámara utilizada.
- Calidad.
- Efectos predeterminados.
- Cantidad máxima de tomas por sesión.
- Tiempo de cuenta regresiva.

Estos valores serán heredados automáticamente por todas las sesiones nuevas.

---

# Registro del Invitado

Antes de cada grabación deberá registrarse:

- Nombre del invitado.
- Número telefónico.
- Código de país.
- Observaciones (opcional).

Validaciones:

- Nombre obligatorio.
- Número obligatorio.
- Número válido.
- No permitir campos vacíos.

---

# Configuración Individual

Antes de iniciar una sesión el operador podrá modificar únicamente para esa sesión:

- Duración.
- Efectos.
- Cuenta regresiva.
- Cantidad de tomas.

Estas modificaciones no alterarán la configuración general del evento.

---

# Grabación

Implementar:

- Vista previa de cámara.
- Cuenta regresiva.
- Iniciar grabación.
- Detener grabación.
- Indicador de tiempo.
- Indicador de estado.
- Bloqueo de acciones incompatibles.

Al finalizar la grabación el video deberá almacenarse temporalmente en el dispositivo.

---

# Múltiples Tomas

Cada invitado podrá realizar varias tomas.

Todas pertenecerán a una única sesión.

La interfaz deberá permitir:

- Agregar una nueva toma.
- Repetir una toma.
- Eliminar una toma antes de confirmar.
- Visualizar cuántas tomas existen.

Ninguna toma será definitiva hasta la confirmación.

---

# Confirmación de la Sesión

Una vez terminadas las tomas deberá mostrarse una pantalla de confirmación.

Opciones disponibles:

- Confirmar.
- Repetir toda la sesión.
- Agregar otra toma.
- Cancelar.

Solo al confirmar la sesión quedará registrada oficialmente.

---

# Registro de Sesiones

Crear una pantalla donde el operador pueda visualizar todas las sesiones del evento.

Cada sesión mostrará:

- Nombre del invitado.
- Número telefónico.
- Cantidad de tomas.
- Estado.
- Hora de creación.

Ordenar automáticamente por hora.

---

# Estados de la Sesión

Implementar exactamente los siguientes estados.

Registrada

↓

Grabando

↓

Pendiente de Confirmación

↓

Confirmada

↓

Pendiente de Procesamiento

Estos estados serán utilizados por los siguientes Sprints.

---

# Persistencia

Toda la información deberá almacenarse inmediatamente en Drift.

Registrar:

- Invitado.
- Teléfono.
- Configuración.
- Tomas realizadas.
- Estado.
- Fecha y hora.

Nada deberá perderse si la aplicación se cierra inesperadamente.

---

# SpinLab

Implementar una zona de pruebas independiente.

Características:

- No requiere evento.
- No registra sesiones.
- No guarda videos.
- No sincroniza información.
- No modifica estadísticas.

Permitirá al operador realizar grabaciones de prueba para verificar:

- Encuadre.
- Iluminación.
- Posición.
- Duración.
- Configuración.

Al salir de SpinLab todo el contenido deberá eliminarse automáticamente.

---

# Interfaz

El Estudio de Grabación deberá respetar el Design System oficial.

Utilizar:

- Botones reutilizables.
- Tarjetas oficiales.
- Diálogos oficiales.
- Indicadores claros.
- Animaciones suaves.

Mantener compatibilidad con modo claro y modo oscuro.

---

# Manejo de Errores

Controlar correctamente:

- Cámara no disponible.
- Permisos denegados.
- Grabación interrumpida.
- Falta de almacenamiento.
- Configuración inválida.

Todos los mensajes deberán ser comprensibles para el usuario.

---

# Qué NO debe implementar

No implementar:

- FFmpeg.
- Cámara lenta.
- Reverse.
- Boomerang.
- Ráfaga.
- Miniaturas.
- Procesamiento multimedia.
- Sincronización de archivos.
- Supabase Storage.
- WhatsApp.
- Galería pública.
- Galería privada.
- Descargas.
- URLs firmadas.

Todo esto pertenece a los siguientes Sprints.

---

# Criterios de aceptación

El Sprint se considerará terminado únicamente cuando:

✓ Exista el Estudio de Grabación.

✓ Funcionen los tres modos de dispositivo.

✓ Se puedan registrar invitados.

✓ Exista configuración general.

✓ Exista configuración individual.

✓ Se puedan realizar múltiples tomas.

✓ Funcione la confirmación de sesiones.

✓ Exista el registro de sesiones.

✓ Toda la información se almacene en Drift.

✓ Funcione completamente SpinLab.

✓ El proyecto compile sin errores.

✓ No existan TODOs.

✓ Se respeten el PRD, el Anexo Técnico y las Coding Rules.

---

# Entregables

Al finalizar este Sprint deberá existir:

- Estudio de Grabación completamente funcional.
- Registro de invitados.
- Sistema de sesiones.
- Configuración general.
- Configuración individual.
- Grabación de múltiples tomas.
- Confirmación de sesiones.
- Registro de sesiones.
- SpinLab funcional.
- Persistencia local completa.
- Proyecto listo para comenzar el Sprint 4.

---

# Definición de Terminado

Este Sprint se considera finalizado únicamente cuando el operador pueda realizar una sesión completa de grabación desde el registro del invitado hasta la confirmación, dejando toda la información almacenada correctamente y preparada para el procesamiento multimedia del siguiente Sprint.

---

Fin del Sprint 3.
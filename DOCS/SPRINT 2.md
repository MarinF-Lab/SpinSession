# SPRINT 2

# Gestión Completa de Eventos

Versión: 1.0

---

# Objetivo

Desarrollar el módulo completo de gestión de eventos de SpinSession.

Al finalizar este Sprint el usuario deberá ser capaz de crear, editar, cancelar, pagar, visualizar y administrar completamente sus eventos.

Este Sprint no incluye grabación de videos ni procesamiento multimedia.

---

# Objetivos específicos

Durante este Sprint la IA deberá:

✓ Crear el módulo Calendar.

✓ Crear el módulo Events.

✓ Crear el sistema de Plantillas (Templates).

✓ Crear la gestión de Configuración por Evento.

✓ Crear la lógica de Estados del Evento.

✓ Crear el sistema de Pago (modo simulado).

✓ Crear la generación del QR Público.

✓ Crear el historial de eventos.

✓ Crear filtros y búsqueda.

✓ Integrar completamente Drift.

✓ Sincronizar eventos con Supabase.

---

# Dependencias

No instalar nuevas dependencias.

Utilizar únicamente las aprobadas en el Sprint 1.

---

# Funcionalidades

## Calendario

Implementar un calendario mensual interactivo.

El usuario podrá:

- Cambiar entre meses.
- Seleccionar un día.
- Visualizar eventos programados.
- Identificar rápidamente los días con eventos.
- Crear un evento desde una fecha seleccionada.

El calendario será la pantalla principal del modo Operador.

---

## Lista de Eventos

Cada evento deberá mostrarse como una tarjeta con:

- Nombre.
- Fecha.
- Hora de inicio.
- Hora de término.
- Estado.
- Estado de pago.
- Color identificador según estado.

Ordenar automáticamente por fecha y hora.

---

## Crear Evento

Al crear un evento deberán solicitarse:

- Nombre del evento.
- Fecha.
- Hora de inicio.
- Hora de término.
- Plantilla (opcional).
- Configuración inicial.
- Observaciones (opcional).

El evento no podrá superar las 24 horas de duración.

---

## Validaciones

Validar:

- Nombre obligatorio.
- Fecha válida.
- Hora de inicio menor que la de término.
- Duración máxima de 24 horas.
- No permitir fechas imposibles.
- Evitar eventos duplicados con el mismo nombre y horario.

Todos los errores deberán mostrarse mediante mensajes amigables.

---

## Estados del Evento

Implementar exactamente los siguientes estados:

Reservado

↓

Pendiente de Pago

↓

Pagado

↓

Activo

↓

Finalizado

↓

Archivado

El cambio entre estados deberá realizarse automáticamente cuando corresponda.

---

## Pago

Durante este Sprint el pago será simulado.

El operador podrá:

- Marcar como pagado.
- Volver a pendiente.
- Consultar el estado.

El sistema deberá quedar preparado para integrar Transbank en el futuro.

No implementar aún la pasarela de pago real.

---

## Activación Automática

El evento deberá pasar automáticamente a estado **Activo** cuando:

- El evento esté pagado.
- Se alcance la hora de inicio configurada.

Antes de ese momento no podrán iniciarse sesiones de grabación.

---

## Finalización Automática

El evento pasará automáticamente a **Finalizado** cuando:

- Se alcance la hora de término configurada.

No deberán permitirse nuevas grabaciones después de este momento.

---

## Plantillas

Implementar el sistema de Plantillas.

Cada plantilla permitirá guardar:

- Nombre.
- Duración predeterminada.
- Efectos seleccionados.
- Eliminación automática.
- Configuración general.

Al crear un evento podrá seleccionarse una plantilla para rellenar automáticamente estos valores.

El usuario también podrá modificar la configuración del evento sin alterar la plantilla original.

---

## Configuración del Evento

Cada evento deberá tener su propia configuración independiente.

Configurable:

- Duración de grabación.
- Efectos predeterminados.
- Permitir múltiples sesiones.
- Eliminación automática (manual, 15 días o 30 días).
- Nombre de la galería pública.

Esta configuración sobrescribirá la plantilla únicamente para ese evento.

---

## Código QR Público

Al crear un evento deberá generarse automáticamente un QR público.

Características:

- Disponible antes del inicio del evento.
- Descargable en alta calidad.
- Preparado para impresión.
- Vinculado a la galería pública del evento.

Durante este Sprint la galería podrá mostrar únicamente una pantalla temporal indicando que el evento aún no tiene contenido.

---

## Historial

Implementar un historial completo de eventos.

Cada registro mostrará:

- Nombre.
- Fecha.
- Estado.
- Estado del pago.
- Cantidad de sesiones (temporalmente en 0).
- Fecha de creación.

Permitir búsqueda por nombre.

Permitir ordenar por:

- Fecha.
- Estado.
- Más recientes.
- Más antiguos.

---

## Persistencia

Toda la información deberá almacenarse inmediatamente en Drift.

Cuando exista conexión deberá sincronizarse automáticamente con Supabase.

La interfaz nunca deberá depender de Internet.

---

## Navegación

Implementar la navegación completa entre:

Calendario

↓

Detalle del Evento

↓

Editar Evento

↓

Configuración

↓

Plantillas

↓

Historial

No deberá existir navegación hacia módulos aún no implementados.

---

## Interfaz

Seguir estrictamente el Design System oficial.

Utilizar:

- Tarjetas.
- Botones reutilizables.
- Diálogos oficiales.
- Tipografía definida.
- Paleta oficial.
- Soporte completo para modo claro y oscuro.

No crear estilos personalizados fuera del sistema de diseño.

---

## Manejo de Errores

Todos los errores deberán:

- Ser claros para el usuario.
- No mostrar excepciones técnicas.
- Permitir recuperación cuando sea posible.

Registrar internamente los errores para depuración.

---

# Qué NO debe implementar

No implementar:

- Cámara.
- Grabación.
- FFmpeg.
- Procesamiento multimedia.
- Sesiones.
- Registro de invitados.
- WhatsApp.
- Sincronización de archivos.
- Storage.
- Galería funcional.
- SpinLab.
- Cola de procesamiento.

Todo esto pertenece a los siguientes Sprints.

---

# Criterios de aceptación

El Sprint se considerará terminado únicamente cuando:

✓ El calendario funcione correctamente.

✓ Se puedan crear eventos.

✓ Se puedan editar eventos.

✓ Se puedan eliminar o cancelar eventos.

✓ Funcionen las plantillas.

✓ Exista configuración independiente por evento.

✓ Funcionen correctamente los estados.

✓ Exista pago simulado.

✓ Se genere el QR público.

✓ Exista historial.

✓ Todo funcione en modo Offline.

✓ La sincronización de datos funcione con Supabase.

✓ El proyecto compile sin errores.

✓ No existan TODOs.

✓ No existan archivos innecesarios.

✓ Se respeten el PRD, el Anexo Técnico y las Coding Rules.

---

# Entregables

Al finalizar este Sprint deberá existir:

- Calendario completamente funcional.
- Gestión completa de eventos.
- Sistema de plantillas.
- Configuración independiente por evento.
- Estados automáticos.
- Pago simulado.
- QR público generado.
- Historial de eventos.
- Persistencia local mediante Drift.
- Sincronización con Supabase.
- Proyecto listo para comenzar el Sprint 3.

---

# Definición de Terminado

Este Sprint se considera finalizado únicamente cuando todas las funcionalidades descritas estén completamente implementadas, probadas y operativas, sin depender de desarrollos futuros para su funcionamiento.

---

Fin del Sprint 2.
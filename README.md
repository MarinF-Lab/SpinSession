# SpinSession

> Aplicación móvil profesional para la administración de eventos de plataformas 360°, desarrollada con Flutter bajo una arquitectura Offline First.

Versión del Proyecto: 1.0

---

# Bienvenido al Proyecto

Estás participando en el desarrollo de **SpinSession**.

Antes de escribir una sola línea de código debes comprender que este proyecto prioriza la calidad de la arquitectura, la mantenibilidad y la escalabilidad por encima de la velocidad de desarrollo.

No eres un generador de código.

Tu rol es actuar como un **Ingeniero de Software Senior** responsable de mantener una arquitectura limpia durante todo el proyecto.

---

# Objetivo del Proyecto

SpinSession permite administrar eventos de plataformas 360° mediante una aplicación móvil.

Entre sus principales funcionalidades se encuentran:

- Autenticación de usuarios.
- Administración de eventos.
- Calendario interactivo.
- Gestión de plantillas.
- Registro de invitados.
- Grabación de videos.
- Procesamiento multimedia local.
- Generación de múltiples efectos.
- Funcionamiento Offline First.
- Sincronización automática.
- Galería pública mediante QR.
- Sesiones privadas.
- Compartir enlaces por WhatsApp.
- Gestión de múltiples dispositivos.
- Administración completa desde Android.

Toda la aplicación deberá ser desarrollada siguiendo estrictamente la documentación oficial.

---

# Documentación Oficial

Antes de comenzar cualquier tarea es obligatorio leer completamente los siguientes documentos.

1. README.md
2. PRD.md
3. ANEXO_TECNICO.md
4. CODING_RULES.md
5. Sprint correspondiente

No comenzar el desarrollo sin haber leído todos estos documentos.

---

# Jerarquía de la Documentación

Si dos documentos parecen entrar en conflicto, deberá respetarse el siguiente orden de prioridad.

1. PRD.md
2. ANEXO_TECNICO.md
3. CODING_RULES.md
4. Sprint correspondiente

Nunca modificar la arquitectura para adaptarla al código.

Siempre adaptar el código a la arquitectura.

---

# Tecnologías Oficiales

Framework

Flutter

Lenguaje

Dart

Gestión de Estado

Riverpod

Navegación

GoRouter

Base de datos local

Drift (SQLite)

Backend

Supabase

Storage

Supabase Storage

Procesamiento Multimedia

FFmpeg Kit

Lectura QR

Mobile Scanner

Generación QR

qr_flutter

Arquitectura

Feature First

Offline First

MVVM

Repository Pattern

SOLID

---

# Filosofía del Proyecto

SpinSession se construye siguiendo los siguientes principios.

- Offline First.
- Feature First.
- Código reutilizable.
- Alta cohesión.
- Bajo acoplamiento.
- Arquitectura modular.
- Responsabilidad única.
- Procesamiento local.
- Sincronización diferida.
- Escalabilidad.

Toda decisión deberá respetar estos principios.

---

# Flujo Oficial de Trabajo

Para cada Sprint deberá seguirse exactamente el siguiente procedimiento.

1.

Leer el Sprint completo.

2.

Analizar el impacto de las tareas.

3.

Revisar la arquitectura existente.

4.

Reutilizar componentes cuando sea posible.

5.

Implementar únicamente lo solicitado.

6.

Corregir errores de compilación.

7.

Verificar funcionamiento.

8.

Refactorizar si es necesario.

9.

Finalizar únicamente cuando todos los criterios de aceptación se cumplan.

---

# Restricciones Generales

Está prohibido:

- Inventar funcionalidades.
- Modificar el PRD.
- Cambiar la arquitectura.
- Duplicar código.
- Crear dependencias innecesarias.
- Saltarse un Sprint.
- Crear soluciones temporales.
- Dejar TODOs.
- Dejar código comentado.
- Desactivar validaciones.
- Romper compatibilidad con Android.

---

# Forma Correcta de Pensar

Antes de implementar cualquier cambio debes responder mentalmente las siguientes preguntas.

¿Existe ya una solución?

¿Existe un Widget similar?

¿Existe un Service?

¿Existe un Repository?

¿Existe un Provider?

¿Existe un componente reutilizable?

Si la respuesta es sí, deberá reutilizarse.

---

# Forma Incorrecta de Trabajar

Nunca:

Crear una nueva clase cuando ya exista una equivalente.

Copiar código.

Modificar varias Features para solucionar un problema localizado.

Agregar paquetes innecesarios.

Crear Widgets gigantes.

Crear archivos excesivamente largos.

---

# Organización del Proyecto

La estructura oficial será:

```text
lib/

core/

shared/

features/

auth/

calendar/

events/

recording/

processing/

gallery/

sessions/

sync/

settings/

spinlab/

templates/

main.dart
```

No modificar esta estructura.

---

# Definición de Terminado (Definition of Done)

Una tarea únicamente podrá considerarse terminada cuando:

✓ Compila.

✓ No existen errores.

✓ No existen warnings importantes.

✓ Funciona correctamente.

✓ Respeta el PRD.

✓ Respeta el Anexo Técnico.

✓ Respeta las Coding Rules.

✓ No rompe funcionalidades existentes.

✓ Mantiene compatibilidad Android.

✓ Mantiene compatibilidad futura con iOS.

✓ Mantiene modo claro.

✓ Mantiene modo oscuro.

✓ El código es legible.

✓ El código es reutilizable.

✓ No existen TODOs.

✓ No existen comentarios innecesarios.

---

# Qué Espero de la IA

Quiero que trabajes como un desarrollador Senior.

No quiero soluciones rápidas.

No quiero hacks.

No quiero código temporal.

No quiero código duplicado.

Quiero una arquitectura limpia.

Quiero componentes reutilizables.

Quiero funciones pequeñas.

Quiero código profesional.

---

# Checklist Antes de Finalizar una Tarea

Antes de entregar cualquier implementación verifica:

□ El proyecto compila.

□ No existen errores.

□ No existen excepciones.

□ La UI funciona.

□ La navegación funciona.

□ No existen imports innecesarios.

□ No existen dependencias innecesarias.

□ Se reutilizaron componentes existentes.

□ El código cumple SOLID.

□ El código cumple DRY.

□ El código cumple KISS.

□ La Feature continúa siendo independiente.

□ No se rompió ninguna otra funcionalidad.

---

# Flujo de Commits Recomendado

Cada funcionalidad deberá desarrollarse mediante commits pequeños y descriptivos.

Ejemplos:

feat(auth): implement login screen

feat(theme): add dark mode

feat(events): create event repository

fix(sync): retry failed uploads

refactor(shared): simplify custom button

Evitar commits masivos.

---

# Calidad del Código

La calidad tiene prioridad sobre la velocidad.

Es preferible escribir menos código, pero correctamente estructurado, que implementar rápidamente una solución difícil de mantener.

Cuando existan varias soluciones posibles, elegir siempre la más simple, mantenible y consistente con la arquitectura oficial.

---

# Inicio del Desarrollo

Antes de comenzar cualquier Sprint debes confirmar que:

- Has leído este README.
- Has leído el PRD completo.
- Has leído el Anexo Técnico completo.
- Has leído las Coding Rules.
- Comprendes el Sprint actual.
- No implementarás funcionalidades fuera del Sprint.

Solo entonces podrás comenzar el desarrollo.

---

# Objetivo Final

El objetivo de SpinSession no es únicamente desarrollar una aplicación funcional.

El objetivo es construir un software profesional, robusto, escalable y mantenible, preparado para evolucionar durante años sin necesidad de rediseñar su arquitectura.

Toda decisión técnica deberá tomarse pensando en el largo plazo.

# SpinSession Coding Rules

Versión 1.0

Estas reglas son obligatorias.

---

# Regla 1

Nunca modificar archivos no relacionados con la tarea actual.

---

# Regla 2

Nunca crear código duplicado.

Buscar siempre reutilizar componentes existentes.

---

# Regla 3

No crear archivos de más de 400 líneas.

Si un archivo supera ese tamaño deberá dividirse.

---

# Regla 4

No crear widgets de más de 250 líneas.

---

# Regla 5

Una clase tendrá una única responsabilidad.

---

# Regla 6

Toda lógica irá fuera de la UI.

Las pantallas únicamente mostrarán información.

---

# Regla 7

Nunca acceder directamente a Supabase desde una Screen.

Siempre utilizar Repository.

---

# Regla 8

Nunca acceder directamente a Drift desde una Screen.

Siempre utilizar Repository.

---

# Regla 9

Toda dependencia deberá inyectarse mediante Riverpod.

---

# Regla 10

No utilizar variables globales.

---

# Regla 11

Todo archivo deberá utilizar:

snake_case

---

# Regla 12

Toda clase utilizará:

PascalCase

---

# Regla 13

Toda variable utilizará:

camelCase

---

# Regla 14

Toda constante utilizará:

UPPER_SNAKE_CASE

---

# Regla 15

No comentar código obvio.

---

# Regla 16

Crear funciones pequeñas.

Máximo recomendado:

30 líneas.

---

# Regla 17

Crear Widgets pequeños.

---

# Regla 18

Crear Services especializados.

No crear Services gigantes.

---

# Regla 19

Crear Providers únicamente cuando exista estado compartido.

---

# Regla 20

Todo acceso a Internet deberá contemplar modo Offline.

---

# Regla 21

Nunca bloquear la interfaz.

Toda tarea pesada será asíncrona.

---

# Regla 22

Toda nueva funcionalidad deberá incluir manejo de errores.

---

# Regla 23

No utilizar valores mágicos.

Crear constantes.

---

# Regla 24

Mantener consistencia visual.

Utilizar únicamente el Design System oficial.

---

# Regla 25

Antes de escribir código comprobar:

¿Existe ya?

Si existe, reutilizar.

---

# Regla 26

No instalar nuevas dependencias sin autorización.

---

# Regla 27

No modificar la arquitectura definida en el PRD ni en el Anexo Técnico.

---

# Regla 28

Toda implementación deberá compilar antes de considerarse terminada.

---

# Regla 29

Si existen varias soluciones válidas, elegir siempre la más simple, mantenible y consistente con la arquitectura del proyecto.

---

# Regla 30 (Regla de Oro)

La calidad del código tiene prioridad sobre la velocidad de implementación.

Es preferible escribir menos código, pero bien estructurado, que implementar rápidamente una solución difícil de mantener.
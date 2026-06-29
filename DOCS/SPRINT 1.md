# SPRINT 1

# Infraestructura Base del Proyecto

Versión: 1.0

---

# Objetivo

Construir la infraestructura completa de SpinSession sobre Flutter.

Al finalizar este Sprint deberá existir una aplicación completamente funcional desde el punto de vista estructural, aunque todavía no tendrá funcionalidades relacionadas con eventos ni grabaciones.

Este Sprint es exclusivamente de arquitectura.

---

# Objetivos específicos

Durante este Sprint la IA deberá:

✓ Crear el proyecto Flutter.

✓ Configurar Android como plataforma principal.

✓ Mantener compatibilidad futura con iOS.

✓ Configurar Riverpod.

✓ Configurar GoRouter.

✓ Configurar Drift.

✓ Configurar Supabase.

✓ Configurar Supabase Storage.

✓ Configurar el sistema de temas.

✓ Configurar el sistema de navegación.

✓ Configurar la estructura completa de carpetas.

✓ Configurar la inyección de dependencias.

✓ Crear widgets reutilizables básicos.

✓ Crear la estructura base de Features.

✓ Configurar assets.

✓ Configurar fuentes.

✓ Configurar colores.

---

# Dependencias

Instalar únicamente las dependencias aprobadas.

flutter_riverpod

go_router

drift

sqlite3

drift_flutter

supabase_flutter

camera

ffmpeg_kit_flutter_new

connectivity_plus

permission_handler

mobile_scanner

qr_flutter

path_provider

uuid

intl

flutter_launcher_icons

flutter_native_splash

Aún NO instalar librerías innecesarias.

---

# Estructura del proyecto

La estructura deberá seguir exactamente la definida en el Anexo Técnico.

No modificarla.

No simplificarla.

---

# Navegación

Crear las rutas principales.

/

login

register

device-selection

home

calendar

settings

Todas podrán contener pantallas temporales excepto Login.

---

# Autenticación

Implementar:

Login

Registro

Cerrar sesión

Persistencia de sesión

Recuperación automática

No implementar todavía permisos por evento.

---

# Sistema de Temas

Crear:

Modo Claro

Modo Oscuro

Aplicar la identidad visual oficial de SpinSession.

Color principal:

Morado vibrante.

Modo oscuro:

Azul muy oscuro con matiz violáceo.

No utilizar negro puro.

---

# Widgets Base

Crear componentes reutilizables.

PrimaryButton

SecondaryButton

LoadingIndicator

CustomTextField

PhoneInput

ConfirmationDialog

EmptyState

LoadingScreen

ErrorScreen

Todos deberán respetar el diseño oficial.

---

# Assets

Configurar carpetas.

assets/

images/

icons/

fonts/

animations/

sounds/

---

# Providers Globales

Crear Providers para:

Auth

Theme

Router

Connectivity

CurrentUser

No crear todavía Providers de Eventos.

---

# Pantallas

Implementar completamente:

Splash

Login

Registro

Selección de dispositivo

Configuración

Las demás podrán existir como placeholders.

---

# Selección de dispositivo

Implementar los tres modos.

Camera

Operator

Both

Guardar la selección localmente.

---

# Qué NO debe implementar

No crear Eventos.

No crear Calendario.

No crear Grabación.

No crear Cámara.

No crear FFmpeg.

No crear Sincronización.

No crear Supabase Storage.

No crear WhatsApp.

No crear QR.

No crear Galería.

No crear Base de Datos del proyecto.

Eso pertenece a los siguientes Sprints.

---

# Criterios de aceptación

El Sprint se considera terminado únicamente si:

La aplicación compila.

No existen errores.

Existe Login funcional.

Existe Registro funcional.

Existe cambio de tema.

Existe navegación.

Existe selección de dispositivo.

Existe persistencia de sesión.

La estructura coincide con el Anexo Técnico.

No existen archivos innecesarios.

No existen TODOs.

---

# Entregables

Proyecto Flutter.

Arquitectura completa.

Tema oficial.

Autenticación.

Navegación.

Widgets base.

Proyecto listo para comenzar Sprint 2.

---

Fin del Sprint 1.
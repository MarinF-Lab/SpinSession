# PRODUCT REQUIREMENTS DOCUMENT (PRD)

# SpinSession

Versión: 1.0 (MVP)

Estado: En desarrollo

---

# 1. Introducción

## 1.1 Descripción

SpinSession es una aplicación móvil diseñada para la administración integral de plataformas 360 para eventos sociales y corporativos.

El sistema busca simplificar el trabajo del operador permitiendo administrar eventos, controlar dispositivos de grabación, procesar videos localmente, generar múltiples efectos, sincronizar información incluso sin conexión a internet y distribuir automáticamente el contenido generado a los invitados mediante WhatsApp y una galería web pública.

La filosofía principal del proyecto es **Offline First**, garantizando que ningún evento dependa de una conexión permanente a internet.

---

# 2. Objetivo del producto

Crear la plataforma móvil más completa para operadores de plataformas 360, centralizando todo el flujo de trabajo en una sola aplicación.

Desde la planificación del evento hasta la entrega final del contenido al invitado.

---

# 3. Objetivos específicos

El sistema deberá permitir:

• Gestionar eventos mediante un calendario interactivo.

• Reservar eventos antes de realizar el pago.

• Posponer el pago hasta una fecha límite configurable.

• Activar automáticamente los eventos a la hora programada.

• Limitar la duración máxima de un evento a 24 horas.

• Funcionar completamente sin conexión a internet.

• Procesar videos localmente utilizando FFmpeg.

• Generar múltiples versiones de un mismo video desde una sola grabación.

• Administrar sesiones de invitados en lugar de videos individuales.

• Enviar automáticamente el contenido por WhatsApp cuando exista conexión.

• Mantener una galería pública del evento accesible mediante un código QR.

• Sincronizar toda la información cuando el dispositivo recupere conexión.

---

# 4. Filosofía del proyecto

SpinSession se desarrolla bajo cinco principios fundamentales.

## 4.1 Offline First

Toda acción realizada por el operador deberá almacenarse primero en el dispositivo.

Posteriormente podrá sincronizarse con el servidor.

Nunca deberá perderse información por falta de internet.

---

## 4.2 Un evento como núcleo del sistema

Toda la aplicación gira alrededor del concepto de Evento.

No existen videos independientes.

No existen invitados independientes.

Todo pertenece a un evento.

---

## 4.3 Sesiones

Cada invitado genera una Sesión.

Una sesión puede contener:

• Una o varias tomas.

• Uno o varios videos procesados.

• Fotografías.

• Distintos efectos.

Todo el contenido generado permanece agrupado dentro de la misma sesión.

---

## 4.4 Automatización

El operador solo debe preocuparse de grabar.

Todo lo demás debe ejecutarse automáticamente mediante colas de procesamiento:

• Procesamiento.

• Generación de efectos.

• Sincronización.

• Subida.

• Envío por WhatsApp.

---

## 4.5 Escalabilidad

Aunque el MVP estará dirigido a Android, toda la arquitectura deberá diseñarse para permitir futuras versiones multiplataforma y nuevas funcionalidades sin requerir una reestructuración completa del sistema.

---

# 5. Usuarios del sistema

## Operador

Responsable de:

• Administrar su cuenta.

• Crear eventos.

• Configurar plantillas.

• Realizar pagos.

• Controlar dispositivos.

• Gestionar sesiones.

• Descargar contenido.

• Administrar galerías.

---

## Dispositivo Cámara

Modo simplificado de la aplicación.

Su única responsabilidad será:

• Esperar órdenes.

• Grabar.

• Procesar localmente.

• Sincronizar resultados.

No tendrá acceso a funciones administrativas.

---

## Invitado

No requiere cuenta.

Accede únicamente mediante el código QR público del evento.

Puede:

• Visualizar la galería.

• Reproducir videos.

No puede administrar contenido ni acceder a funciones privadas.

---

# 6. Visión general del flujo

Login

↓

Selección de modo del dispositivo

↓

Calendario

↓

Crear o abrir evento

↓

Reserva

↓

Pago

↓

Evento Activo

↓

Sesiones

↓

Grabación

↓

Vista previa

↓

Aceptar / Repetir / Agregar toma

↓

Procesamiento local

↓

Generación de efectos

↓

Registro de sesión

↓

Sincronización

↓

Galería pública

↓

WhatsApp

↓

Finalización del evento

↓

Historial

---

Fin del capítulo 1.

# PRODUCT REQUIREMENTS DOCUMENT (PRD)

# Capítulo 2 - Reglas de Negocio

Versión: 1.0

---

# 2. Reglas de Negocio

Este capítulo define las reglas funcionales que gobiernan el comportamiento de SpinSession. Estas reglas son obligatorias y deberán respetarse durante todo el desarrollo.

---

# 2.1 Cuenta de Usuario

Cada usuario administra exclusivamente su propia información.

Un usuario podrá:

* Crear eventos.
* Editar eventos.
* Eliminar eventos permitidos.
* Configurar plantillas.
* Administrar dispositivos.
* Descargar sus sesiones.
* Gestionar su cuenta.

Ningún usuario podrá visualizar o modificar información perteneciente a otra cuenta.

---

# 2.2 Dispositivos

Un mismo usuario podrá iniciar sesión en múltiples dispositivos.

Al iniciar sesión deberá seleccionar el modo de funcionamiento.

## Operador

Permite:

* Calendario.
* Agendar eventos.
* Pagos.
* Configuración.
* Estudio de grabación.
* Historial.
* Descargas.
* Administración.

---

## Cámara

Interfaz simplificada.

Solo podrá:

* Esperar órdenes.
* Grabar.
* Procesar localmente.
* Sincronizar.

No tendrá acceso al calendario ni a configuraciones administrativas.

---

## Operador + Cámara

Combina ambos modos.

Permite utilizar un solo dispositivo cuando el operador no dispone de un segundo teléfono.

---

# 2.3 Estados del Evento

Todo evento deberá pasar por los siguientes estados.

## Reservado

Evento recién creado.

Permite:

* Modificar información.
* Cambiar fecha.
* Eliminar.
* Cancelar.

No permite grabaciones.

---

## Pendiente de Pago

El evento fue reservado.

Existe una fecha límite para realizar el pago.

Si el pago no se registra antes del límite configurado, el evento podrá cancelarse automáticamente o quedar marcado para revisión, según la configuración futura del sistema.

---

## Pagado

El evento queda confirmado.

Todavía no permite grabar.

Permanece esperando la hora de inicio.

---

## Activo

El sistema activará automáticamente el evento al llegar la hora configurada.

Durante este estado:

* Se habilitan las sesiones.
* Se habilitan las grabaciones.
* Se habilita la sincronización.
* El QR público permanece disponible.

---

## Pausado

El operador puede pausar temporalmente el evento.

Mientras permanezca pausado:

* No podrán iniciarse nuevas sesiones.
* Las tareas en segundo plano continuarán ejecutándose.

---

## Finalizado

El evento deja de aceptar nuevas sesiones.

Continúan disponibles:

* Descargas.
* Sincronización.
* Envíos pendientes.
* Historial.

---

## Archivado

Evento únicamente disponible para consulta.

No permite modificaciones.

---

# 2.4 Duración del Evento

Todo evento deberá definir:

* Hora de inicio.
* Hora de término.

Reglas:

La duración nunca podrá superar las 24 horas.

El sistema validará esta condición antes de guardar el evento.

---

# 2.5 Pago

El pago confirma la reserva.

No activa inmediatamente el evento.

La activación dependerá exclusivamente de la hora de inicio configurada.

El operador podrá registrar el pago incluso varios días antes del evento, siempre que se encuentre dentro del período permitido.

---

# 2.6 Plantillas

El usuario podrá crear plantillas reutilizables.

Cada plantilla almacenará configuraciones predeterminadas como:

* Duración.
* Efectos.
* Cantidad máxima de tomas.
* Generación de fotografías.
* Tiempo de conservación.
* Mensajes predeterminados.

Al crear un nuevo evento, el operador podrá seleccionar una plantilla y modificar cualquier configuración específica para ese evento sin alterar la plantilla original.

---

# 2.7 Sesiones

Toda grabación pertenece a una sesión.

Una sesión representa a un invitado o grupo de invitados.

Cada sesión podrá contener:

* Nombre.
* Teléfono.
* Una o varias tomas.
* Archivos procesados.
* Fotografías.
* Estado.

Nunca existirán videos independientes fuera de una sesión.

---

# 2.8 Grabaciones

El flujo será el siguiente:

Registrar invitado.

↓

Configurar rápidamente la sesión (utilizando los valores generales del evento como predeterminados).

↓

Iniciar grabación.

↓

Vista previa.

↓

Aceptar.

Repetir.

Agregar otra toma.

Solo al aceptar la sesión comenzará el procesamiento.

---

# 2.9 Procesamiento

Toda grabación original será procesada localmente en el dispositivo mediante FFmpeg.

El sistema podrá generar múltiples archivos desde una única grabación.

Ejemplos:

* Video normal.
* Cámara lenta.
* Boomerang.
* Reversa.
* Ráfaga de fotografías.

Cada efecto podrá activarse o desactivarse individualmente según la configuración del evento o de la sesión.

---

# 2.10 Cola de Procesamiento

Las tareas deberán ejecutarse en segundo plano.

Orden recomendado:

1. Procesar grabación original.
2. Generar efectos seleccionados.
3. Registrar archivos.
4. Esperar sincronización.
5. Subir contenido.
6. Enviar WhatsApp.
7. Actualizar galería.

La interfaz nunca deberá bloquearse durante este proceso.

---

# 2.11 Offline First

Toda la información deberá guardarse primero en el almacenamiento local del dispositivo.

Incluyendo:

* Eventos.
* Configuraciones.
* Plantillas.
* Sesiones.
* Grabaciones.
* Estados.
* Cola de sincronización.

La pérdida de conexión nunca deberá impedir continuar trabajando.

---

# 2.12 Sincronización

La sincronización será manual o automática cuando exista conexión.

Se sincronizarán:

* Eventos.
* Sesiones.
* Videos.
* Fotografías.
* Estados.
* Mensajes enviados.
* Galería.

Cada elemento conservará su estado hasta completar exitosamente el proceso.

---

# 2.13 WhatsApp

Cada sesión podrá enviar un único mensaje al invitado.

El mensaje contendrá:

* Nombre del evento.
* Enlace directo a su sesión o contenido.
* Enlace a la galería pública del evento.

Los envíos fallidos permanecerán pendientes hasta que el operador decida reenviarlos.

---

# 2.14 Galería Pública

Cada evento tendrá una galería pública accesible mediante un código QR único.

La galería estará disponible desde el momento en que se crea el evento, aunque inicialmente permanecerá vacía.

Cada vez que una sesión sea sincronizada correctamente, su contenido aparecerá automáticamente en la galería.

Los visitantes únicamente podrán visualizar el contenido publicado.

---

# 2.15 Conservación de Archivos

Cada evento permitirá definir una política de conservación.

Opciones iniciales:

* Eliminación manual.
* Eliminación automática a los 15 días.
* Eliminación automática a los 30 días.

Antes de eliminar un evento, el operador podrá descargar todas las sesiones en un único paquete comprimido.

---

Fin del capítulo 2.

# PRODUCT REQUIREMENTS DOCUMENT (PRD)

# Capítulo 3 - Modelo Funcional del Sistema

Versión: 1.0

---

# 3. Modelo Funcional

## 3.1 Visión General

SpinSession está organizado en módulos independientes que trabajan sobre un mismo núcleo: **el Evento**.

Todo el contenido generado por la aplicación pertenece siempre a un evento.

Los módulos deberán ser desacoplados para facilitar futuras ampliaciones sin afectar el funcionamiento del resto del sistema.

---

# 3.2 Núcleo del Sistema

La estructura funcional será:

Usuario

↓

Eventos

↓

Sesiones

↓

Grabaciones

↓

Procesamiento

↓

Sincronización

↓

Galería

↓

Historial

Todo módulo deberá relacionarse con alguno de estos elementos principales.

---

# 3.3 Módulo de Autenticación

Responsabilidades:

• Inicio de sesión.

• Registro de usuario.

• Recuperación de contraseña.

• Cierre de sesión.

• Gestión de sesión activa.

• Cambio de cuenta.

Después del primer inicio de sesión exitoso se solicitará seleccionar el modo del dispositivo.

---

# 3.4 Módulo de Dispositivos

Cada dispositivo podrá funcionar en uno de los siguientes modos.

## Operador

Funciones disponibles:

• Calendario.

• Eventos.

• Pagos.

• Configuración.

• Estudio de grabación.

• Historial.

• Descargas.

• Administración de dispositivos.

---

## Cámara

Funciones disponibles:

• Esperar conexión.

• Recibir órdenes de grabación.

• Configuración básica de cámara.

• Procesamiento local.

• Sincronización.

No tendrá acceso a funciones administrativas.

---

## Operador + Cámara

Combina las funcionalidades de ambos modos para trabajar con un único dispositivo.

---

# 3.5 Módulo Calendario

Será la pantalla principal del modo Operador.

Funciones:

• Visualizar calendario mensual.

• Crear eventos.

• Abrir eventos existentes.

• Mostrar estado del evento mediante indicadores visuales.

Estados visibles:

• Reservado.

• Pendiente de pago.

• Pagado.

• Activo.

• Finalizado.

• Archivado.

Desde esta pantalla también se podrá acceder al QR público del evento para descargarlo antes de comenzar la jornada.

---

# 3.6 Módulo Eventos

Cada evento almacenará:

• Nombre.

• Fecha.

• Hora de inicio.

• Hora de término.

• Estado.

• Plantilla utilizada.

• Configuración general.

• Código QR público.

• Política de conservación.

• Historial.

Desde este módulo podrán modificarse las configuraciones mientras el evento no se encuentre activo.

---

# 3.7 Módulo Plantillas

Permitirá reutilizar configuraciones.

Cada plantilla podrá definir:

• Duración de grabación.

• Efectos.

• Fotografías.

• Cantidad máxima de tomas por sesión.

• Tiempo de conservación.

• Configuración de procesamiento.

Las plantillas nunca modificarán eventos ya creados.

---

# 3.8 Estudio de Grabación

Este módulo solo estará disponible cuando el evento se encuentre activo.

Funciones:

Registrar sesión.

↓

Configurar rápidamente la sesión.

↓

Iniciar grabación.

↓

Vista previa.

↓

Aceptar.

↓

Agregar otra toma (opcional).

↓

Finalizar sesión.

Las configuraciones generales del evento aparecerán como valores predeterminados, pero podrán modificarse para una sesión específica sin afectar el resto del evento.

---

# 3.9 Registro de Sesiones

Cada evento tendrá un registro independiente.

Cada sesión mostrará:

• Nombre.

• Teléfono.

• Cantidad de tomas.

• Archivos generados.

• Fecha y hora.

• Estado.

Estados posibles:

• Pendiente de procesamiento.

• Procesando.

• Pendiente de sincronización.

• Sincronizando.

• Enviado.

• Error.

Desde este módulo podrán descargarse una o todas las sesiones del evento.

---

# 3.10 Procesamiento

Todas las tareas relacionadas con FFmpeg serán ejecutadas en segundo plano.

El procesamiento será completamente independiente de la interfaz.

El operador podrá continuar utilizando la aplicación mientras se generan los archivos.

---

# 3.11 Sincronización

Responsable de sincronizar toda la información del dispositivo.

Incluye:

• Eventos.

• Configuraciones.

• Sesiones.

• Archivos.

• Estados.

• Historial.

El sistema permitirá iniciar la sincronización manualmente cuando existan elementos pendientes.

---

# 3.12 Galería Pública

Cada evento tendrá una página pública accesible mediante un código QR.

La página incluirá:

• Imagen de portada (opcional).

• Nombre del evento.

• Fecha.

• Contador de contenido publicado.

• Galería cronológica.

• Reproductor de videos.

El contenido aparecerá automáticamente conforme las sesiones sean sincronizadas.

---

# 3.13 Configuración

Permitirá administrar:

Cuenta.

Dispositivos.

Plantillas.

Preferencias.

Notificaciones.

Políticas de conservación.

Información de la aplicación.

Acerca de.

Cerrar sesión.

---

# 3.14 Historial

Mostrará todos los eventos del usuario.

Permitirá:

• Consultar eventos finalizados.

• Descargar contenido.

• Revisar estadísticas básicas.

• Eliminar eventos cuando corresponda.

---

# 3.15 Comunicación entre Dispositivos

Cuando existan varios dispositivos conectados a la misma cuenta, el Operador visualizará una lista con los dispositivos disponibles.

Desde el Estudio de Grabación podrá seleccionar cuál utilizar para iniciar las grabaciones.

La Cámara recibirá la orden de grabación y devolverá automáticamente el resultado para continuar con el procesamiento y la sincronización.

---

# 3.16 Módulos Futuros

La arquitectura deberá permitir incorporar nuevos módulos sin modificar el núcleo del sistema.

Ejemplos:

• Integración con cámaras externas.

• Fotocabinas.

• Iluminación inteligente.

• Panel web administrativo.

• Estadísticas avanzadas.

• Inteligencia artificial para edición.

Estos módulos no forman parte del MVP, pero deberán ser considerados durante el diseño de la arquitectura.

---

Fin del capítulo 3.

# PRODUCT REQUIREMENTS DOCUMENT (PRD)

# Capítulo 4 - Navegación y Flujo de Usuario (UX)

Versión: 1.0

---

# 4. Navegación de la Aplicación

## 4.1 Objetivo

La navegación de SpinSession debe ser rápida, intuitiva y optimizada para el trabajo durante eventos.

El operador debe poder realizar cualquier acción importante con el menor número posible de pulsaciones.

La interfaz estará diseñada bajo el principio de **"mínima interacción, máxima velocidad"**.

---

# 4.2 Flujo Inicial

Al abrir la aplicación por primera vez:

Splash Screen

↓

Comprobación de sesión

↓

¿Existe una sesión iniciada?

NO

↓

Login

↓

Registro (opcional)

↓

Seleccionar modo del dispositivo

↓

Operador

Cámara

Operador + Cámara

↓

Pantalla principal correspondiente.

---

# 4.3 Flujo de Inicio

Si el usuario ya inició sesión anteriormente:

Splash Screen

↓

Validación de sesión

↓

Pantalla principal

No deberá solicitar nuevamente el modo del dispositivo, salvo que el usuario decida cambiarlo desde Configuración.

---

# 4.4 Navegación del Modo Operador

La aplicación utilizará una barra de navegación inferior compuesta por tres pestañas principales.

Calendario

↓

Estudio

↓

Registro

Desde cualquiera de estas pantallas será posible acceder al menú de Configuración.

---

# 4.5 Calendario

Será la pantalla principal.

Desde aquí el operador podrá:

• Visualizar el calendario mensual.

• Crear un nuevo evento.

• Abrir un evento existente.

• Consultar el estado de cada evento.

• Descargar el código QR público.

• Revisar información rápida del evento.

Al seleccionar un evento se abrirá su ficha completa.

---

# 4.6 Flujo para Crear un Evento

Calendario

↓

Seleccionar día

↓

Nuevo Evento

↓

Nombre del evento

↓

Seleccionar plantilla (opcional)

↓

Hora de inicio

↓

Hora de término

↓

Configurar fecha límite de pago

↓

Guardar reserva

↓

Estado: Reservado

El operador podrá regresar posteriormente para registrar el pago.

---

# 4.7 Pago del Evento

Evento

↓

Registrar pago

↓

Pago confirmado

↓

Estado: Pagado

El evento permanecerá bloqueado hasta la hora de inicio.

---

# 4.8 Activación del Evento

Al llegar la hora configurada:

El sistema cambiará automáticamente el estado a:

ACTIVO

Sin intervención del operador.

Si intenta ingresar antes de la hora programada, visualizará un mensaje indicando cuánto tiempo falta para el inicio.

---

# 4.9 Estudio

Solo mostrará eventos activos.

Flujo:

Seleccionar evento activo

↓

Registrar nueva sesión

↓

Nombre

↓

Teléfono

↓

Configuración rápida

↓

Iniciar grabación

↓

Cuenta regresiva

↓

Grabación

↓

Vista previa

↓

Aceptar

Repetir

Agregar otra toma

↓

Finalizar sesión

↓

Procesamiento en segundo plano

↓

Regresar automáticamente al formulario de una nueva sesión.

---

# 4.10 Configuración Rápida

Antes de cada grabación aparecerán las configuraciones heredadas del evento.

El operador podrá modificarlas únicamente para esa sesión.

Opciones:

• Duración.

• Efectos.

• Fotografías.

• Cantidad máxima de tomas.

Las modificaciones no afectarán la configuración general del evento.

---

# 4.11 Agregar Tomas

Después de aceptar una grabación el operador podrá:

Aceptar sesión.

↓

Agregar otra toma.

↓

Nueva grabación.

↓

Aceptar.

↓

Agregar otra toma.

↓

Finalizar sesión.

Todas las tomas pertenecerán a la misma sesión.

---

# 4.12 Registro

Cada evento tendrá su propio registro.

Cada tarjeta mostrará:

Nombre.

Teléfono.

Cantidad de tomas.

Cantidad de archivos generados.

Estado.

Fecha.

Hora.

Desde aquí será posible:

Ver detalles.

Descargar sesión.

Reenviar pendientes.

Eliminar sesión cuando corresponda.

---

# 4.13 Estados del Registro

Cada sesión mostrará visualmente uno de los siguientes estados:

Pendiente de procesamiento.

Procesando.

Pendiente de sincronización.

Sincronizando.

WhatsApp enviado.

Finalizada.

Error.

El estado deberá actualizarse automáticamente.

---

# 4.14 Historial del Evento

Desde el registro será posible visualizar:

Cantidad de sesiones.

Cantidad de grabaciones.

Cantidad de videos generados.

Pendientes.

Errores.

Espacio utilizado.

---

# 4.15 Descargas

El operador podrá:

Descargar una sesión.

Descargar múltiples sesiones.

Descargar todo el evento en un único archivo comprimido.

---

# 4.16 Navegación del Modo Cámara

El modo Cámara mostrará únicamente la información necesaria para grabar.

Pantalla principal:

Estado del dispositivo.

↓

Evento activo.

↓

Esperando orden.

↓

Grabación.

↓

Vista previa.

↓

Aceptar.

Repetir.

↓

Procesamiento local.

↓

Esperando siguiente orden.

No tendrá acceso al calendario ni al historial.

---

# 4.17 Navegación Operador + Cámara

Mostrará exactamente la misma navegación del modo Operador.

La diferencia será que las órdenes de grabación utilizarán directamente la cámara del mismo dispositivo.

No será necesario seleccionar otro dispositivo.

---

# 4.18 Configuración

Disponible desde cualquier pantalla.

Opciones:

Mi cuenta.

Modo del dispositivo.

Dispositivos conectados.

Plantillas.

Preferencias.

Conservación de archivos.

Información.

Cerrar sesión.

---

# 4.19 Experiencia del Invitado

Al escanear el código QR público accederá a la página del evento.

La página mostrará:

Imagen de portada (opcional).

Nombre del evento.

Fecha.

Contador de contenido publicado.

Galería cronológica.

Reproductor de video.

La página deberá actualizarse automáticamente conforme se publiquen nuevas sesiones.

No requerirá autenticación.

---

# 4.20 Principios de Diseño UX

Toda interacción deberá priorizar:

• Velocidad.

• Simplicidad.

• Botones grandes.

• Uso con una mano.

• Mínimos pasos posibles.

• Alto contraste para eventos nocturnos.

• Interfaz preparada para uso continuo durante varias horas.

El operador nunca deberá sentirse obligado a navegar entre múltiples pantallas para realizar una grabación.

---

Fin del capítulo 4.

# PRODUCT REQUIREMENTS DOCUMENT (PRD)

# Capítulo 5 - Modelo Conceptual de Datos

Versión: 1.0

---

# 5. Modelo Conceptual de Datos

## 5.1 Objetivo

Este capítulo define las entidades principales de SpinSession y las relaciones entre ellas.

No representa el diseño físico de la base de datos, sino el modelo conceptual que servirá como base para la arquitectura, las API y la persistencia de datos.

Toda la información del sistema deberá organizarse alrededor del **Evento**, siendo este la entidad principal.

---

# 5.2 Jerarquía General

Usuario

↓

Eventos

↓

Sesiones

↓

Tomas

↓

Archivos Generados

Todo el contenido del sistema deberá respetar esta estructura.

---

# 5.3 Usuario

Representa al propietario de la cuenta.

Cada usuario podrá administrar exclusivamente su propia información.

### Información principal

* UUID
* Nombre
* Correo electrónico
* Contraseña (cifrada)
* Fecha de creación
* Estado de la cuenta
* Preferencias generales

### Relaciones

Un usuario puede tener:

* Muchos eventos.
* Muchas plantillas.
* Muchos dispositivos registrados.

---

# 5.4 Dispositivo

Representa cada teléfono que inicia sesión.

### Información principal

* UUID
* Nombre del dispositivo
* Modelo
* Sistema operativo
* Versión de la aplicación
* Modo de funcionamiento
* Estado de conexión

### Modos

* Operador
* Cámara
* Operador + Cámara

### Relaciones

Un dispositivo puede participar en muchas sesiones.

Cada toma registrará qué dispositivo realizó la grabación.

---

# 5.5 Plantilla

Representa una configuración reutilizable.

### Información principal

* UUID
* Nombre
* Duración predeterminada
* Efectos habilitados
* Generación de fotografías
* Cantidad máxima de tomas
* Política de conservación
* Configuración de procesamiento

### Relaciones

Una plantilla podrá utilizarse en múltiples eventos.

Modificar una plantilla nunca alterará eventos ya creados.

---

# 5.6 Evento

Es la entidad principal del sistema.

Todo pertenece a un evento.

### Información principal

* UUID
* Nombre
* Fecha
* Hora de inicio
* Hora de término
* Estado
* Fecha límite de pago
* Fecha de pago
* Código QR público
* Imagen de portada (opcional)
* Política de conservación

### Relaciones

Un evento contiene:

* Muchas sesiones.
* Una galería pública.
* Una plantilla (opcional).

---

# 5.7 Sesión

Representa a un invitado o grupo de invitados.

Nunca representa un video.

### Información principal

* UUID
* Nombre del invitado
* Número de teléfono
* Fecha
* Hora
* Estado
* Evento asociado

### Estados

* Pendiente de procesamiento
* Procesando
* Pendiente de sincronización
* Sincronizando
* Finalizada
* Error

### Relaciones

Una sesión contiene:

* Una o varias tomas.
* Muchos archivos generados.

---

# 5.8 Toma

Representa una grabación original realizada por la cámara.

### Información principal

* UUID
* Número de toma dentro de la sesión
* Duración
* Configuración utilizada
* Dispositivo que realizó la grabación
* Fecha
* Hora

Cada toma conservará siempre el archivo original.

---

# 5.9 Configuración de la Toma

Cada toma almacenará una copia de la configuración utilizada.

Ejemplo:

* Duración
* Cámara lenta
* Boomerang
* Reversa
* Fotografías

Esto permitirá que distintas tomas dentro de una misma sesión tengan configuraciones diferentes.

---

# 5.10 Archivo Generado

Cada toma podrá generar múltiples archivos.

Ejemplos:

* Original
* Cámara lenta
* Boomerang
* Reversa
* Fotografías

### Información principal

* UUID
* Tipo
* Ruta local
* Ruta remota
* Tamaño
* Estado

---

# 5.11 Registro de Procesamiento

Cada archivo tendrá su propio seguimiento.

Estados posibles:

* Pendiente
* Procesando
* Procesado
* Pendiente de sincronización
* Sincronizado
* Error

Esto permitirá conocer exactamente en qué etapa se encuentra cada archivo.

---

# 5.12 Cola de Sincronización

Toda operación pendiente se almacenará en una cola.

Cada elemento registrará:

* UUID
* Tipo de operación
* Prioridad
* Fecha de creación
* Cantidad de intentos
* Último error
* Estado

El sistema deberá poder reanudar automáticamente cualquier sincronización interrumpida.

---

# 5.13 Página Pública del Evento

Cada evento tendrá una página pública.

Información:

* UUID
* Evento asociado
* Imagen de portada
* Nombre
* Fecha
* Código QR
* Contador de sesiones publicadas

La página se actualizará conforme las sesiones sean sincronizadas.

---

# 5.14 Historial

El historial conservará información resumida del evento.

Ejemplo:

* Total de sesiones.
* Total de tomas.
* Total de archivos.
* Espacio utilizado.
* Fecha de finalización.

---

# 5.15 Relaciones Conceptuales

Usuario

↓

Eventos

↓

Sesiones

↓

Tomas

↓

Archivos Generados

↓

Procesamiento

↓

Sincronización

↓

Galería Pública

Esta jerarquía deberá mantenerse durante todo el desarrollo del proyecto.

---

# 5.16 Identificadores

Todas las entidades utilizarán identificadores únicos (UUID).

El UUID será la referencia principal durante:

* Sincronización.
* Comunicación entre dispositivos.
* Base de datos.
* API.
* Procesamiento.

Nunca se utilizarán nombres o números telefónicos como identificadores internos.

---

# 5.17 Integridad de Datos

Las siguientes reglas deberán cumplirse siempre:

* Ninguna sesión puede existir sin un evento.
* Ninguna toma puede existir sin una sesión.
* Ningún archivo puede existir sin una toma.
* Eliminar un evento eliminará toda su estructura asociada, respetando la política de conservación configurada.
* Las operaciones de sincronización nunca deberán generar duplicados gracias al uso de UUID.

---

Fin del capítulo 5.

# PRODUCT REQUIREMENTS DOCUMENT (PRD)

# Capítulo 6 - Sistema de Diseño (Design System)

Versión: 1.0

---

# 6. Sistema de Diseño

## 6.1 Objetivo

Este capítulo define la identidad visual oficial de SpinSession.

Todo el desarrollo de la interfaz deberá respetar este sistema de diseño para garantizar una experiencia consistente, moderna y profesional.

El diseño estará orientado principalmente a dispositivos Android y optimizado para su uso durante eventos de larga duración.

---

# 6.2 Filosofía Visual

SpinSession deberá transmitir:

• Profesionalismo.

• Tecnología.

• Rapidez.

• Elegancia.

• Simplicidad.

La interfaz deberá sentirse como una aplicación premium de productividad y no como una aplicación recreativa.

Todas las pantallas deberán mantener un lenguaje visual uniforme.

---

# 6.3 Identidad de Marca

Nombre oficial:

SpinSession

Eslogan:

Captura. Procesa. Comparte.

La identidad visual representa el movimiento continuo de una plataforma 360 mediante formas circulares y una paleta moderna basada en tonos morados.

---

# 6.4 Principios de Diseño

Todo componente deberá respetar los siguientes principios.

## Claridad

La información deberá organizarse de forma jerárquica para facilitar su lectura durante un evento.

---

## Rapidez

Las acciones principales deberán encontrarse siempre al alcance del pulgar.

El operador nunca deberá navegar innecesariamente entre múltiples pantallas.

---

## Consistencia

Todos los módulos utilizarán los mismos patrones visuales.

Los componentes deberán reutilizarse en toda la aplicación.

---

## Contraste

La aplicación deberá mantenerse perfectamente legible tanto de día como de noche.

---

## Energía

El uso del color deberá transmitir dinamismo y reflejar el ambiente de los eventos.

---

# 6.5 Modos de Apariencia

SpinSession dispondrá de dos modos visuales.

## Modo Claro

Pensado principalmente para eventos diurnos.

Características:

• Fondo blanco cálido.

• Tarjetas claras.

• Sombras suaves.

• Excelente legibilidad.

• Morado como color protagonista.

---

## Modo Oscuro

Será el modo recomendado y el predeterminado de la aplicación.

No utilizará negro puro.

El fondo utilizará un azul muy oscuro con matiz violeta para reducir la fatiga visual durante eventos nocturnos.

Características:

• Fondo azul profundo.

• Tarjetas ligeramente más claras que el fondo.

• Alto contraste.

• Morado vibrante como color principal.

---

# 6.6 Paleta de Colores

La identidad de SpinSession estará basada principalmente en tonos morados.

Colores principales:

• Morado principal.

• Morado secundario.

• Rosa de acento.

• Blanco cálido.

• Azul oscuro con matiz violeta.

Los colores de estado serán:

Reservado → Morado.

Pagado → Azul.

Activo → Verde.

Pendiente → Amarillo.

Error → Rojo.

Estos colores deberán utilizarse únicamente para comunicar estados del sistema.

---

# 6.7 Tipografía

La tipografía oficial será:

Poppins.

Se utilizarán los siguientes pesos:

• SemiBold para títulos.

• Medium para botones.

• Regular para contenido.

No deberán utilizarse más de tres pesos tipográficos dentro de la aplicación.

---

# 6.8 Iconografía

Los iconos deberán mantener un estilo uniforme.

Características:

• Minimalistas.

• Bordes redondeados.

• Trazo fino.

• Fácil reconocimiento.

Nunca deberán mezclarse diferentes estilos de iconografía.

---

# 6.9 Componentes

Toda la interfaz estará construida utilizando componentes reutilizables.

Componentes principales:

• Botón primario.

• Botón secundario.

• Campo de texto.

• Tarjeta.

• Selector.

• Calendario.

• Etiquetas de estado.

• Tarjetas de eventos.

• Tarjetas de sesiones.

• Cuadros de diálogo.

• Bottom Sheets.

• Snackbar.

• Barra de navegación inferior.

Todos deberán compartir el mismo lenguaje visual.

---

# 6.10 Botones

Los botones deberán ser grandes para facilitar su utilización durante un evento.

El botón principal utilizará siempre el color morado institucional.

Las acciones secundarias utilizarán únicamente borde y fondo transparente.

Las acciones destructivas utilizarán color rojo.

---

# 6.11 Tarjetas

Las tarjetas serán el componente visual predominante dentro de la aplicación.

Se utilizarán para representar:

• Eventos.

• Sesiones.

• Configuraciones.

• Dispositivos.

• Plantillas.

Todas compartirán:

• Bordes redondeados.

• Espaciado uniforme.

• Elevación discreta.

• Diseño limpio.

---

# 6.12 Formularios

Todos los formularios deberán seguir la misma estructura visual.

Características:

• Campos amplios.

• Separación uniforme.

• Etiquetas visibles.

• Validación inmediata.

• Mensajes de error claros.

---

# 6.13 Navegación

La navegación utilizará una barra inferior fija.

Modo Operador:

• Calendario.

• Estudio.

• Registro.

• Configuración.

Modo Cámara:

Interfaz simplificada enfocada únicamente en la grabación.

Modo Operador + Cámara:

Utilizará la misma navegación del Operador, incorporando las funciones de cámara dentro del mismo dispositivo.

---

# 6.14 Animaciones

Las animaciones deberán transmitir fluidez sin afectar el rendimiento.

Duración recomendada:

Entre 150 y 250 milisegundos.

Las animaciones nunca deberán ralentizar el flujo de trabajo.

---

# 6.15 Adaptabilidad

La interfaz estará optimizada para teléfonos Android.

Deberá adaptarse correctamente a diferentes tamaños de pantalla manteniendo siempre la misma identidad visual.

---

# 6.16 Accesibilidad

La aplicación deberá facilitar su utilización durante largas jornadas de trabajo.

Se priorizará:

• Botones grandes.

• Alto contraste.

• Textos legibles.

• Espaciados amplios.

• Uso cómodo con una sola mano.

---

# 6.17 Imagen de Referencia

La primera propuesta gráfica aprobada por el proyecto será considerada la referencia oficial del sistema de diseño.

Todo nuevo componente deberá respetar ese estilo visual.

No podrán incorporarse elementos que rompan la identidad gráfica definida en este documento.

El objetivo es que toda la aplicación mantenga una apariencia uniforme, moderna y premium.

---

Fin del capítulo 6.

# PRODUCT REQUIREMENTS DOCUMENT (PRD)

# Capítulo 6.5 - Principios de Desarrollo

Versión: 1.0

---

# 6.5 Principios de Desarrollo

## 6.5.1 Objetivo

Este documento define las reglas fundamentales que deberán respetarse durante todo el desarrollo de SpinSession.

Estos principios tienen prioridad sobre cualquier decisión de implementación y servirán como guía para garantizar un sistema robusto, escalable y consistente.

---

# 6.5.2 Offline First

SpinSession deberá funcionar correctamente incluso sin conexión a Internet.

Toda la información se almacenará primero de forma local y posteriormente será sincronizada cuando exista conexión disponible.

La pérdida de Internet nunca deberá impedir el funcionamiento normal de la aplicación durante un evento.

---

# 6.5.3 Rendimiento

La aplicación deberá priorizar siempre la velocidad de respuesta.

Ninguna tarea pesada podrá bloquear la interfaz de usuario.

El procesamiento de videos, sincronización, generación de efectos y carga de archivos deberán ejecutarse siempre en segundo plano.

---

# 6.5.4 Recuperación ante Errores

Toda acción importante deberá poder recuperarse después de un cierre inesperado de la aplicación o un reinicio del dispositivo.

El sistema deberá continuar exactamente donde quedó antes de la interrupción.

---

# 6.5.5 Reutilización

Todo componente desarrollado deberá ser reutilizable.

No deberán duplicarse pantallas, formularios o lógica de negocio cuando puedan compartirse entre distintos módulos.

---

# 6.5.6 Escalabilidad

La arquitectura deberá permitir incorporar nuevas funcionalidades sin modificar el núcleo del sistema.

Toda nueva característica deberá integrarse mediante módulos independientes.

---

# 6.5.7 Consistencia

Toda la aplicación deberá mantener el mismo comportamiento visual y funcional.

Los mismos componentes deberán responder de igual manera en cualquier módulo.

---

# 6.5.8 Integridad de la Información

La información nunca deberá perderse.

Cada operación importante deberá quedar registrada antes de iniciar cualquier procesamiento o sincronización.

Toda entidad deberá identificarse mediante UUID para evitar duplicados.

---

# 6.5.9 Automatización Inteligente

SpinSession deberá automatizar todas las tareas repetitivas posibles sin quitar el control al operador.

Las acciones críticas siempre deberán requerir confirmación del usuario.

---

# 6.5.10 Simplicidad

La interfaz deberá reducir al mínimo la cantidad de pasos necesarios para completar una acción.

El operador deberá concentrarse en atender a los invitados y no en utilizar la aplicación.

---

# 6.5.11 Seguridad

Toda comunicación entre dispositivos y servidores deberá realizarse mediante conexiones seguras.

Las credenciales nunca deberán almacenarse en texto plano.

Los datos personales de los invitados deberán tratarse conforme a las buenas prácticas de seguridad.

---

# 6.5.12 Escalabilidad Tecnológica

Las tecnologías seleccionadas deberán permitir:

• Publicar la aplicación en Android.

• Adaptarla posteriormente a iOS.

• Incorporar una versión web administrativa.

• Integrar nuevos dispositivos y servicios sin reescribir el sistema.

---

# 6.5.13 Mantenibilidad

El código deberá ser limpio, documentado y modular.

Cada módulo deberá tener una única responsabilidad claramente definida.

---

# 6.5.14 Experiencia del Usuario

Durante un evento, el operador nunca deberá sentir que la aplicación ralentiza su trabajo.

Las acciones principales deberán completarse con la menor cantidad posible de interacciones.

---

# 6.5.15 Filosofía de SpinSession

SpinSession no es únicamente una aplicación para grabar videos.

Es una plataforma integral para la gestión de experiencias audiovisuales en eventos.

Cada decisión de desarrollo deberá contribuir a ofrecer una experiencia rápida, confiable, moderna y profesional tanto para el operador como para los invitados.

---

# 6.5.17 Arquitectura de Pagos

SpinSession deberá implementar una arquitectura desacoplada para el procesamiento de pagos.

La aplicación nunca dependerá directamente de un proveedor específico, sino de un módulo denominado PaymentService, encargado de administrar todas las operaciones relacionadas con pagos.

Durante el desarrollo del MVP no se integrará ningún proveedor real.

El sistema deberá permitir incorporar posteriormente servicios como:

• Transbank Webpay Plus.

• Mercado Pago.

• Stripe.

• Otros proveedores compatibles.

La integración de un nuevo proveedor no deberá requerir modificaciones en el resto de la aplicación.

El objetivo es garantizar la flexibilidad del sistema y permitir la adaptación a diferentes mercados y necesidades comerciales sin alterar la arquitectura principal.

---

Fin del capítulo 6.5.
# PRODUCT REQUIREMENTS DOCUMENT (PRD)

# Capítulo 7 - Arquitectura Técnica

Versión: 1.0

---

# 7. Arquitectura Técnica

## 7.1 Objetivo

Este capítulo define la arquitectura tecnológica oficial de SpinSession.

Su propósito es establecer la estructura interna del sistema, las tecnologías utilizadas y la forma en que interactúan todos los componentes de la aplicación.

La arquitectura deberá priorizar el rendimiento, la escalabilidad, la mantenibilidad y el funcionamiento Offline First.

---

# 7.2 Arquitectura General

SpinSession estará compuesta por cinco capas principales.

Aplicación Flutter

↓

Lógica de Negocio

↓

Persistencia Local

↓

Sincronización

↓

Servicios en la Nube

Cada capa deberá cumplir una única responsabilidad y comunicarse únicamente con la capa inmediatamente inferior.

---

# 7.3 Tecnologías Oficiales

Las tecnologías aprobadas para el desarrollo son las siguientes.

Frontend:

• Flutter.

Lenguaje:

• Dart.

Gestión de estado:

• Riverpod.

Base de datos local:

• Drift (SQLite).

Backend:

• Supabase.

Base de datos remota:

• PostgreSQL (Supabase).

Almacenamiento multimedia:

• Supabase Storage.

Procesamiento multimedia:

• FFmpeg.

Control de versiones:

• Git.

Repositorio:

• GitHub.

---

# 7.4 Arquitectura de Software

La aplicación seguirá el patrón **Clean Architecture**.

Cada módulo estará dividido en las siguientes capas.

Presentation

↓

Application

↓

Domain

↓

Infrastructure

↓

Data

Esta estructura permitirá mantener el código organizado y facilitar futuras ampliaciones.

---

# 7.5 Organización del Proyecto

La estructura general del proyecto deberá seguir una organización modular.

Ejemplo:

lib/

core/

features/

authentication/

calendar/

events/

recording/

sessions/

gallery/

devices/

payments/

settings/

shared/

Cada módulo deberá ser independiente del resto.

---

# 7.6 Gestión del Estado

Toda la aplicación utilizará Riverpod.

No se permitirá compartir estados mediante variables globales.

Cada módulo administrará únicamente su propio estado.

La comunicación entre módulos deberá realizarse mediante servicios claramente definidos.

---

# 7.7 Persistencia Local

Toda la información importante se almacenará primero en Drift.

Entre ella:

• Eventos.

• Sesiones.

• Tomas.

• Archivos.

• Cola de sincronización.

• Configuración.

La información nunca dependerá exclusivamente de Internet.

---

# 7.8 Base de Datos Remota

Supabase almacenará la información sincronizada.

Contendrá:

• Usuarios.

• Eventos.

• Sesiones.

• Galerías.

• Estados.

• Configuraciones.

• Registros históricos.

La base de datos local y la remota deberán mantenerse sincronizadas.

---

# 7.9 Almacenamiento Multimedia

Todos los archivos multimedia se almacenarán en Supabase Storage.

Se almacenarán:

• Videos.

• Fotografías.

• Miniaturas.

La aplicación conservará también una copia local hasta que finalice el período de conservación definido para cada evento.

---

# 7.10 Procesamiento Multimedia

Todo el procesamiento se realizará directamente en el dispositivo.

El sistema utilizará FFmpeg para generar automáticamente:

• Video original.

• Cámara lenta.

• Reversa.

• Boomerang.

• Fotografías.

El servidor nunca procesará archivos multimedia.

---

# 7.11 Sincronización

La sincronización seguirá el principio Offline First.

Toda acción deberá registrarse primero localmente.

Posteriormente se sincronizará automáticamente con Supabase.

Si la sincronización falla, la operación permanecerá pendiente hasta el siguiente intento.

Nunca deberá perderse información.

---

# 7.12 Comunicación entre Dispositivos

Cuando existan múltiples dispositivos conectados a la misma cuenta, el sistema permitirá asignar uno o varios roles.

Roles disponibles:

• Operador.

• Cámara.

• Operador + Cámara.

La comunicación deberá realizarse mediante Supabase Realtime.

Los dispositivos compartirán únicamente la información necesaria para coordinar las grabaciones.

---

# 7.13 Seguridad

Todas las comunicaciones utilizarán HTTPS.

La autenticación será administrada mediante Supabase Authentication.

Las credenciales nunca deberán almacenarse en texto plano.

Cada usuario únicamente podrá acceder a sus propios eventos.

---

# 7.14 Gestión de Archivos

Cada archivo generado dispondrá de:

• UUID.

• Ruta local.

• Ruta remota.

• Estado.

• Fecha de creación.

• Tamaño.

• Evento asociado.

Esto permitirá controlar fácilmente la sincronización y la eliminación automática.

---

# 7.15 Cola de Procesamiento

El procesamiento multimedia utilizará una cola interna.

Cada tarea registrará:

• Prioridad.

• Estado.

• Fecha.

• Cantidad de intentos.

• Error (si existe).

La cola continuará automáticamente después de reiniciar la aplicación.

---

# 7.16 Cola de Sincronización

Toda operación pendiente de sincronización se almacenará en una cola independiente.

La sincronización nunca bloqueará la interfaz.

El sistema intentará reenviar automáticamente todas las operaciones pendientes cuando exista conexión.

---

# 7.17 Escalabilidad

La arquitectura deberá permitir incorporar nuevos módulos sin modificar los existentes.

Ejemplos:

• Inteligencia Artificial.

• Estadísticas.

• Panel Web.

• Integración con cámaras profesionales.

• Nuevos efectos multimedia.

---

# 7.18 Compatibilidad

El desarrollo estará orientado principalmente a Android.

La arquitectura deberá facilitar una futura publicación para iOS sin modificar la lógica del negocio.

---

# 7.19 Rendimiento

La aplicación deberá priorizar:

• Inicio rápido.

• Consumo reducido de memoria.

• Bajo consumo de batería.

• Procesamiento paralelo.

• Interfaz siempre fluida.

Las tareas pesadas nunca deberán ejecutarse en el hilo principal de la aplicación.

---

# 7.20 Registro de Errores

Todo error importante deberá registrarse.

Se almacenará:

• Fecha.

• Módulo.

• Acción realizada.

• Descripción.

• Dispositivo.

• Estado.

Estos registros facilitarán el diagnóstico de problemas y futuras mejoras.

---

# 7.21 Arquitectura Oficial

La arquitectura descrita en este documento será la base oficial del desarrollo de SpinSession.

Toda nueva funcionalidad deberá respetar esta estructura para garantizar la consistencia, el rendimiento y la escalabilidad del sistema.

---

Fin del capítulo 7.

# PRODUCT REQUIREMENTS DOCUMENT (PRD)

# Capítulo 8 - Modelo de Base de Datos

Versión: 1.0

---

# 8. Modelo de Base de Datos

## 8.1 Objetivo

Este capítulo define la estructura lógica de la base de datos de SpinSession.

La información deberá mantenerse sincronizada entre la base de datos local (Drift) y la base de datos remota (Supabase PostgreSQL), garantizando el funcionamiento Offline First.

Todas las entidades utilizarán identificadores UUID.

---

# 8.2 Arquitectura de Persistencia

La aplicación utilizará dos niveles de almacenamiento.

Nivel Local

• Drift (SQLite)

↓

Nivel Remoto

• Supabase PostgreSQL

Toda modificación se registrará primero en la base de datos local y posteriormente será sincronizada con Supabase.

---

# 8.3 Tabla Usuarios

Representa al propietario de la cuenta.

Campos principales:

• id (UUID)

• nombre

• correo

• fecha_creacion

• estado

• preferencias

Cada usuario únicamente podrá acceder a su propia información.

---

# 8.4 Tabla Dispositivos

Registra cada dispositivo autenticado.

Campos:

• id

• usuario_id

• nombre

• modelo

• sistema_operativo

• version_app

• modo

• ultimo_acceso

• estado

Un usuario podrá registrar múltiples dispositivos.

---

# 8.5 Tabla Plantillas

Permite reutilizar configuraciones.

Campos:

• id

• usuario_id

• nombre

• duracion

• efectos

• cantidad_maxima_tomas

• generar_fotografias

• politica_conservacion

---

# 8.6 Tabla Eventos

Entidad principal del sistema.

Campos:

• id

• usuario_id

• plantilla_id (opcional)

• nombre

• fecha

• hora_inicio

• hora_fin

• fecha_limite_pago

• fecha_pago

• estado

• qr_publico

• portada

• politica_eliminacion

• fecha_creacion

---

# 8.7 Tabla Sesiones

Representa a un invitado o grupo.

Campos:

• id

• evento_id

• nombre

• telefono

• estado

• cantidad_tomas

• fecha

• hora

• observaciones (opcional)

---

# 8.8 Tabla Tomas

Cada grabación realizada.

Campos:

• id

• sesion_id

• dispositivo_id

• numero

• duracion

• configuracion

• fecha

• hora

---

# 8.9 Tabla Archivos

Cada archivo generado por FFmpeg.

Campos:

• id

• toma_id

• tipo

• ruta_local

• ruta_remota

• miniatura

• tamaño

• estado

• fecha_creacion

Tipos posibles:

• Original

• Cámara lenta

• Reversa

• Boomerang

• Fotografía

---

# 8.10 Tabla Cola de Procesamiento

Registra todas las tareas pendientes.

Campos:

• id

• archivo_id

• prioridad

• estado

• intentos

• ultimo_error

• fecha_creacion

---

# 8.11 Tabla Cola de Sincronización

Administra las operaciones pendientes.

Campos:

• id

• entidad

• entidad_id

• accion

• estado

• intentos

• ultimo_error

• fecha

---

# 8.12 Tabla Historial

Resumen estadístico por evento.

Campos:

• id

• evento_id

• sesiones

• tomas

• archivos

• almacenamiento

• fecha_cierre

---

# 8.13 Relaciones

Usuario

↓

Dispositivos

↓

Eventos

↓

Sesiones

↓

Tomas

↓

Archivos

↓

Procesamiento

↓

Sincronización

Cada entidad dependerá únicamente de la inmediatamente superior.

---

# 8.14 Integridad Referencial

Las siguientes reglas deberán cumplirse siempre:

• Ningún evento podrá existir sin un usuario.

• Ninguna sesión podrá existir sin un evento.

• Ninguna toma podrá existir sin una sesión.

• Ningún archivo podrá existir sin una toma.

• Eliminar un evento eliminará toda su estructura asociada conforme a la política de conservación.

---

# 8.15 Índices

Se crearán índices para optimizar las consultas frecuentes.

Índices principales:

• usuario_id

• evento_id

• sesion_id

• dispositivo_id

• estado

• fecha

• telefono

Estos índices deberán utilizarse tanto en la base de datos local como en la remota cuando sea posible.

---

# 8.16 Sincronización

Cada registro incluirá metadatos de sincronización.

Ejemplo:

• sincronizado

• fecha_sincronizacion

• version

• actualizado_en

Esto permitirá resolver conflictos entre múltiples dispositivos.

---

# 8.17 Eliminación Automática

La eliminación nunca será inmediata.

Cuando finalice el período de conservación:

• Se eliminarán primero los archivos multimedia.

• Posteriormente los registros asociados.

• Finalmente el evento.

El sistema deberá confirmar que el operador haya tenido la posibilidad de descargar el contenido antes de eliminarlo definitivamente.

---

# 8.18 Seguridad

La base de datos remota utilizará las políticas de seguridad de Supabase (Row Level Security).

Cada usuario únicamente podrá consultar y modificar los registros que le pertenezcan.

No será posible acceder a información de otros operadores.

---

# 8.19 Versionado

Todas las entidades incluirán un campo de versión.

Cada modificación incrementará automáticamente este valor.

El sistema utilizará esta información para resolver conflictos durante la sincronización entre dispositivos.

---

# 8.20 Escalabilidad

El modelo de datos deberá permitir incorporar nuevas entidades sin modificar la estructura existente.

Ejemplos:

• Estadísticas.

• Inteligencia Artificial.

• Facturación.

• Panel Web.

• Integraciones externas.

La base de datos deberá permanecer preparada para el crecimiento futuro de SpinSession.

---

Fin del capítulo 8.

# PRODUCT REQUIREMENTS DOCUMENT (PRD)

# Capítulo 9 - API y Comunicación con Supabase

Versión: 1.0

---

# 9. API y Comunicación con Supabase

## 9.1 Objetivo

Este capítulo define la comunicación entre la aplicación móvil y Supabase.

Toda operación remota deberá realizarse mediante servicios claramente definidos, manteniendo una arquitectura desacoplada y compatible con el principio Offline First.

La aplicación nunca dependerá directamente de la estructura interna de la base de datos.

---

# 9.2 Arquitectura de Comunicación

La comunicación seguirá la siguiente estructura.

Flutter

↓

Repository

↓

Service

↓

Supabase

↓

PostgreSQL / Storage / Authentication / Realtime

Cada capa tendrá una única responsabilidad.

---

# 9.3 Servicios Oficiales

La aplicación estará dividida en los siguientes servicios.

• AuthenticationService

• UserService

• DeviceService

• EventService

• TemplateService

• SessionService

• RecordingService

• GalleryService

• StorageService

• SyncService

• PaymentService

• SettingsService

Cada servicio será independiente y reutilizable.

---

# 9.4 AuthenticationService

Será responsable de toda la autenticación.

Funciones principales:

• Iniciar sesión.

• Cerrar sesión.

• Registrar usuario.

• Recuperar contraseña.

• Renovar sesión.

• Obtener usuario autenticado.

La autenticación será administrada mediante Supabase Authentication.

---

# 9.5 UserService

Administrará la información del usuario.

Funciones:

• Obtener perfil.

• Actualizar información.

• Obtener preferencias.

• Actualizar preferencias.

---

# 9.6 DeviceService

Administrará todos los dispositivos registrados.

Funciones:

• Registrar dispositivo.

• Obtener dispositivos.

• Cambiar modo.

• Desvincular dispositivo.

• Consultar estado.

• Sincronizar dispositivos.

Permitirá seleccionar el dispositivo que actuará como cámara.

---

# 9.7 EventService

Administrará toda la información de los eventos.

Funciones:

• Crear evento.

• Editar evento.

• Eliminar evento.

• Obtener evento.

• Obtener calendario.

• Registrar pago.

• Activar evento.

• Finalizar evento.

• Generar QR público.

• Descargar información.

---

# 9.8 TemplateService

Administrará las plantillas.

Funciones:

• Crear plantilla.

• Editar plantilla.

• Eliminar plantilla.

• Duplicar plantilla.

• Obtener plantillas.

• Aplicar plantilla al evento.

---

# 9.9 SessionService

Administrará las sesiones.

Funciones:

• Crear sesión.

• Editar sesión.

• Obtener sesión.

• Obtener sesiones del evento.

• Eliminar sesión.

• Actualizar estado.

• Descargar sesión.

---

# 9.10 RecordingService

Será responsable del proceso de grabación.

Funciones:

• Iniciar grabación.

• Finalizar grabación.

• Confirmar grabación.

• Repetir toma.

• Agregar nueva toma.

• Obtener estado.

• Cancelar grabación.

---

# 9.11 ProcessingService

Administrará el procesamiento multimedia.

Funciones:

• Generar cámara lenta.

• Generar reversa.

• Generar boomerang.

• Extraer fotografías.

• Crear miniaturas.

• Actualizar progreso.

Todo el procesamiento se realizará localmente mediante FFmpeg.

---

# 9.12 StorageService

Administrará Supabase Storage.

Funciones:

• Subir archivos.

• Descargar archivos.

• Eliminar archivos.

• Obtener URL pública.

• Verificar integridad.

Las cargas deberán reanudarse automáticamente cuando exista conexión.

---

# 9.13 GalleryService

Administrará la galería pública.

Funciones:

• Obtener galería.

• Publicar sesión.

• Actualizar miniaturas.

• Obtener código QR.

• Obtener estadísticas.

La galería únicamente mostrará sesiones completamente sincronizadas.

---

# 9.14 SyncService

Administrará la sincronización.

Funciones:

• Detectar conexión.

• Enviar pendientes.

• Descargar cambios.

• Resolver conflictos.

• Reintentar errores.

• Actualizar estados.

Será el servicio responsable del funcionamiento Offline First.

---

# 9.15 PaymentService

Administrará los pagos.

Durante el MVP no existirá una integración real.

El servicio únicamente definirá la estructura necesaria para futuras implementaciones.

La arquitectura permitirá incorporar:

• Transbank Webpay Plus.

• Mercado Pago.

• Stripe.

• Otros proveedores.

Sin modificar el resto de la aplicación.

---

# 9.16 SettingsService

Administrará toda la configuración.

Funciones:

• Tema.

• Idioma.

• Conservación de archivos.

• Calidad de video.

• Configuración general.

---

# 9.17 Supabase Realtime

El sistema utilizará Supabase Realtime para sincronizar información entre dispositivos.

Ejemplos:

• Inicio de grabación.

• Fin de grabación.

• Cambio de estado.

• Nuevas sesiones.

• Eventos activos.

La sincronización deberá producirse prácticamente en tiempo real.

---

# 9.18 Comunicación con Storage

Todo archivo seguirá el siguiente flujo.

Generación local

↓

Procesamiento

↓

Verificación

↓

Subida

↓

Confirmación

↓

Actualización de estado

↓

Publicación en galería

El sistema nunca publicará archivos incompletos.

---

# 9.19 Comunicación entre Dispositivos

Cuando existan varios dispositivos conectados.

Operador

↓

Envía orden

↓

Supabase Realtime

↓

Cámara

↓

Grabación

↓

Procesamiento

↓

Sincronización

↓

Actualización del operador

Toda la comunicación deberá ser inmediata y tolerante a pérdidas temporales de conexión.

---

# 9.20 Manejo de Errores

Cada servicio deberá devolver respuestas estandarizadas.

Toda respuesta contendrá:

• Estado.

• Código.

• Mensaje.

• Datos.

• Fecha.

• Identificador de la operación.

Esto facilitará el diagnóstico de errores y la recuperación automática.

---

# 9.21 Registro de Actividad

Todas las operaciones importantes quedarán registradas.

Ejemplos:

• Inicio de sesión.

• Creación de eventos.

• Grabaciones.

• Sincronizaciones.

• Eliminaciones.

• Cambios de configuración.

Estos registros facilitarán auditorías y futuras mejoras.

---

# 9.22 Escalabilidad

La estructura de servicios deberá permitir incorporar nuevos módulos sin modificar los existentes.

Ejemplos:

• Inteligencia Artificial.

• Facturación electrónica.

• Dashboard Web.

• Integraciones con redes sociales.

• Nuevos proveedores de pago.

---

# 9.23 Arquitectura Oficial de Comunicación

Toda comunicación entre la aplicación y Supabase deberá respetar la arquitectura definida en este documento.

Ningún módulo podrá acceder directamente a la base de datos o al almacenamiento sin utilizar el servicio correspondiente.

Esto garantizará un código organizado, seguro y fácilmente mantenible.

---

Fin del capítulo 9.

# PRODUCT REQUIREMENTS DOCUMENT (PRD)

# Capítulo 10 - Motor de Procesamiento Multimedia

Versión: 1.0

---

# 10. Motor de Procesamiento Multimedia

## 10.1 Objetivo

Este capítulo define el funcionamiento del motor multimedia de SpinSession.

Su responsabilidad será transformar una grabación original en uno o varios archivos finales utilizando procesamiento local mediante FFmpeg, garantizando rapidez, calidad y funcionamiento Offline First.

Todo el procesamiento deberá realizarse directamente en el dispositivo.

---

# 10.2 Flujo General

El flujo oficial de procesamiento será el siguiente.

Grabación

↓

Confirmación del operador

↓

Ingreso a la cola de procesamiento

↓

Generación de efectos

↓

Verificación de archivos

↓

Registro local

↓

Sincronización

↓

Publicación en galería

↓

Envío por WhatsApp

Cada etapa deberá completarse correctamente antes de iniciar la siguiente.

---

# 10.3 Grabación Original

Toda sesión comenzará con una grabación original.

Características:

• Resolución estándar: 1080p.

• Velocidad: 60 FPS.

• Formato: MP4.

• Códec: H.264.

• Audio: AAC.

El archivo original siempre deberá conservarse hasta finalizar el período de conservación del evento.

---

# 10.4 Procesamiento Local

El procesamiento multimedia se realizará exclusivamente en el dispositivo.

El servidor nunca generará efectos ni editará videos.

Esto permitirá:

• Funcionar sin Internet.

• Reducir costos del servidor.

• Disminuir tiempos de espera.

• Aprovechar el hardware del teléfono.

---

# 10.5 Estilos Multimedia

SpinSession utilizará estilos predefinidos.

Cada estilo representará una configuración completa de procesamiento.

Ejemplos:

• Classic Slow.

• Party.

• Epic.

• Romantic.

• Reverse.

• Boomerang.

El operador únicamente seleccionará el estilo deseado.

---

# 10.6 Cámara Lenta Cinematográfica

La cámara lenta no deberá aplicarse durante toda la duración del video.

El sistema utilizará rampas de velocidad (Speed Ramping).

Ejemplo:

Velocidad normal

↓

Reducción progresiva

↓

Cámara lenta

↓

Aceleración progresiva

↓

Velocidad normal

El objetivo es generar una sensación cinematográfica similar a las plataformas 360 profesionales.

---

# 10.7 Múltiples Archivos

Una única toma podrá generar múltiples resultados.

Ejemplo:

• Video original.

• Cámara lenta.

• Reverse.

• Boomerang.

• Fotografías.

Cada archivo será independiente y tendrá su propio estado de procesamiento.

---

# 10.8 Fotografías

El sistema podrá extraer automáticamente fotografías desde la grabación.

Las imágenes se almacenarán en formato JPG.

Su cantidad dependerá de la configuración seleccionada para la sesión.

---

# 10.9 Miniaturas

Cada video generado tendrá una miniatura.

Las miniaturas serán utilizadas en:

• Registro.

• Galería pública.

• Vista previa.

Las miniaturas deberán generarse automáticamente durante el procesamiento.

---

# 10.10 Cola de Procesamiento

Todo procesamiento ingresará a una cola.

Cada tarea registrará:

• Archivo.

• Prioridad.

• Estado.

• Fecha.

• Cantidad de intentos.

La cola continuará automáticamente después de reiniciar la aplicación.

---

# 10.11 Procesamiento Paralelo

Cuando el dispositivo lo permita, varias tareas podrán ejecutarse simultáneamente.

La aplicación deberá limitar automáticamente la cantidad de procesos para evitar sobrecargar el teléfono.

---

# 10.12 Confirmación del Operador

Finalizada la grabación, el operador visualizará una vista previa.

Dispondrá de tres opciones.

• Confirmar.

• Repetir.

• Agregar otra toma.

Ningún archivo ingresará a la cola de procesamiento hasta ser confirmado.

---

# 10.13 SpinLab

SpinLab será el laboratorio oficial de SpinSession.

Su objetivo será permitir pruebas sin afectar eventos reales.

Características:

• No requiere evento.

• No registra sesiones.

• No solicita nombre ni teléfono.

• No sincroniza información.

• No publica contenido.

• No envía WhatsApp.

• No aparece en el historial.

Todos los archivos generados dentro de SpinLab serán temporales.

---

# 10.14 Comparación de Estilos

Dentro de SpinLab será posible procesar una misma grabación utilizando diferentes estilos predefinidos.

El usuario podrá reproducir cada resultado las veces que desee para comparar su apariencia.

No será necesario volver a grabar para probar otro estilo.

---

# 10.15 Eliminación Automática

Al salir de SpinLab, todos los archivos temporales serán eliminados automáticamente.

No quedará ningún registro en la base de datos local ni remota.

---

# 10.16 Calidad de Exportación

Todos los videos finales deberán mantener una calidad suficiente para su reproducción en dispositivos móviles y redes sociales.

El sistema priorizará mantener un equilibrio entre calidad visual, tamaño del archivo y velocidad de procesamiento.

---

# 10.17 Recuperación

Si el procesamiento se interrumpe por cierre inesperado o reinicio del dispositivo, la cola continuará automáticamente cuando la aplicación vuelva a iniciarse.

Ningún archivo confirmado deberá perderse.

---

# 10.18 Optimización

El motor multimedia deberá optimizar automáticamente el uso de CPU, memoria y almacenamiento.

Las tareas pesadas nunca deberán bloquear la interfaz de usuario.

---

# 10.19 Compatibilidad

El procesamiento deberá funcionar en la mayoría de dispositivos Android compatibles con Flutter.

La arquitectura deberá permitir adaptar el motor a iOS en futuras versiones sin modificar la lógica de procesamiento.

---

# 10.20 Escalabilidad

El motor multimedia deberá permitir incorporar nuevos estilos y efectos predefinidos sin modificar la arquitectura principal.

Las futuras ampliaciones deberán integrarse mediante nuevos módulos de procesamiento.

---

# 10.21 Motor Oficial

El motor multimedia definido en este documento será el responsable exclusivo del procesamiento audiovisual de SpinSession.

Toda funcionalidad relacionada con la generación de videos, fotografías y efectos deberá respetar la arquitectura descrita en este capítulo.

---

Fin del capítulo 10.

# PRODUCT REQUIREMENTS DOCUMENT (PRD)

# Capítulo 11 - Sincronización y Arquitectura Offline First

Versión: 1.0

---

# 11. Sincronización y Arquitectura Offline First

## 11.1 Objetivo

Este capítulo define el funcionamiento de la sincronización entre la base de datos local y Supabase.

SpinSession deberá garantizar la continuidad del servicio incluso cuando el dispositivo no disponga de conexión a Internet.

La pérdida de conectividad nunca deberá impedir la grabación, el procesamiento o el almacenamiento de las sesiones.

---

# 11.2 Principio Offline First

Toda operación realizada por el operador seguirá el siguiente principio.

Usuario

↓

Registro local

↓

Confirmación inmediata

↓

Procesamiento

↓

Sincronización automática

La aplicación nunca dependerá de Internet para continuar operando.

---

# 11.3 Base de Datos Local

Toda la información se almacenará primero en Drift (SQLite).

Entre ella:

• Eventos.

• Plantillas.

• Sesiones.

• Tomas.

• Archivos.

• Configuración.

• Estados.

• Cola de procesamiento.

• Cola de sincronización.

---

# 11.4 Detección de Conectividad

La aplicación deberá supervisar permanentemente el estado de la conexión.

Estados posibles:

• Conectado.

• Conectividad limitada.

• Sin conexión.

Los cambios deberán detectarse automáticamente sin intervención del operador.

---

# 11.5 Flujo con Internet

Cuando exista conexión.

Confirmar sesión

↓

Procesar archivos

↓

Subir multimedia

↓

Crear sesión privada

↓

Publicar en galería pública

↓

Enviar enlace privado por WhatsApp

↓

Actualizar estado

Todo el proceso deberá ejecutarse automáticamente.

---

# 11.6 Flujo sin Internet

Cuando no exista conexión.

Confirmar sesión

↓

Procesar archivos

↓

Guardar archivos localmente

↓

Registrar como "Pendiente"

↓

Continuar trabajando

El operador podrá seguir atendiendo invitados sin interrupciones.

---

# 11.7 Cola de Sincronización

Toda operación pendiente ingresará a una cola.

Cada elemento almacenará:

• Tipo de operación.

• Identificador.

• Prioridad.

• Fecha.

• Cantidad de intentos.

• Estado.

La cola sobrevivirá incluso si la aplicación se cierra inesperadamente.

---

# 11.8 Reanudación Automática

Cuando vuelva la conexión.

La aplicación retomará automáticamente las operaciones pendientes respetando el orden de creación.

No será necesaria ninguna intervención del operador.

---

# 11.9 Panel de Sincronización

El operador dispondrá de un panel dedicado para supervisar la sincronización.

Permitirá visualizar:

• Sesiones procesándose.

• Sesiones pendientes.

• Sesiones sincronizadas.

• Errores.

También mostrará el progreso general del evento.

---

# 11.10 Estados Oficiales

Cada sesión podrá encontrarse en uno de los siguientes estados.

• Grabando.

• Pendiente de confirmación.

• Procesando.

• Pendiente de sincronización.

• Publicada.

• Enviada.

• Error.

Estos estados deberán actualizarse automáticamente.

---

# 11.11 Recuperación ante Fallos

Si la aplicación se cierra inesperadamente.

Al volver a iniciarse deberá recuperar automáticamente:

• Cola de procesamiento.

• Cola de sincronización.

• Sesiones pendientes.

• Archivos temporales.

El operador podrá continuar trabajando sin pérdida de información.

---

# 11.12 Gestión de Conflictos

Cuando dos dispositivos modifiquen el mismo registro.

El sistema utilizará:

• Número de versión.

• Fecha de modificación.

• Dispositivo responsable.

En caso de conflicto prevalecerá la modificación más reciente, registrando el cambio para auditoría.

---

# 11.13 Sincronización entre Dispositivos

Cuando varios dispositivos participen en un mismo evento.

Toda actualización importante deberá sincronizarse mediante Supabase Realtime.

Ejemplos:

• Inicio de grabación.

• Fin de grabación.

• Confirmación.

• Cambio de estado.

• Evento activo.

---

# 11.14 Disponibilidad del Evento

El evento permanecerá completamente funcional aunque la conexión se pierda después de haber comenzado.

La pérdida de Internet nunca bloqueará las funciones principales de SpinSession.

---

# 11.15 Integridad de Archivos

Antes de eliminar una copia local.

El sistema deberá verificar que:

• El archivo fue subido correctamente.

• La sesión privada fue creada.

• La galería pública fue actualizada.

• El enlace de WhatsApp fue generado.

Solo entonces el archivo podrá considerarse completamente sincronizado.

---

# 11.16 Reintentos

Toda operación fallida deberá reintentarse automáticamente.

El sistema utilizará tiempos de espera progresivos para evitar saturar la conexión.

Las operaciones permanecerán pendientes hasta completarse correctamente o hasta que el operador intervenga.

---

# 11.17 Modo de Emergencia

Si un evento permanece sin conexión durante toda su duración.

SpinSession continuará funcionando normalmente.

Al recuperar Internet.

Todas las sesiones pendientes serán sincronizadas automáticamente respetando el orden cronológico.

---

# 11.18 Indicadores Visuales

La aplicación mostrará siempre el estado de sincronización mediante indicadores claros.

Ejemplos:

🟢 Sincronizado.

🟡 Procesando.

🟠 Pendiente.

🔴 Error.

Estos indicadores estarán disponibles tanto en la lista de sesiones como en el detalle de cada una.

---

# 11.19 Registro de Sincronización

Cada operación registrará:

• Fecha.

• Hora.

• Dispositivo.

• Resultado.

• Duración.

• Error (si existe).

Estos datos facilitarán el diagnóstico de problemas y futuras mejoras.

---

# 11.20 Arquitectura Oficial

La sincronización definida en este capítulo constituye uno de los pilares fundamentales de SpinSession.

El sistema deberá garantizar que ninguna sesión confirmada se pierda, independientemente del estado de la conexión, reinicios inesperados o cierres de la aplicación.

La continuidad operativa será prioritaria durante cualquier evento.

---

Fin del capítulo 11.

# PRODUCT REQUIREMENTS DOCUMENT (PRD)

# Capítulo 12 - Seguridad y Protección de Datos

Versión: 1.0

---

# 12. Seguridad y Protección de Datos

## 12.1 Objetivo

Este capítulo define las políticas de seguridad que deberán implementarse en SpinSession.

El sistema deberá proteger la información de los operadores, los invitados y los archivos multimedia, garantizando la privacidad de los datos y la integridad del sistema.

---

# 12.2 Autenticación

Toda cuenta será administrada mediante Supabase Authentication.

Funciones disponibles:

• Registro.

• Inicio de sesión.

• Recuperación de contraseña.

• Cierre de sesión.

• Renovación automática de sesión.

El acceso a la aplicación requerirá autenticación obligatoria.

---

# 12.3 Control de Acceso

Cada operador únicamente podrá acceder a:

• Sus eventos.

• Sus plantillas.

• Sus sesiones.

• Sus archivos.

• Sus configuraciones.

No será posible visualizar información perteneciente a otras cuentas.

---

# 12.4 Roles de Dispositivo

Cada dispositivo autenticado podrá adoptar uno de los siguientes modos.

• Operador.

• Cámara.

• Operador + Cámara.

Los permisos disponibles dependerán del rol seleccionado.

---

# 12.5 Comunicación Segura

Toda comunicación entre la aplicación y Supabase deberá realizarse mediante HTTPS.

No se permitirá el envío de información mediante conexiones inseguras.

---

# 12.6 Protección de la Base de Datos

Supabase utilizará Row Level Security (RLS).

Cada consulta será filtrada automáticamente según el usuario autenticado.

Ninguna consulta podrá acceder a registros pertenecientes a otros operadores.

---

# 12.7 Protección del Almacenamiento

Todos los archivos almacenados en Supabase Storage deberán respetar las mismas políticas de acceso que la base de datos.

Los archivos privados únicamente podrán ser consultados por su propietario o mediante enlaces temporales autorizados.

---

# 12.8 Galería Pública

La galería pública del evento será accesible mediante un código QR.

Características:

• Acceso sin iniciar sesión.

• Solo visualización.

• Sin descarga directa.

• Sin información personal de los invitados.

Únicamente se mostrará el nombre registrado de la sesión y su contenido multimedia.

---

# 12.9 Sesión Privada

Cada sesión generará un enlace privado único.

Características:

• Token aleatorio.

• Difícil de predecir.

• Acceso directo.

• Descarga habilitada.

• Reproducción integrada.

Cada enlace permitirá acceder exclusivamente a los archivos de esa sesión.

---

# 12.10 Expiración de Enlaces

Los enlaces privados dejarán de funcionar cuando:

• El operador elimine la sesión.

• El evento sea eliminado.

• Finalice el período de conservación configurado.

No será posible acceder posteriormente al contenido.

---

# 12.11 Protección de Credenciales

Las credenciales nunca serán almacenadas en texto plano.

La aplicación utilizará el almacenamiento seguro proporcionado por el sistema operativo.

---

# 12.12 Protección Local

Los datos almacenados en Drift deberán protegerse frente a pérdidas accidentales.

La aplicación nunca eliminará información confirmada sin verificar previamente su sincronización.

---

# 12.13 Integridad de Archivos

Todo archivo subido será verificado antes de marcarse como sincronizado.

La aplicación comprobará:

• Existencia.

• Tamaño.

• Finalización de la carga.

Solo entonces actualizará su estado.

---

# 12.14 Protección ante Errores

Ante cualquier error crítico.

La aplicación deberá:

• Registrar el incidente.

• Informar al operador.

• Mantener la información local.

• Permitir reintentos.

La prioridad será preservar los datos.

---

# 12.15 Registro de Actividad

Se registrarán las siguientes acciones:

• Inicio de sesión.

• Cierre de sesión.

• Registro de dispositivos.

• Creación y eliminación de eventos.

• Cambios importantes de configuración.

Estos registros estarán disponibles únicamente para fines de diagnóstico.

---

# 12.16 Eliminación Segura

Cuando un evento sea eliminado.

El sistema verificará:

• Eliminación de archivos.

• Eliminación de sesiones.

• Eliminación de registros asociados.

La eliminación deberá ser definitiva.

---

# 12.17 Protección de la Privacidad

SpinSession almacenará únicamente la información necesaria para prestar el servicio.

Datos utilizados:

• Nombre de la sesión.

• Número telefónico.

• Archivos multimedia.

No se recopilará información adicional sin autorización del operador.

---

# 12.18 Arquitectura Segura

Toda nueva funcionalidad desarrollada deberá respetar las políticas de seguridad definidas en este documento.

La seguridad formará parte de la arquitectura desde el inicio y no como una característica añadida posteriormente.

---

Fin del capítulo 12.

# PRODUCT REQUIREMENTS DOCUMENT (PRD)

# Capítulo 13 - Rendimiento y Optimización

Versión: 1.0

---

# 13. Rendimiento y Optimización

## 13.1 Objetivo

Este capítulo define los criterios de rendimiento que deberá cumplir SpinSession.

La aplicación deberá ofrecer una experiencia fluida durante todo el evento, independientemente de la cantidad de sesiones procesadas.

La prioridad será mantener la continuidad del trabajo del operador.

---

# 13.2 Principios de Rendimiento

Toda optimización deberá respetar los siguientes principios.

• La interfaz nunca deberá bloquearse.

• El operador nunca deberá esperar innecesariamente.

• El procesamiento ocurrirá en segundo plano.

• El consumo de recursos deberá mantenerse controlado.

---

# 13.3 Inicio de la Aplicación

El tiempo de inicio deberá ser el menor posible.

Al abrir SpinSession.

El sistema cargará únicamente la información necesaria para la pantalla inicial.

La información adicional se cargará de manera progresiva.

---

# 13.4 Grabación

La grabación tendrá prioridad absoluta sobre cualquier otra tarea.

Mientras exista una grabación activa.

La aplicación reducirá temporalmente otras tareas de procesamiento para garantizar la estabilidad del video.

---

# 13.5 Procesamiento Multimedia

El procesamiento mediante FFmpeg se ejecutará completamente en segundo plano.

La aplicación permitirá continuar registrando nuevas sesiones mientras otras continúan procesándose.

El operador nunca deberá esperar el término del procesamiento para continuar trabajando.

---

# 13.6 Gestión Inteligente de Recursos

SpinSession supervisará constantemente:

• Uso de CPU.

• Consumo de memoria RAM.

• Espacio de almacenamiento disponible.

Si el dispositivo presenta una carga elevada.

La aplicación reducirá automáticamente la cantidad de procesos simultáneos.

---

# 13.7 Procesamiento Paralelo

Cuando el hardware del dispositivo lo permita.

Varias sesiones podrán procesarse simultáneamente.

El número máximo de procesos concurrentes será administrado automáticamente para evitar sobrecalentamiento o pérdida de rendimiento.

---

# 13.8 Optimización del Almacenamiento

Los archivos temporales serán eliminados automáticamente una vez que:

• El procesamiento finalice.

• La sincronización sea confirmada.

• Exista una copia segura cuando corresponda.

La aplicación evitará almacenar archivos duplicados.

---

# 13.9 Optimización de la Base de Datos

Las consultas deberán utilizar índices para minimizar los tiempos de respuesta.

La información más utilizada permanecerá disponible mediante caché local.

Las consultas complejas nunca deberán ejecutarse durante una grabación.

---

# 13.10 Optimización de la Interfaz

La navegación deberá mantenerse fluida.

Las listas extensas utilizarán carga progresiva.

Las miniaturas se cargarán únicamente cuando sean visibles.

Las animaciones deberán mantenerse suaves incluso durante el procesamiento multimedia.

---

# 13.11 Gestión de Memoria

La aplicación liberará automáticamente los recursos que ya no sean necesarios.

Los archivos multimedia permanecerán abiertos únicamente durante el tiempo indispensable.

Se evitarán fugas de memoria mediante una correcta administración del ciclo de vida de cada módulo.

---

# 13.12 Optimización de Red

Cuando exista conexión.

Las cargas de archivos se realizarán en segundo plano.

El ancho de banda será administrado para evitar afectar el funcionamiento general de la aplicación.

Las operaciones podrán pausarse y reanudarse automáticamente si la conectividad cambia.

---

# 13.13 Gestión de Energía

SpinSession deberá minimizar el consumo de batería.

El sistema evitará procesos innecesarios mientras permanezca inactivo.

Las tareas pesadas solo se ejecutarán cuando sean realmente necesarias.

---

# 13.14 Recuperación Automática

Si el sistema detecta una interrupción inesperada.

La aplicación restaurará automáticamente:

• Procesos pendientes.

• Cola de procesamiento.

• Cola de sincronización.

• Estados de las sesiones.

La recuperación deberá ser transparente para el operador.

---

# 13.15 Escalabilidad del Rendimiento

La arquitectura deberá soportar un incremento considerable en la cantidad de sesiones por evento sin afectar la estabilidad de la aplicación.

El rendimiento deberá mantenerse constante incluso durante jornadas de trabajo prolongadas.

---

# 13.16 Monitoreo

SpinSession registrará métricas de funcionamiento para facilitar el diagnóstico de problemas.

Ejemplos:

• Tiempo promedio de procesamiento.

• Tiempo promedio de sincronización.

• Uso de almacenamiento.

• Cantidad de sesiones procesadas.

• Errores detectados.

Estas métricas serán utilizadas únicamente para mejorar el rendimiento del sistema.

---

# 13.17 Compatibilidad

La aplicación deberá ofrecer un funcionamiento estable en dispositivos Android compatibles con Flutter.

Las funciones principales deberán mantenerse operativas independientemente de la potencia del dispositivo.

---

# 13.18 Arquitectura de Alto Rendimiento

Todas las decisiones técnicas deberán priorizar:

• Estabilidad.

• Fluidez.

• Bajo consumo de recursos.

• Continuidad operacional.

La experiencia del operador siempre tendrá prioridad sobre tareas secundarias.

---

Fin del capítulo 13.

# PRODUCT REQUIREMENTS DOCUMENT (PRD)

# Capítulo 14 - Plan de Pruebas y Aseguramiento de la Calidad

Versión: 1.0

---

# 14. Plan de Pruebas y Aseguramiento de la Calidad

## 14.1 Objetivo

Este capítulo define las pruebas que deberán realizarse antes de publicar cualquier versión de SpinSession.

El objetivo será garantizar la estabilidad, confiabilidad y correcto funcionamiento de todas las funcionalidades de la aplicación.

Ninguna versión podrá considerarse final sin superar satisfactoriamente las pruebas definidas en este documento.

---

# 14.2 Tipos de Pruebas

El proceso de validación incluirá:

• Pruebas unitarias.

• Pruebas de integración.

• Pruebas funcionales.

• Pruebas de rendimiento.

• Pruebas de recuperación.

• Pruebas de experiencia de usuario.

Cada tipo de prueba tendrá un objetivo específico dentro del desarrollo.

---

# 14.3 Pruebas de Autenticación

Se deberá verificar:

• Registro de usuarios.

• Inicio de sesión.

• Recuperación de contraseña.

• Cierre de sesión.

• Persistencia de la sesión.

• Acceso desde múltiples dispositivos.

---

# 14.4 Pruebas de Calendario y Eventos

Se comprobará:

• Creación de eventos.

• Modificación de eventos.

• Eliminación de eventos.

• Aplicación de plantillas.

• Activación automática según la hora configurada.

• Finalización automática del evento.

---

# 14.5 Pruebas de Grabación

Se validará:

• Inicio de grabación.

• Cuenta regresiva.

• Duración configurada.

• Confirmación de la sesión.

• Repetición de tomas.

• Múltiples tomas dentro de una misma sesión.

---

# 14.6 Pruebas del Motor Multimedia

Se verificará:

• Generación del video original.

• Cámara lenta con Speed Ramping.

• Reverse.

• Boomerang.

• Extracción de fotografías.

• Generación de miniaturas.

• Calidad de exportación.

---

# 14.7 Pruebas de SpinLab

Se comprobará:

• Grabación de prueba.

• Procesamiento local.

• Comparación entre estilos.

• Reproducción ilimitada.

• Eliminación automática de archivos temporales.

• Ausencia de registros en la base de datos.

---

# 14.8 Pruebas de Sincronización

Se validará:

• Sincronización automática.

• Cola de sincronización.

• Reintentos automáticos.

• Recuperación después de pérdida de Internet.

• Recuperación tras reiniciar la aplicación.

• Sincronización entre múltiples dispositivos.

---

# 14.9 Pruebas de la Galería Pública

Se comprobará:

• Acceso mediante QR.

• Visualización de sesiones.

• Reproducción de videos.

• Actualización automática.

• Restricción de descarga.

---

# 14.10 Pruebas de la Sesión Privada

Se verificará:

• Generación del enlace privado.

• Acceso mediante token.

• Reproducción de archivos.

• Descarga individual.

• Descarga completa de la sesión (si está habilitada).

• Expiración del enlace.

---

# 14.11 Pruebas de WhatsApp

Se comprobará:

• Generación del mensaje.

• Envío del enlace privado.

• Reintentos cuando existan sesiones pendientes.

• Actualización del estado de envío.

---

# 14.12 Pruebas Offline

Se simularán escenarios sin conexión.

Ejemplos:

• Todo el evento sin Internet.

• Pérdida de señal durante la grabación.

• Pérdida de señal durante la sincronización.

• Recuperación automática al restablecer la conexión.

---

# 14.13 Pruebas de Rendimiento

Se evaluará:

• Tiempo de inicio.

• Tiempo de procesamiento.

• Consumo de memoria.

• Consumo de batería.

• Uso de almacenamiento.

• Fluidez general.

---

# 14.14 Pruebas de Estrés

El sistema deberá someterse a cargas intensivas.

Ejemplos:

• Gran cantidad de sesiones consecutivas.

• Procesamiento simultáneo de múltiples sesiones.

• Sincronización masiva de archivos pendientes.

• Eventos de larga duración.

La aplicación deberá mantener un funcionamiento estable.

---

# 14.15 Pruebas de Seguridad

Se comprobará:

• Acceso a eventos propios.

• Restricciones entre usuarios.

• Protección de enlaces privados.

• Protección de la galería pública.

• Políticas de acceso de Supabase.

---

# 14.16 Pruebas de Compatibilidad

La aplicación deberá probarse en diferentes dispositivos Android.

Se evaluará:

• Distintas resoluciones.

• Diferentes versiones del sistema operativo.

• Diferentes capacidades de hardware.

El objetivo será garantizar una experiencia consistente.

---

# 14.17 Registro de Errores

Toda incidencia detectada deberá registrarse indicando:

• Fecha.

• Módulo afectado.

• Descripción.

• Pasos para reproducirla.

• Estado de resolución.

Estos registros servirán como base para futuras mejoras.

---

# 14.18 Criterios de Aprobación

Una versión podrá publicarse únicamente si:

• No existen errores críticos.

• Todas las funciones principales operan correctamente.

• El sistema mantiene estabilidad durante eventos prolongados.

• Las pruebas Offline First han sido superadas.

• La sincronización funciona correctamente.

---

# 14.19 Calidad del Producto

Toda nueva funcionalidad deberá incorporar sus correspondientes pruebas antes de integrarse a la aplicación.

La calidad será considerada un requisito obligatorio y no una etapa posterior del desarrollo.

---

Fin del capítulo 14.

# PRODUCT REQUIREMENTS DOCUMENT (PRD)

# Capítulo 15 - Roadmap y Evolución del Producto

Versión: 1.0

---

# 15. Roadmap y Evolución del Producto

## 15.1 Objetivo

Este capítulo define el alcance oficial de SpinSession, estableciendo qué funcionalidades formarán parte del Producto Mínimo Viable (MVP), cuáles serán implementadas en futuras versiones y cuáles quedan fuera del alcance actual.

El objetivo es mantener un desarrollo organizado, evitando incorporar funcionalidades que retrasen el lanzamiento inicial.

---

# 15.2 Objetivo del MVP

La primera versión de SpinSession deberá ser completamente funcional para operar eventos reales.

El MVP deberá permitir que un operador pueda administrar un evento de principio a fin utilizando únicamente la aplicación.

La prioridad será la estabilidad, la facilidad de uso y el funcionamiento Offline First.

---

# 15.3 Funcionalidades del MVP

La primera versión incluirá:

### Gestión

• Registro e inicio de sesión.

• Calendario de eventos.

• Creación y edición de eventos.

• Aplicación de plantillas.

• Generación del QR público.

---

### Operación

• Selección del modo del dispositivo.

• Grabación.

• Confirmación.

• Varias tomas por sesión.

• Procesamiento automático.

• Múltiples efectos por sesión.

---

### Multimedia

• Video original.

• Cámara lenta con Speed Ramping.

• Reverse.

• Boomerang.

• Extracción de fotografías.

• Miniaturas automáticas.

---

### Sincronización

• Funcionamiento Offline First.

• Cola de procesamiento.

• Cola de sincronización.

• Reanudación automática.

---

### Publicación

• Galería pública mediante QR.

• Página privada por sesión.

• Descarga individual.

• Descarga completa de la sesión.

• Envío automático del enlace privado por WhatsApp.

---

### Administración

• Historial de eventos.

• Registro de sesiones.

• Descarga de archivos.

• Eliminación manual.

• Eliminación automática.

---

# 15.4 Versión 1.1

Una vez estabilizado el MVP podrán incorporarse las siguientes mejoras.

• Integración con Transbank.

• Integración con Mercado Pago.

• Estadísticas básicas.

• Mejoras de rendimiento.

• Optimización del procesamiento multimedia.

• Nuevos estilos predefinidos.

• Mejoras de la galería pública.

---

# 15.5 Versión 2.0

La segunda gran versión podrá incorporar funcionalidades avanzadas.

Ejemplos:

• Aplicación para iOS.

• Panel administrativo Web.

• Gestión de múltiples operadores.

• Integración con cámaras profesionales.

• Sincronización local entre dispositivos.

• Dashboard empresarial.

• Facturación.

• Inteligencia Artificial para mejorar automáticamente los videos.

---

# 15.6 Ideas Futuras

Las siguientes ideas quedan registradas como posibles evoluciones del proyecto.

• Mayor cantidad de estilos multimedia.

• Personalización visual de la galería.

• Música licenciada.

• Marca de agua configurable.

• Exportación avanzada.

• Integración con redes sociales.

Estas funciones no forman parte del MVP.

---

# 15.7 Funcionalidades Descartadas para el MVP

Las siguientes funciones no serán desarrolladas durante la primera versión.

• Editor de estilos personalizados.

• Edición manual de videos.

• Compartición directa desde la aplicación.

• Streaming en vivo.

• Edición colaborativa.

• Integraciones con servicios externos no esenciales.

Estas funcionalidades podrán reevaluarse en futuras versiones.

---

# 15.8 Filosofía del Producto

SpinSession deberá mantener una filosofía basada en los siguientes principios.

• Simplicidad para el operador.

• Rapidez durante los eventos.

• Funcionamiento sin depender de Internet.

• Automatización del procesamiento.

• Escalabilidad.

• Diseño moderno.

Toda nueva funcionalidad deberá respetar estos principios.

---

# 15.9 Criterios para Nuevas Funciones

Antes de incorporar cualquier nueva funcionalidad deberá responder afirmativamente las siguientes preguntas.

• ¿Aporta valor real al operador?

• ¿Reduce tiempo durante el evento?

• ¿Mantiene la simplicidad de uso?

• ¿Respeta el funcionamiento Offline First?

• ¿No compromete el rendimiento?

Si alguna respuesta es negativa, la funcionalidad deberá ser reevaluada.

---

# 15.10 Visión del Proyecto

SpinSession nace con el objetivo de convertirse en una plataforma profesional para la gestión integral de experiencias audiovisuales en eventos.

La aplicación no será únicamente una herramienta para grabar videos 360, sino un ecosistema completo que facilite la organización de eventos, el procesamiento multimedia, la distribución del contenido y la experiencia tanto del operador como de los invitados.

Cada decisión de diseño y desarrollo deberá orientarse a construir una plataforma robusta, escalable y preparada para evolucionar durante los próximos años.

---

# 15.11 Cierre del PRD

El presente Product Requirements Document constituye la especificación funcional y técnica oficial de SpinSession.

Toda implementación deberá basarse en los requisitos definidos en este documento.

Las modificaciones futuras deberán realizarse mediante nuevas versiones del PRD, manteniendo la trazabilidad de los cambios y asegurando la coherencia de la arquitectura general del sistema.

---

Fin del Capítulo 15.

Fin del Product Requirements Document (PRD) versión 1.0.

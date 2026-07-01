# ANEXO TÉCNICO

# A.1 Arquitectura General del Sistema

Versión: 2.0

---

# A.1 Arquitectura General del Sistema

## A.1.1 Objetivo

Este documento define la arquitectura técnica oficial de SpinSession.

Su finalidad es establecer una base sólida para el desarrollo del sistema, asegurando que todas las funcionalidades compartan una misma filosofía de construcción y que la aplicación pueda evolucionar durante los próximos años sin necesidad de rediseñar su arquitectura.

Todas las implementaciones deberán respetar las decisiones aquí definidas.

---

# A.1.2 Filosofía Arquitectónica

SpinSession se desarrollará bajo los siguientes principios:

* Offline First.
* Arquitectura modular.
* Bajo acoplamiento.
* Alta cohesión.
* Procesamiento local.
* Sincronización diferida.
* Escalabilidad horizontal.
* Diseño orientado a eventos.

La prioridad del sistema será garantizar la continuidad operativa durante un evento, incluso en ausencia total de conexión a Internet.

---

# A.1.3 Arquitectura Global

La arquitectura completa del sistema estará compuesta por cinco bloques principales.

```text
                   ┌────────────────────┐
                   │      Flutter       │
                   │        UI          │
                   └─────────┬──────────┘
                             │
                    Riverpod Controllers
                             │
                             ▼
                   ┌────────────────────┐
                   │   Business Layer   │
                   │ (Reglas del negocio)
                   └─────────┬──────────┘
                             │
                  Repositories / Services
                             │
           ┌─────────────────┴─────────────────┐
           │                                   │
           ▼                                   ▼
    Drift (SQLite)                    Supabase Backend
      Base Local                 Database + Storage + Auth
           │                                   ▲
           └────────── Sync Engine ────────────┘
```

La interfaz nunca accederá directamente a la base de datos ni a Supabase.

Toda operación deberá pasar por la capa de negocio.

---

# A.1.4 Dominios del Sistema

La aplicación se dividirá en dominios funcionales independientes.

```text
Autenticación

↓

Gestión de Eventos

↓

Grabación

↓

Procesamiento Multimedia

↓

Sesiones

↓

Sincronización

↓

Galería Pública

↓

Configuración
```

Cada dominio será independiente y podrá evolucionar sin afectar a los demás.

---

# A.1.5 Flujo General de una Sesión

Durante un evento, una sesión seguirá exactamente el siguiente recorrido:

```text
Operador

↓

Registro del invitado

↓

Grabación

↓

Confirmación

↓

Procesamiento local

↓

Registro en Drift

↓

Cola de sincronización

↓

Supabase

↓

Generación del enlace privado

↓

Envío por WhatsApp

↓

Disponible en la galería
```

Este flujo nunca dependerá de la disponibilidad de Internet.

---

# A.1.6 Comunicación Entre Módulos

Los módulos nunca se comunicarán directamente entre sí.

Toda comunicación deberá realizarse mediante servicios especializados.

Ejemplo:

```text
Recording

↓

SessionService

↓

Processing

↓

SyncService

↓

GalleryService

↓

WhatsAppService
```

Esto evita dependencias innecesarias entre módulos.

---

# A.1.7 Arquitectura Offline First

Toda operación seguirá el siguiente principio:

```text
Usuario

↓

Base local (Drift)

↓

Respuesta inmediata

↓

Procesamiento

↓

Sincronización cuando exista Internet
```

La experiencia del operador nunca deberá verse afectada por problemas de conectividad.

---

# A.1.8 Arquitectura Multidispositivo

SpinSession permitirá tres modos de funcionamiento:

```text
Modo Cámara

Solo grabación.
```

```text
Modo Operador

Administración completa del evento.
```

```text
Modo Ambos

Todas las funciones disponibles en un único dispositivo.
```

Cuando existan dos dispositivos conectados bajo la misma cuenta, ambos compartirán el mismo evento activo mediante sincronización en tiempo real.

---

# A.1.9 Responsabilidad de Cada Componente

| Componente   | Responsabilidad          |
| ------------ | ------------------------ |
| Flutter UI   | Interfaz de usuario      |
| Riverpod     | Gestión del estado       |
| Controllers  | Coordinación de acciones |
| Services     | Lógica técnica           |
| Repositories | Acceso a datos           |
| Drift        | Base de datos local      |
| Sync Engine  | Sincronización           |
| Supabase     | Persistencia remota      |
| FFmpeg       | Procesamiento multimedia |

Cada componente tendrá una única responsabilidad.

---

# A.1.10 Flujo de Datos

Todo dato seguirá siempre el mismo recorrido.

```text
Usuario

↓

Pantalla

↓

Controller

↓

Repository

↓

Drift

↓

Sync Engine

↓

Supabase
```

No se permitirá acceder directamente a Supabase desde una pantalla.

---

# A.1.11 Procesamiento Multimedia

El procesamiento multimedia será completamente independiente de la interfaz.

Su funcionamiento será:

```text
Video original

↓

Cola de procesamiento

↓

FFmpeg

↓

Archivos generados

↓

Registro de sesión

↓

Sincronización
```

La interfaz podrá continuar utilizándose mientras este proceso se ejecuta.

---

# A.1.12 Arquitectura de Sincronización

La sincronización será administrada por un único módulo.

Responsabilidades:

* Detectar conexión.
* Gestionar la cola.
* Resolver reintentos.
* Actualizar estados.
* Subir archivos.
* Sincronizar la base de datos.

Ningún otro módulo podrá realizar sincronizaciones directamente.

---

# A.1.13 Escalabilidad

La arquitectura deberá permitir incorporar nuevos módulos sin modificar los existentes.

Ejemplos futuros:

* Inteligencia Artificial.
* Nuevos efectos.
* Panel Web.
* iOS.
* Integración con nuevas cámaras.
* Nuevos métodos de pago.

Todos deberán integrarse como módulos independientes.

---

# A.1.14 Principios de Ingeniería

Durante todo el desarrollo deberán respetarse los siguientes principios:

* SOLID.
* DRY (Don't Repeat Yourself).
* KISS (Keep It Simple).
* Feature First.
* Offline First.
* Composition over Inheritance.

Estos principios tendrán prioridad sobre cualquier decisión de implementación.

---

# A.1.15 Decisiones Arquitectónicas

Se adoptan oficialmente las siguientes decisiones técnicas:

* Flutter como framework principal.
* Dart como único lenguaje.
* Drift para almacenamiento local.
* Supabase como backend.
* Supabase Storage para archivos.
* Riverpod como gestor de estado.
* GoRouter para navegación.
* FFmpeg Kit para procesamiento multimedia.
* UUID como identificador universal.
* Procesamiento local antes de sincronización.

Estas decisiones constituyen la arquitectura oficial del proyecto y solo podrán modificarse mediante una nueva versión del presente Anexo Técnico.

---

Fin de la sección A.1.

# ANEXO TÉCNICO

# A.2 Arquitectura Flutter

Versión: 2.0

---

# A.2 Arquitectura Flutter

## A.2.1 Objetivo

Esta sección define la arquitectura oficial de desarrollo para SpinSession en Flutter.

Su propósito es garantizar que todo el código del proyecto siga una estructura uniforme, modular y escalable, facilitando el mantenimiento y el trabajo colaborativo entre desarrolladores y asistentes de IA.

---

# A.2.2 Stack Tecnológico Oficial

Las siguientes tecnologías forman parte de la arquitectura oficial del proyecto.

| Tecnología         | Función                                       |
| ------------------ | --------------------------------------------- |
| Flutter            | Framework principal                           |
| Dart               | Lenguaje de programación                      |
| Riverpod           | Gestión de estado e inyección de dependencias |
| GoRouter           | Navegación                                    |
| Drift              | Base de datos local                           |
| Supabase           | Backend                                       |
| Supabase Storage   | Almacenamiento de archivos                    |
| FFmpeg Kit         | Procesamiento multimedia                      |
| Camera             | Captura de video                              |
| Mobile Scanner     | Lectura de códigos QR                         |
| QR Flutter         | Generación de códigos QR                      |
| Permission Handler | Gestión de permisos                           |
| Connectivity Plus  | Detección de conexión                         |
| Path Provider      | Acceso al almacenamiento del dispositivo      |
| Share Plus         | Compartir archivos (uso interno futuro)       |

No se incorporarán nuevas dependencias sin una justificación técnica.

---

# A.2.3 Arquitectura por Features

Cada funcionalidad será completamente independiente.

Ejemplo:

```text
features/

auth/
calendar/
events/
recording/
processing/
sessions/
gallery/
sync/
spinlab/
settings/
templates/
```

Cada feature contendrá únicamente el código relacionado con su funcionalidad.

---

# A.2.4 Estructura Interna de una Feature

Todas las features seguirán exactamente la misma organización.

```text
feature/

data/
│
├── models/
├── repositories/
└── datasources/

domain/
│
├── entities/
└── usecases/

presentation/
│
├── screens/
├── controllers/
├── providers/
└── states/

widgets/
```

Esta estructura será obligatoria para todas las funcionalidades.

---

# A.2.5 Flujo de una Acción

Toda interacción del usuario seguirá el siguiente recorrido.

```text
Usuario

↓

Screen

↓

Controller

↓

Repository

↓

Datasource

↓

Drift

↓

Sync Engine

↓

Supabase
```

Las pantallas nunca accederán directamente a la base de datos ni a Supabase.

---

# A.2.6 Riverpod

Riverpod será el único sistema oficial para:

* Gestión de estado.
* Inyección de dependencias.
* Comunicación entre módulos.
* Estados globales.

No se utilizarán otros gestores de estado como Provider, Bloc, GetX o MobX.

---

# A.2.7 Controllers

Cada pantalla tendrá su propio Controller.

Responsabilidades:

* Validar entradas.
* Coordinar acciones.
* Actualizar Providers.
* Invocar Repositories.
* Gestionar estados de carga.

Los Controllers no contendrán lógica de acceso a datos.

---

# A.2.8 Repositories

Los Repositories actuarán como puente entre la lógica del negocio y las fuentes de datos.

Podrán acceder a:

* Drift.
* Supabase.
* Storage.
* Caché.

No contendrán lógica de interfaz.

---

# A.2.9 Services

Los Services encapsularán procesos técnicos.

Servicios previstos:

* AuthService
* CameraService
* FFmpegService
* SyncService
* StorageService
* GalleryService
* WhatsAppService
* QRService
* NotificationService

Cada Service tendrá una única responsabilidad.

---

# A.2.10 Navegación

Toda la navegación utilizará GoRouter.

La estructura de rutas será centralizada.

Ejemplo:

```text
/

login

device-selection

calendar

event

recording

gallery

settings

spinlab
```

Las rutas protegidas verificarán automáticamente que exista una sesión iniciada.

---

# A.2.11 Gestión del Estado

Los estados seguirán una estructura uniforme.

Ejemplo:

```text
Idle

↓

Loading

↓

Success

↓

Error
```

Cada pantalla deberá manejar estos estados de forma consistente.

---

# A.2.12 Widgets Compartidos

Los componentes reutilizables no pertenecerán a una feature específica.

Ejemplos:

* Botones.
* Inputs.
* Tarjetas.
* Diálogos.
* Snackbars.
* Indicadores de carga.
* Selectores de fecha.

Estos vivirán en la carpeta `shared`.

---

# A.2.13 Temas

SpinSession contará con dos temas oficiales.

### Tema Claro

* Fondo blanco cálido.
* Color principal morado vibrante.
* Grises suaves.
* Alto contraste.

### Tema Oscuro

* Fondo azul muy oscuro con matiz violáceo (no negro puro).
* Morado principal ligeramente más brillante.
* Blancos suaves para el texto.
* Contrastes optimizados para uso nocturno.

El cambio de tema será inmediato y persistente.

---

# A.2.14 Rendimiento

Se establecen las siguientes reglas:

* Evitar reconstrucciones innecesarias.
* Utilizar `const` siempre que sea posible.
* Dividir pantallas grandes en widgets pequeños.
* No realizar consultas en el método `build()`.
* Mantener la lógica fuera de los widgets.

---

# A.2.15 Convenciones de Desarrollo

Todo el proyecto seguirá las siguientes convenciones.

Archivos:

```text
snake_case.dart
```

Clases:

```text
PascalCase
```

Variables:

```text
camelCase
```

Constantes:

```text
UPPER_SNAKE_CASE
```

---

# A.2.16 Creación de Nuevas Features

Toda nueva funcionalidad deberá cumplir el siguiente proceso:

1. Crear la carpeta de la feature.
2. Definir Models.
3. Crear Repositories.
4. Crear Controllers.
5. Registrar Providers.
6. Crear Screens.
7. Registrar la ruta en GoRouter.
8. Agregar pruebas unitarias.

No se permitirá implementar una pantalla sin seguir este flujo.

---

# A.2.17 Calidad del Código

Todo nuevo código deberá cumplir:

* Sin duplicación de lógica.
* Métodos cortos y legibles.
* Comentarios solo cuando aporten valor.
* Nombres descriptivos.
* Responsabilidad única por clase.

---

# A.2.18 Arquitectura Oficial

La arquitectura definida en esta sección constituye el estándar de desarrollo de Flutter para SpinSession.

Cualquier modificación deberá ser evaluada antes de incorporarse al proyecto para mantener la coherencia y facilitar el mantenimiento a largo plazo.

---

Fin de la sección A.2.

# ANEXO TÉCNICO

# A.3 Arquitectura de Base de Datos

Versión: 2.0

---

# A.3 Arquitectura de Base de Datos

## A.3.1 Objetivo

Esta sección define la arquitectura oficial de la base de datos de SpinSession.

El objetivo es diseñar un modelo de datos robusto, escalable y compatible con la filosofía Offline First del proyecto.

Toda la información deberá almacenarse inicialmente en Drift y sincronizarse posteriormente con Supabase.

---

# A.3.2 Filosofía

La arquitectura de datos seguirá los siguientes principios:

• UUID como identificador universal.

• Compatibilidad entre Drift y PostgreSQL.

• Sincronización diferida.

• Relaciones explícitas.

• Escalabilidad.

• Integridad referencial.

---

# A.3.3 Arquitectura General

La estructura principal será:

```text
Usuario
│
├── Plantillas
│
├── Eventos
│   │
│   ├── Configuración
│   ├── Sesiones
│   │     │
│   │     ├── Archivos
│   │     ├── Procesamiento
│   │     └── Sincronización
│   │
│   └── QR Público
│
└── Preferencias
```

Cada entidad tendrá una responsabilidad específica.

---

# A.3.4 Tabla Users

Representa al propietario de la cuenta.

Campos principales:

• id

• auth_id

• name

• email

• created_at

• updated_at

Cada usuario administrará únicamente sus propios eventos.

---

# A.3.5 Tabla Event Templates

Almacena las planillas reutilizables.

Campos principales:

• id

• user_id

• name

• duration

• default_effects

• auto_delete_days

• created_at

Estas plantillas podrán utilizarse al crear nuevos eventos.

---

# A.3.6 Tabla Events

Representa cada evento registrado.

Campos principales:

• id

• user_id

• template_id

• name

• event_date

• start_datetime

• end_datetime

• payment_status

• event_status

• gallery_slug

• created_at

• updated_at

---

# A.3.7 Estados del Evento

```text
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
```

El cambio entre estados será controlado por la lógica del sistema.

---

# A.3.8 Tabla Event Settings

Almacena la configuración específica de cada evento.

Campos principales:

• id

• event_id

• default_duration

• default_effects

• allow_multiple_sessions

• updated_at

Separar esta configuración permitirá modificar parámetros sin alterar la información principal del evento.

---

# A.3.9 Tabla Sessions

Representa una sesión realizada a una persona o grupo.

Campos principales:

• id

• event_id

• guest_name

• phone

• country_code

• notes

• device_id

• status

• created_at

Cada sesión podrá generar múltiples archivos.

---

# A.3.10 Estados de la Sesión

```text
Registrada

↓

Grabando

↓

Procesando

↓

Pendiente de Sincronizar

↓

Sincronizada

↓

Enviada

↓

Completada
```

Estos estados permitirán conocer el avance de cada sesión.

---

# A.3.11 Tabla Session Assets

Almacena todos los archivos generados.

Campos principales:

• id

• session_id

• type

• local_path

• remote_path

• file_size

• duration

• synced

• created_at

---

# A.3.12 Tipos de Archivo

Los tipos iniciales serán:

• Original

• Cámara Lenta

• Reverse

• Boomerang

• Ráfaga

• Miniatura

El sistema permitirá añadir nuevos efectos sin modificar la estructura de la base de datos.

---

# A.3.13 Tabla Processing Jobs

Gestiona la cola de procesamiento multimedia.

Campos principales:

• id

• session_id

• job_type

• priority

• progress

• status

• created_at

• finished_at

Su objetivo será permitir que el procesamiento continúe incluso después de cerrar la aplicación.

---

# A.3.14 Tabla Sync Jobs

Gestiona toda la sincronización con Supabase.

Campos principales:

• id

• session_id

• sync_type

• attempts

• last_error

• status

• created_at

Esta cola será procesada automáticamente cuando exista conexión.

---

# A.3.15 Tabla Devices

Representa los dispositivos asociados a una cuenta.

Campos principales:

• id

• user_id

• device_name

• device_type

• last_seen

• active

Tipos disponibles:

• Camera

• Operator

• Both

---

# A.3.16 Relaciones

La estructura principal será:

```text
User

├── Event Templates

├── Events
      │
      ├── Event Settings
      ├── Sessions
      │      │
      │      ├── Session Assets
      │      ├── Processing Jobs
      │      └── Sync Jobs
      │
      └── Devices
```

Todas las relaciones utilizarán claves foráneas.

---

# A.3.17 Índices

Se crearán índices para optimizar:

• Eventos por usuario.

• Eventos por fecha.

• Sesiones por evento.

• Sesiones por teléfono.

• Archivos por sesión.

• Procesamientos pendientes.

• Sincronizaciones pendientes.

---

# A.3.18 Integridad

Toda la base de datos deberá garantizar:

• Consistencia.

• Relaciones válidas.

• Ausencia de registros huérfanos.

• Compatibilidad entre Drift y Supabase.

---

# A.3.19 Versionado

Toda modificación estructural incrementará la versión del esquema.

Las migraciones deberán preservar los datos existentes.

---

# A.3.20 Arquitectura Oficial

La estructura definida en esta sección constituye el modelo oficial de datos de SpinSession.

Cualquier nueva funcionalidad deberá integrarse respetando esta arquitectura para mantener la coherencia, facilitar la sincronización y asegurar la escalabilidad del sistema.

---

Fin de la sección A.3.

# ANEXO TÉCNICO

# A.4 Estándar de Desarrollo y Reglas para IA

Versión: 1.0

---

# A.4 Estándar de Desarrollo y Reglas para IA

## A.4.1 Objetivo

Este documento establece las reglas oficiales de desarrollo para SpinSession.

Su finalidad es garantizar que todo el código generado por desarrolladores o asistentes de IA mantenga una arquitectura uniforme, escalable, mantenible y consistente durante toda la vida útil del proyecto.

Estas reglas son obligatorias.

---

# A.4.2 Principios

Todo el desarrollo deberá respetar:

• SOLID

• DRY (Don't Repeat Yourself)

• KISS (Keep It Simple)

• Composition over Inheritance

• Offline First

• Feature First

• Código legible por encima de código complejo

---

# A.4.3 Regla Principal

Antes de escribir cualquier línea de código deberá responderse:

• ¿Existe ya un componente reutilizable?

• ¿Existe un servicio que haga esta tarea?

• ¿Existe un widget similar?

• ¿Puede reutilizarse un Provider?

Si la respuesta es sí, deberá reutilizarse antes de crear uno nuevo.

---

# A.4.4 Organización

Toda nueva funcionalidad deberá desarrollarse dentro de una Feature.

No se crearán carpetas fuera de la estructura oficial.

---

# A.4.5 Pantallas

Cada pantalla deberá contener únicamente:

• Construcción de interfaz.

• Consumo de Providers.

• Navegación.

No contendrá lógica de negocio.

---

# A.4.6 Controllers

Los Controllers serán responsables de:

• Validar datos.

• Ejecutar acciones.

• Coordinar procesos.

• Actualizar estados.

Nunca accederán directamente a Supabase.

Nunca accederán directamente a FFmpeg.

Nunca accederán directamente a Storage.

---

# A.4.7 Services

Cada Service tendrá una única responsabilidad.

Ejemplos:

• CameraService

• FFmpegService

• QRService

• SyncService

• StorageService

• WhatsAppService

No deberán depender entre sí cuando pueda evitarse.

---

# A.4.8 Repositories

Los Repositories serán el único punto de acceso a los datos.

Todo acceso a:

• Drift

• Supabase

• Storage

deberá pasar por un Repository.

---

# A.4.9 Providers

Riverpod será el único gestor de estado.

No se permitirá:

• Provider

• Bloc

• Cubit

• GetX

• MobX

Toda dependencia será inyectada mediante Riverpod.

---

# A.4.10 Widgets

Todo widget deberá ser pequeño.

Si supera aproximadamente 250 líneas deberá dividirse.

Los widgets reutilizables vivirán en Shared.

Los widgets específicos vivirán dentro de su Feature.

---

# A.4.11 Asincronía

Toda operación pesada deberá ejecutarse en segundo plano.

Ejemplos:

• FFmpeg.

• Subidas.

• Descargas.

• Sincronización.

• Lectura de archivos.

La interfaz nunca deberá bloquearse.

---

# A.4.12 Offline First

Toda operación seguirá este orden.

Usuario

↓

Drift

↓

Confirmación inmediata

↓

Procesamiento

↓

Sincronización

Internet nunca será un requisito para utilizar la aplicación durante un evento.

---

# A.4.13 Manejo de Errores

Nunca mostrar errores técnicos.

Incorrecto:

Exception 500

Correcto:

"No fue posible sincronizar la sesión. Se intentará nuevamente cuando exista conexión."

Todos los errores deberán registrarse para depuración.

---

# A.4.14 Nombres

Archivos:

snake_case

Clases:

PascalCase

Variables:

camelCase

Constantes:

UPPER_SNAKE_CASE

---

# A.4.15 Comentarios

Solo comentar cuando sea necesario.

Nunca comentar código obvio.

Preferir nombres descriptivos.

---

# A.4.16 Rendimiento

Priorizar:

• Widgets const.

• Lazy Loading.

• Caché local.

• Consultas optimizadas.

• Reconstrucciones mínimas.

---

# A.4.17 Multimedia

Todo procesamiento deberá realizarse mediante FFmpeg.

Nunca modificar el video original.

Todos los efectos deberán generarse como nuevos archivos.

---

# A.4.18 Sincronización

Toda sincronización deberá ser idempotente.

Si una tarea falla:

• No deberá duplicarse.

• No deberá perder información.

• Deberá reintentarse automáticamente.

---

# A.4.19 Escalabilidad

Toda nueva funcionalidad deberá poder añadirse sin modificar módulos existentes.

La arquitectura deberá crecer agregando Features.

Nunca modificando la estructura principal.

---

# A.4.20 Código Generado por IA

Toda IA que participe en el desarrollo deberá respetar las siguientes reglas:

• No modificar archivos no relacionados.

• No duplicar lógica existente.

• Mantener la estructura oficial.

• Crear código reutilizable.

• No añadir dependencias sin autorización.

• Mantener coherencia visual con el diseño oficial.

• Respetar los temas claro y oscuro.

• Mantener compatibilidad con Android.

• Mantener compatibilidad futura con iOS.

• Seguir estrictamente el PRD y este Anexo Técnico.

---

# A.4.21 Regla de Oro

Ante cualquier duda durante el desarrollo se seguirá el siguiente orden de prioridad:

1. PRD.

2. Anexo Técnico.

3. Consistencia del proyecto.

4. Simplicidad de implementación.

Nunca se implementará una solución rápida que comprometa la arquitectura.

---

Fin de la sección A.4.
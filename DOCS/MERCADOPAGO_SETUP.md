# Configuración de Mercado Pago

Guía para dejar funcionando el pago automático de eventos (link de pago por
evento + confirmación automática vía webhook). El código ya está listo —
esto son los pasos que solo vos podés hacer (crear la cuenta, guardar el
secreto, desplegar).

---

## 1. Crear cuenta y Access Token

1. Entrá a [Mercado Pago Developers](https://www.mercadopago.cl/developers/panel) con tu cuenta de Mercado Pago (o creá una).
2. Creá una aplicación ("Tus integraciones" → "Crear aplicación").
3. En la sección **Credenciales de producción** (o **de prueba**, mientras testeás), copiá el **Access Token**.
   - Empezá con las credenciales **de prueba** para probar todo el flujo sin plata real. Mercado Pago te da tarjetas de prueba en la misma sección.
   - Cuando esté todo probado, repetís el paso 3 con las credenciales de **producción**.

## 2. Instalar la CLI de Supabase (si no la tenés)

```bash
npm install -g supabase
```

## 3. Login y vincular el proyecto

```bash
supabase login
supabase link --project-ref oqizdogjktxvebqlputj
```

## 4. Guardar el Access Token como secreto (nunca en el repo)

```bash
supabase secrets set MP_ACCESS_TOKEN="TU_ACCESS_TOKEN_ACA"
```

Opcional — si querés ajustar el precio fijo sin recompilar la app, también podés setear:

```bash
supabase secrets set MP_FIXED_PRICE_CLP="50000"
```

(Si no lo seteás, usa el valor por defecto de `lib/core/config/mercadopago_config.dart`.)

## 5. Desplegar las dos Edge Functions

```bash
supabase functions deploy create-payment-preference
supabase functions deploy mercadopago-webhook
```

No hace falta configurar nada más en el dashboard de Mercado Pago — la
URL del webhook (`notification_url`) se manda automáticamente en cada
preferencia que crea `create-payment-preference`.

## 6. Correr el SQL nuevo

En el SQL Editor de Supabase, corré de nuevo `DOCS/supabase_schema.sql`
completo (es idempotente, no rompe nada existente) — agrega la columna
`payment_link` a la tabla `events`.

## 7. Probar

1. Abrí un evento sin pagar en la app → menú (⋮) → **"Registrar pago"**.
2. Se abre el checkout de Mercado Pago en el navegador.
3. Pagá con una tarjeta de prueba (si usaste credenciales de prueba).
4. Sin tocar nada más en la app, el evento debería pasar a **"Pagado"** solo
   (esto lo hace el webhook) y aparece automáticamente el QR de la galería.
5. Si no pasa nada después de pagar: revisá los logs de la función con
   `supabase functions logs mercadopago-webhook`.

## Notas de seguridad

- El Access Token nunca vive en el repo ni en la app — solo en los secretos
  de Supabase Edge Functions, del lado del servidor.
- El webhook **no confía** en la notificación entrante — siempre verifica el
  pago real contra la API de Mercado Pago antes de marcar un evento como
  pagado.
- Cada evento genera su propia preferencia de pago (mismo precio fijo,
  `external_reference` distinto), así el webhook sabe con certeza a qué
  evento corresponde cada pago.

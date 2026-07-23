// Recibe las notificaciones (webhooks) de Mercado Pago y marca el evento
// correspondiente como pagado — sin intervención manual del operador.
//
// IMPORTANTE: nunca confía en el cuerpo de la notificación (cualquiera
// puede simular un POST a esta URL). Solo usa el `id` de pago que llega
// para consultar el pago REAL contra la API de Mercado Pago con el access
// token, y recién ahí decide si marcar el evento como pagado.
//
// Configurar esta URL como "notification_url" ya queda hecho automáticamente
// por create-payment-preference al crear cada preferencia — no hace falta
// registrarla a mano en el dashboard de Mercado Pago.
//
// Variables de entorno: mismas que create-payment-preference (MP_ACCESS_TOKEN,
// SUPABASE_URL y SUPABASE_SERVICE_ROLE_KEY — estas dos últimas ya las
// inyecta Supabase automáticamente).

import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const MP_ACCESS_TOKEN = Deno.env.get("MP_ACCESS_TOKEN") ?? "";
const SUPABASE_URL = Deno.env.get("SUPABASE_URL") ?? "";
const SUPABASE_SERVICE_ROLE_KEY = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY") ?? "";

Deno.serve(async (req) => {
  if (!MP_ACCESS_TOKEN) {
    console.error("Falta configurar el secreto MP_ACCESS_TOKEN");
    // 500 para que Mercado Pago reintente una vez que se configure el secreto.
    return new Response("missing config", { status: 500 });
  }

  try {
    const url = new URL(req.url);
    // Mercado Pago manda el id del pago por query string (IPN clásico:
    // ?topic=payment&id=... o webhooks v2: ?type=payment&data.id=...).
    let paymentId =
      url.searchParams.get("data.id") ?? url.searchParams.get("id");
    const topic = url.searchParams.get("type") ?? url.searchParams.get("topic");

    if (!paymentId && req.method === "POST") {
      const body = await req.json().catch(() => null);
      paymentId = body?.data?.id ?? null;
    }

    if (topic && topic !== "payment") {
      // Ignora notificaciones que no son de pago (ej. "merchant_order").
      return new Response("ignored", { status: 200 });
    }

    if (!paymentId) {
      return new Response("no payment id", { status: 200 });
    }

    // Verifica el pago real contra la API de Mercado Pago — nunca confiar
    // en el body/query de la notificación entrante.
    const paymentRes = await fetch(
      `https://api.mercadopago.com/v1/payments/${paymentId}`,
      { headers: { "Authorization": `Bearer ${MP_ACCESS_TOKEN}` } },
    );

    if (!paymentRes.ok) {
      console.error(
        "No se pudo verificar el pago",
        paymentId,
        paymentRes.status,
        await paymentRes.text(),
      );
      // 502 para que Mercado Pago reintente — puede ser un problema
      // transitorio de red, no necesariamente un pago inválido.
      return new Response("could not verify payment", { status: 502 });
    }

    const payment = await paymentRes.json();
    const eventId = payment.external_reference as string | undefined;

    if (payment.status === "approved" && eventId) {
      const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY);
      const { error } = await supabase
        .from("events")
        .update({ payment_status: "paid", event_status: "paid" })
        .eq("id", eventId);

      if (error) {
        console.error("No se pudo actualizar el evento", eventId, error);
        return new Response("db update failed", { status: 500 });
      }

      console.log(`Evento ${eventId} marcado como pagado (pago ${paymentId})`);
    }

    return new Response("ok", { status: 200 });
  } catch (error) {
    console.error(error);
    // 500 para que Mercado Pago reintente ante un error nuestro transitorio.
    return new Response("internal error", { status: 500 });
  }
});

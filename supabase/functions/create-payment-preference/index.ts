// Crea (o reutiliza) el link de pago de Mercado Pago para un evento.
//
// Recibe { eventId } y devuelve { checkoutUrl }. El precio es fijo (mismo
// monto para todos los eventos) pero cada evento genera su PROPIA
// preferencia, con `external_reference = eventId`, para que el webhook
// (mercadopago-webhook) sepa exactamente qué evento marcar como pagado
// cuando llegue la confirmación.
//
// Variables de entorno requeridas:
// - MP_ACCESS_TOKEN: secreto de Mercado Pago (configurar con
//   `supabase secrets set MP_ACCESS_TOKEN=...`)
// - SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY: ya los inyecta Supabase
//   automáticamente en toda Edge Function, no hace falta configurarlos.
// - MP_FIXED_PRICE_CLP (opcional): monto fijo en CLP, default 50000.

import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers":
    "authorization, x-client-info, apikey, content-type",
};

const MP_ACCESS_TOKEN = Deno.env.get("MP_ACCESS_TOKEN") ?? "";
const SUPABASE_URL = Deno.env.get("SUPABASE_URL") ?? "";
const SUPABASE_SERVICE_ROLE_KEY = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY") ?? "";
const FIXED_PRICE_CLP = Number(Deno.env.get("MP_FIXED_PRICE_CLP") ?? "50000");

function json(body: unknown, status = 200) {
  return new Response(JSON.stringify(body), {
    status,
    headers: { ...corsHeaders, "Content-Type": "application/json" },
  });
}

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") {
    return new Response("ok", { headers: corsHeaders });
  }

  if (!MP_ACCESS_TOKEN) {
    console.error("Falta configurar el secreto MP_ACCESS_TOKEN");
    return json({ error: "Pasarela de pago no configurada" }, 500);
  }

  try {
    const { eventId } = await req.json();
    if (!eventId || typeof eventId !== "string") {
      return json({ error: "Falta eventId" }, 400);
    }

    const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY);

    const { data: event, error: eventError } = await supabase
      .from("events")
      .select("id, name, payment_link, payment_status")
      .eq("id", eventId)
      .maybeSingle();

    if (eventError || !event) {
      return json({ error: "Evento no encontrado" }, 404);
    }

    // Si ya se generó un link antes, se reutiliza en vez de crear una
    // preferencia nueva en Mercado Pago cada vez que se reabre el detalle.
    if (event.payment_link) {
      return json({ checkoutUrl: event.payment_link });
    }

    const notificationUrl = `${SUPABASE_URL}/functions/v1/mercadopago-webhook`;

    const mpResponse = await fetch(
      "https://api.mercadopago.com/checkout/preferences",
      {
        method: "POST",
        headers: {
          "Authorization": `Bearer ${MP_ACCESS_TOKEN}`,
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          items: [
            {
              title: `SpinSession — ${event.name}`,
              quantity: 1,
              currency_id: "CLP",
              unit_price: FIXED_PRICE_CLP,
            },
          ],
          external_reference: eventId,
          notification_url: notificationUrl,
        }),
      },
    );

    if (!mpResponse.ok) {
      const errBody = await mpResponse.text();
      console.error("Mercado Pago error:", mpResponse.status, errBody);
      return json({ error: "No se pudo crear la preferencia de pago" }, 502);
    }

    const preference = await mpResponse.json();
    const checkoutUrl = preference.init_point as string;

    await supabase
      .from("events")
      .update({ payment_link: checkoutUrl })
      .eq("id", eventId);

    return json({ checkoutUrl });
  } catch (error) {
    console.error(error);
    return json({ error: "Error interno" }, 500);
  }
});

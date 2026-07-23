/// Precio fijo del evento en pesos chilenos (CLP), usado al generar la
/// preferencia de pago de Mercado Pago para cada evento
/// (ver `supabase/functions/create-payment-preference`).
///
/// TODO: ajustar al monto real antes de producción.
abstract final class MercadoPagoConfig {
  static const fixedPriceClp = int.fromEnvironment(
    'MP_FIXED_PRICE_CLP',
    defaultValue: 50000,
  );

  static const currency = 'CLP';
}

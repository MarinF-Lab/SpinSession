import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/config/web_gallery_config.dart';
import '../../../sessions/domain/entities/session_entity.dart';

class SyncService {
  SyncService(this._client);

  final SupabaseClient _client;

  /// URL pública de la página web de la sesión privada de un invitado
  /// (`session.html?session=<id>`), alojada en el bucket público
  /// `spinsession-web`. Es el único link que se debe compartir por
  /// WhatsApp o QR para una sesión individual.
  String buildPrivateSessionUrl(String sessionId) =>
      WebGalleryConfig.privateSession(sessionId);

  Future<void> syncSession(SessionEntity session) async {
    await _client.from('sessions').upsert({
      'id': session.id,
      'event_id': session.eventId,
      'guest_name': session.guestName,
      'phone': session.phone,
      'country_code': session.countryCode,
      'notes': session.notes,
      'device_id': session.deviceId,
      'status': session.status.value,
      'created_at': session.createdAt.toIso8601String(),
    });
  }

  Future<void> syncAsset({
    required String id,
    required String sessionId,
    required String localPath,
    required String remotePath,
    required String assetType,
    required int takeNumber,
  }) async {
    await _client.from('session_assets').upsert({
      'id': id,
      'session_id': sessionId,
      'local_path': localPath,
      'remote_path': remotePath,
      'asset_type': assetType,
      'take_number': takeNumber,
    });
  }

  Future<void> sendWhatsapp({
    required String phone,
    required String countryCode,
    required String sessionId,
    required String guestName,
  }) async {
    final cleanCountry = countryCode.replaceAll('+', '');
    final cleanPhone = phone.replaceAll(RegExp(r'[^0-9]'), '');
    final message = '¡Hola $guestName! 🎬\n\n'
        'Gracias por participar. Tus videos ya están disponibles.\n\n'
        'Descárgalos aquí:\n${buildPrivateSessionUrl(sessionId)}\n\n'
        'SpinSession';

    final encoded = Uri.encodeComponent(message);
    // Abre WhatsApp directamente en el chat del invitado. Se intenta primero
    // el esquema nativo (chat directo) y, si no está disponible, el enlace
    // web wa.me como respaldo.
    final nativeUri = Uri.parse(
        'whatsapp://send?phone=$cleanCountry$cleanPhone&text=$encoded');
    final webUri =
        Uri.parse('https://wa.me/$cleanCountry$cleanPhone?text=$encoded');

    if (await canLaunchUrl(nativeUri)) {
      await launchUrl(nativeUri, mode: LaunchMode.externalApplication);
    } else {
      await launchUrl(webUri, mode: LaunchMode.externalApplication);
    }
  }
}

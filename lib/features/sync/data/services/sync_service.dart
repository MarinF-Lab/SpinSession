import 'package:share_plus/share_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../sessions/domain/entities/session_entity.dart';

class SyncService {
  SyncService(this._client);

  final SupabaseClient _client;

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

  /// Comparte los videos de la sesión por WhatsApp en dos pasos, ya que
  /// WhatsApp no acepta archivos adjuntos por deep link (solo texto):
  /// 1) abre/crea la conversación del invitado vía wa.me (funciona aunque
  ///    el número no esté agendado como contacto);
  /// 2) dispara el selector nativo de Compartir con los videos adjuntos —
  ///    al haberse abierto recién esa conversación, WhatsApp aparece entre
  ///    los destinos recientes del selector.
  Future<void> sendWhatsapp({
    required String phone,
    required String countryCode,
    required String guestName,
    required List<String> filePaths,
  }) async {
    final cleanCountry = countryCode.replaceAll('+', '');
    final cleanPhone = phone.replaceAll(RegExp(r'[^0-9]'), '');
    final message = '¡Hola $guestName! 🎬\n\n'
        'Gracias por participar. Tus videos ya están disponibles.\n\n'
        'SpinSession';
    final encoded = Uri.encodeComponent(message);

    final waUri =
        Uri.parse('https://wa.me/$cleanCountry$cleanPhone?text=$encoded');
    await launchUrl(waUri, mode: LaunchMode.externalApplication);

    // Da tiempo a que el SO cambie el foco a WhatsApp antes de abrir el
    // selector de Compartir encima.
    await Future.delayed(const Duration(milliseconds: 700));

    if (filePaths.isNotEmpty) {
      await Share.shareXFiles(
        filePaths.map((p) => XFile(p)).toList(),
        text: message,
      );
    }
  }
}

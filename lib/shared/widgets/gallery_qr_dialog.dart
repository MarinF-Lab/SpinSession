import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../core/config/web_gallery_config.dart';

/// Diálogo con el código QR de la galería pública de un evento. Se usa tanto
/// desde la Galería (bajo demanda) como automáticamente al confirmarse el
/// pago del evento (ver EventDetailScreen).
void showGalleryQrDialog(BuildContext context, String eventId) {
  final galleryUrl = WebGalleryConfig.gallery(eventId);
  showDialog<void>(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text('Galería pública'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          QrImageView(data: galleryUrl, size: 200),
          const SizedBox(height: 12),
          Text(galleryUrl,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cerrar'),
        ),
      ],
    ),
  );
}

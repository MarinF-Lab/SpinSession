import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../core/config/web_gallery_config.dart';
import '../../../../shared/widgets/empty_state.dart';
import '../../../events/presentation/providers/event_providers.dart';
import '../../../sessions/presentation/providers/session_providers.dart';

class GalleryScreen extends ConsumerWidget {
  const GalleryScreen({super.key, required this.eventId});

  final String eventId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final event = ref.watch(eventByIdProvider(eventId));
    final sessionState = ref.watch(sessionControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(event?.name ?? 'Galería'),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_outlined),
            tooltip: 'Código QR',
            onPressed: () => _showQrDialog(context, eventId),
          ),
        ],
      ),
      body: sessionState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : sessionState.sessions.isEmpty
              ? const EmptyState(
                  icon: Icons.photo_library_outlined,
                  message: 'No hay sesiones en este evento todavía.',
                )
              : _SessionGrid(
                  sessions: sessionState.sessions,
                  eventId: eventId,
                ),
    );
  }

  void _showQrDialog(BuildContext context, String eventId) {
    final galleryUrl = WebGalleryConfig.gallery(eventId);
    showDialog(
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
}

class _SessionGrid extends ConsumerWidget {
  const _SessionGrid({required this.sessions, required this.eventId});

  final List sessions;
  final String eventId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.85,
      ),
      itemCount: sessions.length,
      itemBuilder: (context, i) {
        final session = sessions[i];
        return _SessionCard(
          session: session,
          onTap: () => context.push(AppRoutes.privateSession(session.id)),
        );
      },
    );
  }
}

class _SessionCard extends StatelessWidget {
  const _SessionCard({required this.session, required this.onTap});

  final dynamic session;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    // Ruta del thumbnail del primer take
    final thumbnailPath = _thumbnailPath(session.id);
    final thumbFile = File(thumbnailPath);

    return GestureDetector(
      onTap: onTap,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: thumbFile.existsSync()
                  ? Image.file(thumbFile, fit: BoxFit.cover)
                  : Container(
                      color: Theme.of(context)
                          .colorScheme
                          .surfaceContainerHighest,
                      child: const Icon(Icons.person_outline, size: 48),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    session.guestName,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    session.status.label,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _thumbnailPath(String sessionId) {
    // Ruta local del thumbnail — coincide con lo que genera FFmpegService
    return '/data/user/0/com.example.spinsession/app_flutter/processing/$sessionId/1/thumbnail.jpg';
  }
}

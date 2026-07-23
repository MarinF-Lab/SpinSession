import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../shared/widgets/video_preview_dialog.dart';
import '../../../processing/domain/entities/job_status.dart';
import '../../../processing/domain/entities/job_type.dart';
import '../../../processing/presentation/providers/processing_providers.dart';
import '../../domain/entities/session_entity.dart';
import '../../domain/entities/session_status.dart';
import '../providers/session_providers.dart';

/// Detalle de una sesión (invitado): sus videos, el estado del procesamiento
/// y la posibilidad de enviar/reenviar el enlace por WhatsApp.
class SessionDetailScreen extends ConsumerWidget {
  const SessionDetailScreen({super.key, required this.sessionId});

  final String sessionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionAsync = ref.watch(sessionByIdProvider(sessionId));

    return Scaffold(
      appBar: AppBar(title: const Text('Sesión')),
      body: sessionAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (session) {
          if (session == null) {
            return const Center(child: Text('Sesión no encontrada.'));
          }
          return _SessionDetailView(session: session);
        },
      ),
    );
  }
}

class _SessionDetailView extends ConsumerWidget {
  const _SessionDetailView({required this.session});

  final SessionEntity session;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobsAsync =
        ref.watch(processingJobsBySessionProvider(session.id));
    final theme = Theme.of(context);
    final sending = ref.watch(_sendingProvider);

    final failed = jobsAsync.maybeWhen(
      data: (jobs) =>
          jobs.where((j) => j.status == JobStatus.failed).toList(),
      orElse: () => const [],
    );
    final isSent = session.status == SessionStatus.sent;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor: theme.colorScheme.primaryContainer,
              child: Text(
                session.guestName.isNotEmpty
                    ? session.guestName[0].toUpperCase()
                    : '?',
                style: TextStyle(color: theme.colorScheme.onPrimaryContainer),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(session.guestName,
                      style: theme.textTheme.titleMedium),
                  const SizedBox(height: 2),
                  Text('${session.countryCode} ${session.phone}',
                      style: theme.textTheme.bodySmall),
                ],
              ),
            ),
            Chip(label: Text(session.status.label)),
          ],
        ),
        const SizedBox(height: 20),
        Text('Videos', style: theme.textTheme.titleSmall),
        const SizedBox(height: 8),
        jobsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Text('Error al cargar videos: $e'),
          data: (jobs) {
            final mediaJobs =
                jobs.where((j) => j.jobType.isMediaJob).toList();
            if (mediaJobs.isEmpty) {
              return const Text('Esta sesión no tiene videos.');
            }
            return Column(
              children: [
                for (final job in mediaJobs) _MediaTile(job: job),
              ],
            );
          },
        ),
        if (failed.isNotEmpty) ...[
          const SizedBox(height: 20),
          Text('Errores de procesamiento',
              style: theme.textTheme.titleSmall
                  ?.copyWith(color: theme.colorScheme.error)),
          const SizedBox(height: 8),
          for (final j in failed)
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading:
                  Icon(Icons.error_outline, color: theme.colorScheme.error),
              title: Text(j.jobType.label),
              subtitle: Text(j.errorMessage ?? 'Falló tras varios intentos'),
            ),
        ],
        const SizedBox(height: 28),
        FilledButton.icon(
          onPressed: sending
              ? null
              : () => _send(context, ref),
          icon: sending
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.chat_outlined),
          label: Text(isSent
              ? 'Reenviar por WhatsApp'
              : 'Enviar por WhatsApp'),
        ),
      ],
    );
  }

  Future<void> _send(BuildContext context, WidgetRef ref) async {
    ref.read(_sendingProvider.notifier).state = true;
    final ok = await ref
        .read(sessionControllerProvider.notifier)
        .sendWhatsappForSession(session);
    ref.read(_sendingProvider.notifier).state = false;
    if (!context.mounted) return;
    if (!ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se pudo abrir WhatsApp.')),
      );
    }
  }
}

/// Estado efímero del botón de envío (solo esta pantalla).
final _sendingProvider = StateProvider.autoDispose<bool>((ref) => false);

/// Fila de un archivo procesado (miniatura real + reproducir + compartir).
/// Portado de la antigua PrivateSessionScreen (galería del invitado, ya
/// eliminada) — esta es la vista del operador en el Registro.
class _MediaTile extends StatelessWidget {
  const _MediaTile({required this.job});

  final dynamic job;

  String? _localPath() {
    if (job.jobType == JobType.generateBurst) {
      return job.payload['outputDir'] as String?;
    }
    return job.payload['outputPath'] as String?;
  }

  @override
  Widget build(BuildContext context) {
    final localPath = _localPath();
    final exists = localPath != null && File(localPath).existsSync();
    final isThumbnail = job.jobType == JobType.generateThumbnail;

    return Card(
      child: ListTile(
        onTap: exists && !isThumbnail
            ? () => showVideoPreviewDialog(context, localPath)
            : null,
        leading: _LeadingWidget(job: job, localPath: localPath),
        title: Text(job.jobType.label),
        subtitle: Text(
          exists ? 'Disponible localmente' : 'Procesando...',
          style: TextStyle(
            color: exists
                ? Colors.green
                : Theme.of(context).colorScheme.outline,
          ),
        ),
        trailing: exists
            ? IconButton(
                icon: const Icon(Icons.share_outlined),
                onPressed: () => _shareFile(localPath),
              )
            : job.status == JobStatus.running
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : null,
      ),
    );
  }

  Future<void> _shareFile(String? path) async {
    if (path == null) return;
    await Share.shareXFiles([XFile(path)]);
  }
}

class _LeadingWidget extends StatelessWidget {
  const _LeadingWidget({required this.job, required this.localPath});

  final dynamic job;
  final String? localPath;

  @override
  Widget build(BuildContext context) {
    if (job.jobType == JobType.generateThumbnail &&
        localPath != null &&
        File(localPath!).existsSync()) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Image.file(
          File(localPath!),
          width: 48,
          height: 48,
          fit: BoxFit.cover,
        ),
      );
    }

    final icon = switch (job.jobType) {
      JobType.generateThumbnail => Icons.image_outlined,
      JobType.generateSlowMotion => Icons.slow_motion_video_outlined,
      JobType.generateReverse => Icons.replay_outlined,
      JobType.generateBoomerang => Icons.loop_outlined,
      JobType.generateBurst => Icons.burst_mode_outlined,
      _ => Icons.video_file_outlined,
    };

    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Icon(icon, size: 24),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../app/router/app_routes.dart';
import '../../../../../shared/widgets/primary_button.dart';
import '../../../../../shared/widgets/secondary_button.dart';
import '../../../../../shared/widgets/video_preview_dialog.dart';
import '../../../recording/presentation/providers/recording_providers.dart';
import '../providers/session_providers.dart';

class ConfirmationScreen extends ConsumerWidget {
  const ConfirmationScreen({
    super.key,
    required this.eventId,
    required this.sessionId,
  });

  final String eventId;
  final String sessionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recordingState = ref.watch(recordingControllerProvider);
    final recordingNotifier = ref.read(recordingControllerProvider.notifier);
    final sessionNotifier = ref.read(sessionControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Grabando')),
      body: Column(
        children: [
          if (recordingState.takes.isNotEmpty)
            _TakesPreviewRow(takes: recordingState.takes),
          Expanded(
            child: _TakesList(
              takes: recordingState.takes,
              onDelete: recordingNotifier.deleteTake,
            ),
          ),
          _ActionPanel(
            takeCount: recordingState.takeCount,
            canAddTake: recordingState.canAddTake,
            onConfirm: () => _onAccept(
              context,
              sessionNotifier,
              recordingNotifier,
            ),
            onAddTake: () {
              recordingNotifier.prepareNewTake();
              context.push(
                AppRoutes.studioRecording(eventId, sessionId),
              );
            },
            onRetry: () async {
              await recordingNotifier.clearAllTakes();
              if (context.mounted) {
                context.push(
                  AppRoutes.studioRecording(eventId, sessionId),
                );
              }
            },
            onCancel: () async {
              await recordingNotifier.clearAllTakes();
              await sessionNotifier.cancelSession(sessionId, eventId);
              if (context.mounted) context.go(AppRoutes.studio(eventId));
            },
          ),
        ],
      ),
    );
  }

  /// Pregunta cómo continuar tras aceptar las tomas: esperar el procesamiento
  /// y enviar el WhatsApp al terminar, o dejarlo procesando en segundo plano
  /// (se podrá enviar luego desde el Registro).
  Future<void> _onAccept(
    BuildContext context,
    SessionController sessionNotifier,
    RecordingController recordingNotifier,
  ) async {
    final waitAndSend = await showModalBottomSheet<bool>(
      context: context,
      showDragHandle: true,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 12),
              child: Text('¿Cómo continuar?',
                  style: Theme.of(ctx).textTheme.titleMedium),
            ),
            ListTile(
              leading: const Icon(Icons.hourglass_bottom_outlined),
              title: const Text('Esperar y enviar por WhatsApp'),
              subtitle: const Text(
                  'Se procesa ahora y al terminar se abre el chat del invitado.'),
              onTap: () => Navigator.of(ctx).pop(true),
            ),
            ListTile(
              leading: const Icon(Icons.cloud_sync_outlined),
              title: const Text('Procesar en segundo plano'),
              subtitle: const Text(
                  'Sigues registrando invitados; podrás enviar luego desde el Registro.'),
              onTap: () => Navigator.of(ctx).pop(false),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
    if (waitAndSend == null || !context.mounted) return;

    await sessionNotifier.confirmSession(sessionId, eventId);
    recordingNotifier.prepareNewTake();
    if (!context.mounted) return;

    if (waitAndSend) {
      context.go(AppRoutes.processing(sessionId), extra: true);
    } else {
      context.go(AppRoutes.studio(eventId));
    }
  }
}

class _TakesPreviewRow extends StatelessWidget {
  const _TakesPreviewRow({required this.takes});

  final List<String> takes;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Vista previa', style: theme.textTheme.titleSmall),
          const SizedBox(height: 8),
          SizedBox(
            height: 64,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: takes.length,
              separatorBuilder: (_, _) => const SizedBox(width: 8),
              itemBuilder: (_, i) => GestureDetector(
                onTap: () => showVideoPreviewDialog(context, takes[i]),
                child: Container(
                  width: 64,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.play_circle_outline),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TakesList extends StatelessWidget {
  const _TakesList({required this.takes, required this.onDelete});

  final List<String> takes;
  final void Function(int) onDelete;

  @override
  Widget build(BuildContext context) {
    if (takes.isEmpty) {
      return const Center(child: Text('Sin tomas registradas.'));
    }
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: takes.length,
      itemBuilder: (_, i) => ListTile(
        leading: const Icon(Icons.videocam_outlined),
        title: Text('Toma ${i + 1}'),
        subtitle: Text(
          takes[i].split('/').last,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline),
          onPressed: () => onDelete(i),
        ),
      ),
    );
  }
}

class _ActionPanel extends StatelessWidget {
  const _ActionPanel({
    required this.takeCount,
    required this.canAddTake,
    required this.onConfirm,
    required this.onAddTake,
    required this.onRetry,
    required this.onCancel,
  });

  final int takeCount;
  final bool canAddTake;
  final VoidCallback onConfirm;
  final VoidCallback onAddTake;
  final VoidCallback onRetry;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: onRetry,
                  child: const Text('REPETIR'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: PrimaryButton(
                  label: 'ACEPTAR',
                  onPressed: takeCount > 0 ? onConfirm : null,
                ),
              ),
            ],
          ),
          if (canAddTake) ...[
            const SizedBox(height: 8),
            SecondaryButton(
              label: 'Agregar otra toma',
              onPressed: onAddTake,
            ),
          ],
          const SizedBox(height: 8),
          TextButton(
            onPressed: onCancel,
            child: Text(
              'Cancelar sesión',
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

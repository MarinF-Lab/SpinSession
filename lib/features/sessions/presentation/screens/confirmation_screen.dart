import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../app/router/app_routes.dart';
import '../../../../../shared/widgets/primary_button.dart';
import '../../../../../shared/widgets/secondary_button.dart';
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
            _TakesPreviewRow(count: recordingState.takes.length),
          Expanded(
            child: _TakesList(
              takes: recordingState.takes,
              onDelete: recordingNotifier.deleteTake,
            ),
          ),
          _ActionPanel(
            takeCount: recordingState.takeCount,
            onConfirm: () => _confirm(
              context,
              ref,
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

  Future<void> _confirm(
    BuildContext context,
    WidgetRef ref,
    SessionController sessionNotifier,
    RecordingController recordingNotifier,
  ) async {
    await sessionNotifier.confirmSession(sessionId, eventId);
    recordingNotifier.prepareNewTake();
    if (context.mounted) {
      context.go(AppRoutes.processing(sessionId));
    }
  }
}

class _TakesPreviewRow extends StatelessWidget {
  const _TakesPreviewRow({required this.count});

  final int count;

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
              itemCount: count,
              separatorBuilder: (_, _) => const SizedBox(width: 8),
              itemBuilder: (_, i) => Container(
                width: 64,
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.videocam_outlined),
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
    required this.onConfirm,
    required this.onAddTake,
    required this.onRetry,
    required this.onCancel,
  });

  final int takeCount;
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
          const SizedBox(height: 8),
          SecondaryButton(
            label: 'Agregar otra toma',
            onPressed: onAddTake,
          ),
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

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../../app/router/app_routes.dart';
import '../../../../../shared/widgets/confirmation_dialog.dart';
import '../../../../../shared/widgets/loading_screen.dart';
import '../../../../../shared/widgets/status_chip.dart';
import '../../domain/entities/event_entity.dart';
import '../../domain/entities/event_status.dart';
import '../providers/event_providers.dart';

class EventDetailScreen extends ConsumerWidget {
  const EventDetailScreen({super.key, required this.eventId});

  final String eventId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventAsync = ref.watch(eventByIdProvider(eventId));

    return eventAsync.when(
      loading: () => const LoadingScreen(),
      error: (e, _) => Scaffold(
        appBar: AppBar(),
        body: Center(child: Text(e.toString())),
      ),
      data: (event) {
        if (event == null) {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(child: Text('Evento no encontrado')),
          );
        }
        return _EventDetailView(event: event);
      },
    );
  }
}

class _EventDetailView extends ConsumerWidget {
  const _EventDetailView({required this.event});

  final EventEntity event;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateFormat = DateFormat('EEEE d MMMM yyyy', 'es');
    final timeFormat = DateFormat('HH:mm');

    return Scaffold(
      appBar: AppBar(
        title: Text(event.name, maxLines: 1, overflow: TextOverflow.ellipsis),
        actions: [
          if (event.eventStatus.canEdit)
            IconButton(
              icon: const Icon(Icons.edit_outlined),
              tooltip: 'Editar',
              onPressed: () =>
                  context.push(AppRoutes.eventEdit(event.id)),
            ),
          PopupMenuButton<_Action>(
            onSelected: (action) => _handleAction(context, ref, action),
            itemBuilder: (_) => [
              if (event.paymentStatus == PaymentStatus.pending)
                const PopupMenuItem(
                  value: _Action.registerPayment,
                  child: Text('Registrar pago'),
                ),
              if (event.paymentStatus == PaymentStatus.paid)
                const PopupMenuItem(
                  value: _Action.cancelPayment,
                  child: Text('Cancelar pago'),
                ),
              if (event.eventStatus.canDelete)
                const PopupMenuItem(
                  value: _Action.archive,
                  child: Text('Archivar'),
                ),
              if (event.eventStatus.canDelete)
                const PopupMenuItem(
                  value: _Action.delete,
                  child: Text('Eliminar',
                      style: TextStyle(color: Colors.red)),
                ),
            ],
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _InfoRow(
            icon: Icons.calendar_today_outlined,
            label: 'Fecha',
            value: _capitalize(dateFormat.format(event.eventDate)),
          ),
          const Divider(),
          _InfoRow(
            icon: Icons.access_time_outlined,
            label: 'Horario',
            value:
                '${timeFormat.format(event.startDatetime)} – ${timeFormat.format(event.endDatetime)}',
          ),
          const Divider(),
          _InfoRow(
            icon: Icons.timelapse_outlined,
            label: 'Duración',
            value: _formatDuration(event.duration),
          ),
          const Divider(),
          Row(
            children: [
              const Icon(Icons.info_outline, size: 20),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Estado',
                      style: Theme.of(context).textTheme.labelSmall),
                  const SizedBox(height: 4),
                  StatusChip(status: event.eventStatus),
                ],
              ),
            ],
          ),
          if (event.notes != null && event.notes!.isNotEmpty) ...[
            const Divider(),
            _InfoRow(
              icon: Icons.notes_outlined,
              label: 'Notas',
              value: event.notes!,
            ),
          ],
        ],
      ),
      floatingActionButton: event.eventStatus.canRecord
          ? FloatingActionButton.extended(
              onPressed: () => context.push(AppRoutes.studio(event.id)),
              icon: const Icon(Icons.videocam_outlined),
              label: const Text('Abrir estudio'),
            )
          : null,
    );
  }

  Future<void> _handleAction(
      BuildContext context, WidgetRef ref, _Action action) async {
    final controller = ref.read(eventControllerProvider.notifier);
    switch (action) {
      case _Action.registerPayment:
        await controller.registerPayment(event.id);
      case _Action.cancelPayment:
        await controller.cancelPayment(event.id);
      case _Action.archive:
        await controller.archiveEvent(event.id);
        if (context.mounted) context.pop();
      case _Action.delete:
        final confirmed = await showConfirmationDialog(
          context,
          title: 'Eliminar evento',
          message:
              '¿Eliminar "${event.name}"? Esta acción no se puede deshacer.',
          confirmLabel: 'Eliminar',
          isDestructive: true,
        );
        if (confirmed && context.mounted) {
          await controller.deleteEvent(event.id);
          if (context.mounted) context.pop();
        }
    }
  }

  String _formatDuration(Duration d) {
    final h = d.inHours;
    final m = d.inMinutes.remainder(60);
    if (m == 0) return '${h}h';
    return '${h}h ${m}min';
  }

  String _capitalize(String s) =>
      s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);
}

enum _Action { registerPayment, cancelPayment, archive, delete }

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Theme.of(context).colorScheme.outline,
                      )),
              const SizedBox(height: 2),
              Text(value, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ],
      ),
    );
  }
}

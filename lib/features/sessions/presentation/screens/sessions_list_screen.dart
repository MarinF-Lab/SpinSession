import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../../shared/widgets/empty_state.dart';
import '../../domain/entities/session_entity.dart';
import '../../domain/entities/session_status.dart';
import '../providers/session_providers.dart';

class SessionsListScreen extends ConsumerWidget {
  const SessionsListScreen({super.key, required this.eventId});

  final String eventId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(sessionControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Registro de sesiones')),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.sessions.isEmpty
              ? const EmptyState(
                  icon: Icons.people_outline,
                  message: 'Aún no hay sesiones registradas',
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: state.sessions.length,
                  itemBuilder: (_, i) =>
                      _SessionTile(session: state.sessions[i]),
                ),
    );
  }
}

// Reusable body widget used by StudioScreen as well.
class SessionsListBody extends StatelessWidget {
  const SessionsListBody({
    super.key,
    required this.sessions,
    required this.eventId,
  });

  final List<SessionEntity> sessions;
  final String eventId;

  @override
  Widget build(BuildContext context) {
    if (sessions.isEmpty) {
      return const EmptyState(
        icon: Icons.people_outline,
        message: 'Sin sesiones. Toca "Nueva sesión" para comenzar.',
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: sessions.length,
      itemBuilder: (_, i) => _SessionTile(session: sessions[i]),
    );
  }
}

class _SessionTile extends ConsumerWidget {
  const _SessionTile({required this.session});

  final SessionEntity session;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final assetsAsync =
        ref.watch(sessionAssetsBySessionProvider(session.id));
    final takeCount =
        assetsAsync.whenOrNull(data: (list) => list.length) ?? 0;
    final timeLabel =
        DateFormat('HH:mm').format(session.createdAt);

    return ListTile(
      leading: CircleAvatar(
        child: Text(
          session.guestName.isNotEmpty
              ? session.guestName[0].toUpperCase()
              : '?',
        ),
      ),
      title: Text(session.guestName),
      subtitle: Text('${session.countryCode} ${session.phone}'),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _StatusBadge(status: session.status),
          const SizedBox(height: 2),
          Text(
            '$takeCount toma${takeCount != 1 ? 's' : ''} · $timeLabel',
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});

  final SessionStatus status;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final (label, color) = switch (status) {
      SessionStatus.registered => ('Registrada', cs.secondaryContainer),
      SessionStatus.recording => ('Grabando', cs.errorContainer),
      SessionStatus.pendingConfirmation => ('Pendiente', cs.tertiaryContainer),
      SessionStatus.confirmed => ('Confirmada', cs.primaryContainer),
      SessionStatus.pendingProcessing => ('En proceso', cs.primaryContainer),
      SessionStatus.pendingSync => ('Pendiente sync', cs.secondaryContainer),
      SessionStatus.syncing => ('Sincronizando', cs.primaryContainer),
      SessionStatus.synced => ('Sincronizada', cs.primaryContainer),
      SessionStatus.sent => ('Enviada', cs.primaryContainer),
      SessionStatus.completed => ('Completada', cs.primaryContainer),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(label, style: Theme.of(context).textTheme.labelSmall),
    );
  }
}

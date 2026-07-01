import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../shared/widgets/app_bottom_nav.dart';
import '../../../../shared/widgets/empty_state.dart';
import '../../../events/presentation/providers/event_providers.dart';
import '../../domain/entities/session_entity.dart';
import '../../domain/entities/session_status.dart';
import '../providers/session_providers.dart';

enum _Filter { todos, pendientes, enviadas }

/// Pestaña "Registro" — muestra las sesiones/invitados del evento activo.
class RegistroTabScreen extends ConsumerStatefulWidget {
  const RegistroTabScreen({super.key});

  @override
  ConsumerState<RegistroTabScreen> createState() => _RegistroTabScreenState();
}

class _RegistroTabScreenState extends ConsumerState<RegistroTabScreen> {
  String? _loadedEventId;
  _Filter _filter = _Filter.todos;

  @override
  Widget build(BuildContext context) {
    final activeEvent = ref.watch(activeEventProvider);

    if (activeEvent != null && _loadedEventId != activeEvent.id) {
      _loadedEventId = activeEvent.id;
      Future.microtask(() =>
          ref.read(sessionControllerProvider.notifier).loadByEvent(activeEvent.id));
    }

    if (activeEvent == null) {
      return Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.menu_outlined),
          title: const Text('Registro'),
        ),
        body: const EmptyState(
          icon: Icons.group_off_outlined,
          message: 'No hay ningún evento activo en este momento.',
        ),
        bottomNavigationBar: const AppBottomNav(current: AppTab.registro),
      );
    }

    final sessionState = ref.watch(sessionControllerProvider);
    final sessions = sessionState.sessions;
    final pendientes =
        sessions.where((s) => s.status != SessionStatus.sent && s.status != SessionStatus.completed).length;
    final enviadas = sessions
        .where((s) => s.status == SessionStatus.sent || s.status == SessionStatus.completed)
        .length;

    final filtered = switch (_filter) {
      _Filter.todos => sessions,
      _Filter.pendientes => sessions
          .where((s) => s.status != SessionStatus.sent && s.status != SessionStatus.completed)
          .toList(),
      _Filter.enviadas => sessions
          .where((s) => s.status == SessionStatus.sent || s.status == SessionStatus.completed)
          .toList(),
    };

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu_outlined),
        title: const Text('Registro'),
        actions: [
          IconButton(icon: const Icon(Icons.search_outlined), onPressed: () {}),
          IconButton(
              icon: const Icon(Icons.filter_list_outlined), onPressed: () {}),
        ],
      ),
      body: sessionState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
                  child: Row(
                    children: [
                      _FilterChip(
                        label: 'Todos ${sessions.length}',
                        selected: _filter == _Filter.todos,
                        onTap: () => setState(() => _filter = _Filter.todos),
                      ),
                      const SizedBox(width: 8),
                      _FilterChip(
                        label: 'Pendientes $pendientes',
                        selected: _filter == _Filter.pendientes,
                        onTap: () =>
                            setState(() => _filter = _Filter.pendientes),
                      ),
                      const SizedBox(width: 8),
                      _FilterChip(
                        label: 'Enviadas $enviadas',
                        selected: _filter == _Filter.enviadas,
                        onTap: () =>
                            setState(() => _filter = _Filter.enviadas),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: filtered.isEmpty
                      ? const EmptyState(
                          icon: Icons.group_outlined,
                          message: 'No hay sesiones en este filtro.',
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          itemCount: filtered.length,
                          itemBuilder: (_, i) =>
                              _GuestTile(session: filtered[i]),
                        ),
                ),
              ],
            ),
      bottomNavigationBar: const AppBottomNav(current: AppTab.registro),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? cs.primary : cs.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? cs.onPrimary : cs.onSurface,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}

class _GuestTile extends ConsumerWidget {
  const _GuestTile({required this.session});

  final SessionEntity session;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final assetsAsync = ref.watch(sessionAssetsBySessionProvider(session.id));
    final theme = Theme.of(context);
    final timeFormat = DateFormat('HH:mm');
    final initial =
        session.guestName.isNotEmpty ? session.guestName[0].toUpperCase() : '?';

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: theme.colorScheme.primaryContainer,
        child: Text(initial,
            style: TextStyle(color: theme.colorScheme.onPrimaryContainer)),
      ),
      title: Text(session.guestName, style: theme.textTheme.titleSmall),
      subtitle: assetsAsync.when(
        data: (assets) => Text(
          '${timeFormat.format(session.createdAt)} · ${assets.length} video${assets.length != 1 ? 's' : ''}',
          style: theme.textTheme.bodySmall,
        ),
        loading: () => Text(timeFormat.format(session.createdAt),
            style: theme.textTheme.bodySmall),
        error: (_, _) => Text(timeFormat.format(session.createdAt),
            style: theme.textTheme.bodySmall),
      ),
      trailing: _StatusIcon(status: session.status),
    );
  }
}

class _StatusIcon extends StatelessWidget {
  const _StatusIcon({required this.status});

  final SessionStatus status;

  @override
  Widget build(BuildContext context) {
    return switch (status) {
      SessionStatus.sent || SessionStatus.completed => const Icon(
          Icons.check_circle,
          color: Colors.green,
        ),
      SessionStatus.pendingSync ||
      SessionStatus.syncing =>
        const Icon(Icons.cloud_upload_outlined, color: Colors.orange),
      SessionStatus.synced =>
        const Icon(Icons.cloud_done_outlined, color: Colors.blue),
      _ => Icon(Icons.schedule_outlined,
          color: Theme.of(context).colorScheme.outline),
    };
  }
}

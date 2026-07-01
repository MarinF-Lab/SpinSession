import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/widgets/app_bottom_nav.dart';
import '../../../../shared/widgets/empty_state.dart';
import '../../../events/presentation/providers/event_providers.dart';
import '../providers/session_providers.dart';
import 'sessions_list_screen.dart';

/// Pestaña "Registro" — muestra las sesiones/invitados del evento activo.
class RegistroTabScreen extends ConsumerStatefulWidget {
  const RegistroTabScreen({super.key});

  @override
  ConsumerState<RegistroTabScreen> createState() => _RegistroTabScreenState();
}

class _RegistroTabScreenState extends ConsumerState<RegistroTabScreen> {
  String? _loadedEventId;

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
        appBar: AppBar(title: const Text('Registro')),
        body: const EmptyState(
          icon: Icons.group_off_outlined,
          message: 'No hay ningún evento activo en este momento.',
        ),
        bottomNavigationBar: const AppBottomNav(current: AppTab.registro),
      );
    }

    final sessionState = ref.watch(sessionControllerProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Registro — ${activeEvent.name}')),
      body: sessionState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SessionsListBody(
              sessions: sessionState.sessions,
              eventId: activeEvent.id,
            ),
      bottomNavigationBar: const AppBottomNav(current: AppTab.registro),
    );
  }
}

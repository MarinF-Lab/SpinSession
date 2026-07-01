import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../shared/widgets/app_bottom_nav.dart';
import '../../../../shared/widgets/empty_state.dart';
import '../../../device_selection/domain/entities/device_mode.dart';
import '../../../device_selection/presentation/providers/device_mode_provider.dart';
import '../../../events/presentation/providers/event_providers.dart';
import '../providers/session_providers.dart';
import 'sessions_list_screen.dart';

/// Pestaña "Estudio" — muestra el evento activo del usuario (si existe)
/// y permite iniciar sesiones de grabación sin tener que navegar
/// manualmente desde el calendario.
class EstudioTabScreen extends ConsumerStatefulWidget {
  const EstudioTabScreen({super.key});

  @override
  ConsumerState<EstudioTabScreen> createState() => _EstudioTabScreenState();
}

class _EstudioTabScreenState extends ConsumerState<EstudioTabScreen> {
  String? _loadedEventId;

  @override
  Widget build(BuildContext context) {
    final activeEvent = ref.watch(activeEventProvider);

    if (activeEvent != null && _loadedEventId != activeEvent.id) {
      _loadedEventId = activeEvent.id;
      Future.microtask(() =>
          ref.read(sessionControllerProvider.notifier).loadByEvent(activeEvent.id));
    }
    final deviceMode = ref.watch(deviceModeControllerProvider).mode;

    if (activeEvent == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Estudio')),
        body: const EmptyState(
          icon: Icons.videocam_off_outlined,
          message: 'No hay ningún evento activo en este momento.',
        ),
        bottomNavigationBar: const AppBottomNav(current: AppTab.estudio),
      );
    }

    final sessionState = ref.watch(sessionControllerProvider);
    final canOperate =
        deviceMode == DeviceMode.operator || deviceMode == DeviceMode.both;

    return Scaffold(
      appBar: AppBar(title: Text(activeEvent.name)),
      body: sessionState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SessionsListBody(
              sessions: sessionState.sessions,
              eventId: activeEvent.id,
            ),
      floatingActionButton: canOperate
          ? FloatingActionButton.extended(
              onPressed: () =>
                  context.push(AppRoutes.studioGuest(activeEvent.id)),
              icon: const Icon(Icons.person_add_outlined),
              label: const Text('Nueva sesión'),
            )
          : FloatingActionButton.extended(
              onPressed: () => context.push(
                  AppRoutes.studioRecording(activeEvent.id, 'spinlab')),
              icon: const Icon(Icons.videocam_outlined),
              label: const Text('Iniciar grabación'),
            ),
      bottomNavigationBar: const AppBottomNav(current: AppTab.estudio),
    );
  }
}

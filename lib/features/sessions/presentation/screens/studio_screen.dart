import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../app/router/app_routes.dart';
import '../../../../../shared/widgets/empty_state.dart';
import '../../../../../shared/widgets/error_screen.dart';
import '../../../../../shared/widgets/loading_screen.dart';
import '../../../device_selection/domain/entities/device_mode.dart';
import '../../../device_selection/presentation/providers/device_mode_provider.dart';
import '../../../events/domain/entities/event_entity.dart';
import '../../../events/domain/entities/event_status.dart';
import '../../../events/presentation/providers/event_providers.dart';
import '../providers/session_providers.dart';
import 'sessions_list_screen.dart';

class StudioScreen extends ConsumerStatefulWidget {
  const StudioScreen({super.key, required this.eventId});

  final String eventId;

  @override
  ConsumerState<StudioScreen> createState() => _StudioScreenState();
}

class _StudioScreenState extends ConsumerState<StudioScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(sessionControllerProvider.notifier).loadByEvent(widget.eventId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final eventAsync = ref.watch(eventByIdProvider(widget.eventId));
    final deviceMode = ref.watch(deviceModeControllerProvider).mode;

    return eventAsync.when(
      loading: () => const LoadingScreen(),
      error: (e, _) => ErrorScreen(message: e.toString()),
      data: (event) {
        if (event == null) {
          return const ErrorScreen(message: 'Evento no encontrado.');
        }

        final accessError = _checkAccess(event);
        if (accessError != null) {
          return _AccessDeniedView(
            eventName: event.name,
            reason: accessError,
          );
        }

        return _StudioView(
          event: event,
          deviceMode: deviceMode ?? DeviceMode.both,
        );
      },
    );
  }

  String? _checkAccess(EventEntity event) {
    if (event.eventStatus != EventStatus.active) {
      return 'El evento debe estar activo para abrir el estudio. '
          'Estado actual: ${event.eventStatus.label}.';
    }
    if (event.paymentStatus != PaymentStatus.paid) {
      return 'El evento debe estar pagado para abrir el estudio.';
    }
    final now = DateTime.now();
    if (now.isBefore(event.startDatetime)) {
      return 'El estudio abrirá a las '
          '${_formatTime(event.startDatetime)}.';
    }
    if (now.isAfter(event.endDatetime)) {
      return 'El horario del evento ha finalizado.';
    }
    return null;
  }

  String _formatTime(DateTime dt) =>
      '${dt.hour.toString().padLeft(2, '0')}:'
      '${dt.minute.toString().padLeft(2, '0')}';
}

class _AccessDeniedView extends StatelessWidget {
  const _AccessDeniedView({
    required this.eventName,
    required this.reason,
  });

  final String eventName;
  final String reason;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(eventName)),
      body: EmptyState(
        icon: Icons.lock_outline,
        message: reason,
      ),
    );
  }
}

class _StudioView extends ConsumerWidget {
  const _StudioView({required this.event, required this.deviceMode});

  final EventEntity event;
  final DeviceMode deviceMode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionState = ref.watch(sessionControllerProvider);
    final canOperate =
        deviceMode == DeviceMode.operator || deviceMode == DeviceMode.both;

    return Scaffold(
      appBar: AppBar(
        title: Text(event.name),
        actions: [
          if (canOperate)
            IconButton(
              icon: const Icon(Icons.settings_outlined),
              tooltip: 'Configuración',
              onPressed: () =>
                  context.push(AppRoutes.studioConfig(event.id)),
            ),
          IconButton(
            icon: const Icon(Icons.list_alt_outlined),
            tooltip: 'Registro de sesiones',
            onPressed: () =>
                context.push(AppRoutes.studioSessions(event.id)),
          ),
        ],
      ),
      body: sessionState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SessionsListBody(
              sessions: sessionState.sessions,
              eventId: event.id,
            ),
      floatingActionButton: canOperate
          ? FloatingActionButton.extended(
              onPressed: () =>
                  context.push(AppRoutes.studioGuest(event.id)),
              icon: const Icon(Icons.person_add_outlined),
              label: const Text('Nueva sesión'),
            )
          : FloatingActionButton.extended(
              onPressed: () =>
                  context.push(AppRoutes.studioRecording(event.id, 'spinlab')),
              icon: const Icon(Icons.videocam_outlined),
              label: const Text('Iniciar grabación'),
            ),
    );
  }
}

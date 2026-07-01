import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../shared/widgets/app_bottom_nav.dart';
import '../../../../shared/widgets/empty_state.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../../../events/presentation/providers/event_providers.dart';
import '../../../recording/domain/entities/recording_config_entity.dart';
import '../../../recording/presentation/providers/recording_providers.dart';
import '../providers/session_providers.dart';

/// Pestaña "Estudio" — muestra el evento activo del usuario (si existe)
/// y permite registrar un invitado e iniciar grabación directamente,
/// sin tener que navegar manualmente desde el calendario.
class EstudioTabScreen extends ConsumerStatefulWidget {
  const EstudioTabScreen({super.key});

  @override
  ConsumerState<EstudioTabScreen> createState() => _EstudioTabScreenState();
}

class _EstudioTabScreenState extends ConsumerState<EstudioTabScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  bool _submitting = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  Future<void> _startRecording(String eventId) async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _submitting = true);

    final session = await ref.read(sessionControllerProvider.notifier).createSession(
          eventId: eventId,
          guestName: _nameCtrl.text.trim(),
          phone: _phoneCtrl.text.trim(),
          countryCode: '+56',
        );

    if (!mounted) return;
    setState(() => _submitting = false);

    if (session != null) {
      _nameCtrl.clear();
      _phoneCtrl.clear();
      context.push(AppRoutes.studioRecording(eventId, session.id));
    } else {
      final error = ref.read(sessionControllerProvider).errorMessage;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error ?? 'Error al registrar invitado')),
      );
      ref.read(sessionControllerProvider.notifier).clearError();
    }
  }

  @override
  Widget build(BuildContext context) {
    final activeEvent = ref.watch(activeEventProvider);

    if (activeEvent == null) {
      return Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.menu_outlined),
          title: const Text('Estudio'),
          actions: const [
            IconButton(icon: Icon(Icons.notifications_outlined), onPressed: null),
          ],
        ),
        body: const EmptyState(
          icon: Icons.videocam_off_outlined,
          message: 'No hay ningún evento activo en este momento.',
        ),
        bottomNavigationBar: const AppBottomNav(current: AppTab.estudio),
      );
    }

    final configAsync = ref.watch(recordingConfigProvider(activeEvent.id));
    final timeFormat = DateFormat('HH:mm');

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu_outlined),
        title: const Text('Estudio'),
        actions: const [
          IconButton(icon: Icon(Icons.notifications_outlined), onPressed: null),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _ActiveEventCard(
              name: activeEvent.name,
              timeRange:
                  '${timeFormat.format(activeEvent.startDatetime)} – ${timeFormat.format(activeEvent.endDatetime)}',
            ),
            const SizedBox(height: 24),
            Text('Nueva sesión',
                style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 12),
            TextFormField(
              controller: _nameCtrl,
              decoration:
                  const InputDecoration(labelText: 'Nombre del invitado'),
              textCapitalization: TextCapitalization.words,
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Campo requerido' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _phoneCtrl,
              decoration: const InputDecoration(labelText: 'Teléfono'),
              keyboardType: TextInputType.phone,
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Campo requerido';
                if (v.trim().length < 7) return 'Número inválido';
                return null;
              },
            ),
            const SizedBox(height: 24),
            Text('Configuración rápida',
                style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 12),
            configAsync.when(
              data: (config) => _QuickConfigRow(
                  config: config ?? RecordingConfigEntity(
                      id: '', eventId: activeEvent.id, updatedAt: DateTime.now())),
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (_, _) => const SizedBox.shrink(),
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              label: 'Iniciar grabación',
              icon: Icons.videocam_outlined,
              isLoading: _submitting,
              onPressed: () => _startRecording(activeEvent.id),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNav(current: AppTab.estudio),
    );
  }
}

class _ActiveEventCard extends StatelessWidget {
  const _ActiveEventCard({required this.name, required this.timeRange});

  final String name;
  final String timeRange;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cs.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Evento activo',
              style: TextStyle(
                  color: cs.onPrimary.withValues(alpha: 0.8), fontSize: 13)),
          const SizedBox(height: 6),
          Text(name,
              style: TextStyle(
                  color: cs.onPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          Text(timeRange, style: TextStyle(color: cs.onPrimary)),
        ],
      ),
    );
  }
}

class _QuickConfigRow extends StatelessWidget {
  const _QuickConfigRow({required this.config});

  final RecordingConfigEntity config;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _QuickConfigItem(
            icon: Icons.timer_outlined,
            label: 'Duración',
            value: '${config.durationSeconds} seg',
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _QuickConfigItem(
            icon: Icons.auto_awesome_outlined,
            label: 'Efectos activos',
            value: '${config.defaultEffects.length}',
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _QuickConfigItem(
            icon: Icons.layers_outlined,
            label: 'Tomas máx.',
            value: '${config.maxTakesPerSession} tomas',
          ),
        ),
      ],
    );
  }
}

class _QuickConfigItem extends StatelessWidget {
  const _QuickConfigItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Icon(icon, size: 20),
          const SizedBox(height: 6),
          Text(label,
              textAlign: TextAlign.center,
              style: theme.textTheme.labelSmall
                  ?.copyWith(color: theme.colorScheme.outline)),
          const SizedBox(height: 2),
          Text(value,
              textAlign: TextAlign.center,
              style: theme.textTheme.labelMedium
                  ?.copyWith(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

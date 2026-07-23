import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../shared/widgets/app_bottom_nav.dart';
import '../../../../shared/widgets/empty_state.dart';
import '../../../../shared/widgets/phone_input_field.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../../../events/presentation/providers/event_providers.dart';
import '../../../processing/domain/entities/job_type.dart';
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
  String _dialCode = '+56';
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

    final digits = _phoneCtrl.text.replaceAll(RegExp(r'\D'), '');
    final session = await ref.read(sessionControllerProvider.notifier).createSession(
          eventId: eventId,
          guestName: _nameCtrl.text.trim(),
          phone: digits,
          countryCode: _dialCode,
        );

    if (!mounted) return;
    setState(() => _submitting = false);

    if (session != null) {
      _nameCtrl.clear();
      _phoneCtrl.text = '9 ';
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
            PhoneInputField(
              controller: _phoneCtrl,
              onCountryChanged: (c) => _dialCode = c.dialCode,
            ),
            const SizedBox(height: 24),
            Text('Configuración rápida',
                style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 12),
            configAsync.when(
              data: (config) => _QuickConfigRow(
                eventId: activeEvent.id,
                config: config ??
                    RecordingConfigEntity(
                        id: '',
                        eventId: activeEvent.id,
                        updatedAt: DateTime.now()),
              ),
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

class _QuickConfigRow extends ConsumerWidget {
  const _QuickConfigRow({required this.config, required this.eventId});

  final RecordingConfigEntity config;
  final String eventId;

  /// Garantiza un id válido antes de persistir (una config nueva llega con id
  /// vacío y no debe compartir clave entre eventos distintos).
  RecordingConfigEntity _ensureId(RecordingConfigEntity c) {
    if (c.id.isNotEmpty) return c;
    return RecordingConfigEntity(
      id: const Uuid().v4(),
      eventId: c.eventId,
      durationSeconds: c.durationSeconds,
      resolution: c.resolution,
      cameraFacing: c.cameraFacing,
      quality: c.quality,
      defaultEffects: c.defaultEffects,
      maxTakesPerSession: c.maxTakesPerSession,
      countdownSeconds: c.countdownSeconds,
      updatedAt: DateTime.now(),
    );
  }

  Future<void> _save(
    WidgetRef ref,
    RecordingConfigEntity Function(RecordingConfigEntity) apply,
  ) async {
    final updated = apply(_ensureId(config));
    await ref.read(recordingConfigRepositoryProvider).save(updated);
    ref.invalidate(recordingConfigProvider(eventId));
  }

  Future<void> _pickFromList(
    BuildContext context,
    WidgetRef ref, {
    required String title,
    required List<int> options,
    required int current,
    required String Function(int) fmt,
    required RecordingConfigEntity Function(RecordingConfigEntity, int) apply,
  }) async {
    final selected = await showModalBottomSheet<int>(
      context: context,
      showDragHandle: true,
      builder: (_) => ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 12),
            child: Text(title,
                style: Theme.of(context).textTheme.titleSmall),
          ),
          for (final o in options)
            ListTile(
              title: Text(fmt(o)),
              trailing: o == current
                  ? Icon(Icons.check,
                      color: Theme.of(context).colorScheme.primary)
                  : null,
              onTap: () => Navigator.of(context).pop(o),
            ),
        ],
      ),
    );
    if (selected == null) return;
    await _save(ref, (c) => apply(c, selected));
  }

  /// Entrada manual de la duración (segundos). Recuerda el último valor
  /// guardado (viene precargado en el campo) y valida el rango 3–300 s.
  Future<void> _editDuration(BuildContext context, WidgetRef ref) async {
    final ctrl =
        TextEditingController(text: '${config.durationSeconds}');
    final seconds = await showDialog<int>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Duración de cada toma'),
        content: TextField(
          controller: ctrl,
          autofocus: true,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            suffixText: 'segundos',
            hintText: 'Ej. 30',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () {
              final v = int.tryParse(ctrl.text.trim());
              Navigator.of(ctx).pop(v);
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
    if (seconds == null) return;
    final clamped = seconds.clamp(3, 300);
    await _save(ref, (c) => c.copyWith(durationSeconds: clamped));
  }

  static const _availableEffects = [
    JobType.generateSlowMotion,
    JobType.generateReverse,
    JobType.generateBoomerang,
    JobType.generateBurst,
  ];

  /// Selector múltiple de efectos activos — a diferencia de _pickFromList
  /// (selección única, cierra al tocar), acá cada toque guarda de inmediato
  /// y la hoja queda abierta para seguir marcando/desmarcando.
  Future<void> _editEffects(BuildContext context, WidgetRef ref) async {
    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) => Consumer(
        builder: (context, sheetRef, _) {
          final current =
              sheetRef.watch(recordingConfigProvider(eventId)).valueOrNull ??
                  config;
          final active = current.defaultEffects.toSet();

          return ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 12),
                child: Text('Efectos activos',
                    style: Theme.of(context).textTheme.titleSmall),
              ),
              for (final effect in _availableEffects)
                CheckboxListTile(
                  title: Text(effect.label),
                  value: active.contains(effect.value),
                  onChanged: (checked) async {
                    final updated = Set<String>.from(active);
                    if (checked ?? false) {
                      updated.add(effect.value);
                    } else {
                      updated.remove(effect.value);
                    }
                    // Usa `current` (el valor recién leído del provider en
                    // este render del sheet), no el `config` del widget
                    // externo — ese queda desactualizado entre un toggle y
                    // el siguiente dentro de la misma apertura del sheet, y
                    // reusar `_ensureId` sobre él generaría un id nuevo (y
                    // una fila huérfana) en cada toque para un evento sin
                    // configuración previa.
                    final base = _ensureId(current);
                    await sheetRef
                        .read(recordingConfigRepositoryProvider)
                        .save(base.copyWith(defaultEffects: updated.toList()));
                    sheetRef.invalidate(recordingConfigProvider(eventId));
                  },
                ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Expanded(
          child: _QuickConfigItem(
            icon: Icons.timer_outlined,
            label: 'Duración',
            value: '${config.durationSeconds} seg',
            onTap: () => _editDuration(context, ref),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _QuickConfigItem(
            icon: Icons.auto_awesome_outlined,
            label: 'Efectos activos',
            value: '${config.defaultEffects.length}',
            onTap: () => _editEffects(context, ref),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _QuickConfigItem(
            icon: Icons.layers_outlined,
            label: 'Tomas máx.',
            value: '${config.maxTakesPerSession} tomas',
            onTap: () => _pickFromList(
              context,
              ref,
              title: 'Tomas máximas por sesión',
              options: const [1, 2, 3, 4, 5],
              current: config.maxTakesPerSession,
              fmt: (o) => '$o toma${o != 1 ? 's' : ''}',
              apply: (c, o) => c.copyWith(maxTakesPerSession: o),
            ),
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
    this.onTap,
  });

  final IconData icon;
  final String label;
  final String value;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
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
            if (onTap != null) ...[
              const SizedBox(height: 4),
              Icon(Icons.edit_outlined,
                  size: 13, color: theme.colorScheme.outline),
            ],
          ],
        ),
      ),
    );
  }
}

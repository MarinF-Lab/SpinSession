import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../app/router/app_routes.dart';
import '../../../../../shared/widgets/primary_button.dart';
import '../../../recording/domain/entities/recording_config_entity.dart';
import '../../../recording/presentation/providers/recording_providers.dart';

class SessionConfigScreen extends ConsumerStatefulWidget {
  const SessionConfigScreen({
    super.key,
    required this.eventId,
    required this.sessionId,
  });

  final String eventId;
  final String sessionId;

  @override
  ConsumerState<SessionConfigScreen> createState() =>
      _SessionConfigScreenState();
}

class _SessionConfigScreenState extends ConsumerState<SessionConfigScreen> {
  int? _durationSeconds;
  int? _countdownSeconds;
  int? _maxTakes;
  bool _initialized = false;

  RecordingConfigEntity _defaultConfig() => RecordingConfigEntity(
        id: '',
        eventId: widget.eventId,
        updatedAt: DateTime.now(),
      );

  @override
  Widget build(BuildContext context) {
    final configAsync =
        ref.watch(recordingConfigProvider(widget.eventId));

    return configAsync.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Scaffold(
        appBar: AppBar(),
        body: Center(child: Text(e.toString())),
      ),
      data: (config) {
        final base = config ?? _defaultConfig();
        if (!_initialized) {
          _durationSeconds = base.durationSeconds;
          _countdownSeconds = base.countdownSeconds;
          _maxTakes = base.maxTakesPerSession;
          _initialized = true;
        }
        return _buildForm(context, base);
      },
    );
  }

  Widget _buildForm(BuildContext context, RecordingConfigEntity base) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configurar sesión')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Estos valores aplican solo a esta sesión.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
          ),
          const SizedBox(height: 20),
          _StepField(
            label: 'Duración de grabación (segundos)',
            value: _durationSeconds ?? base.durationSeconds,
            min: 5,
            max: 300,
            onChanged: (v) => setState(() => _durationSeconds = v),
          ),
          const SizedBox(height: 16),
          _StepField(
            label: 'Cuenta regresiva (segundos)',
            value: _countdownSeconds ?? base.countdownSeconds,
            min: 0,
            max: 10,
            onChanged: (v) => setState(() => _countdownSeconds = v),
          ),
          const SizedBox(height: 16),
          _StepField(
            label: 'Máximo de tomas',
            value: _maxTakes ?? base.maxTakesPerSession,
            min: 1,
            max: 10,
            onChanged: (v) => setState(() => _maxTakes = v),
          ),
          const SizedBox(height: 32),
          PrimaryButton(
            label: 'Ir a grabar',
            onPressed: () => _proceed(base),
          ),
        ],
      ),
    );
  }

  Future<void> _proceed(RecordingConfigEntity base) async {
    final controller = ref.read(recordingControllerProvider.notifier);
    final effectiveConfig = base.copyWith(
      durationSeconds: _durationSeconds,
      countdownSeconds: _countdownSeconds,
      maxTakesPerSession: _maxTakes,
    );
    await controller.initCamera(
      eventId: widget.eventId,
      sessionId: widget.sessionId,
      config: effectiveConfig,
    );
    if (!mounted) return;
    context.push(
      AppRoutes.studioRecording(widget.eventId, widget.sessionId),
    );
  }
}

class _StepField extends StatelessWidget {
  const _StepField({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  final String label;
  final int value;
  final int min;
  final int max;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelMedium),
        const SizedBox(height: 8),
        Row(
          children: [
            IconButton.outlined(
              icon: const Icon(Icons.remove),
              onPressed: value > min ? () => onChanged(value - 1) : null,
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: 48,
              child: Text(
                '$value',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const SizedBox(width: 8),
            IconButton.outlined(
              icon: const Icon(Icons.add),
              onPressed: value < max ? () => onChanged(value + 1) : null,
            ),
          ],
        ),
      ],
    );
  }
}

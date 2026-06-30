import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../shared/widgets/primary_button.dart';
import '../../../recording/domain/entities/recording_config_entity.dart';
import '../../../recording/presentation/providers/recording_providers.dart';
import '../../../recording/presentation/screens/recording_screen.dart';

const _spinLabEventId = '__spinlab__';

class SpinLabScreen extends ConsumerStatefulWidget {
  const SpinLabScreen({super.key});

  @override
  ConsumerState<SpinLabScreen> createState() => _SpinLabScreenState();
}

class _SpinLabScreenState extends ConsumerState<SpinLabScreen> {
  int _durationSeconds = 30;
  String _cameraFacing = 'back';
  String _resolution = '1080p';
  int _countdownSeconds = 3;
  bool _started = false;

  @override
  void dispose() {
    ref.read(recordingControllerProvider.notifier).clearAllTakes();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_started) {
      return RecordingScreen(
        eventId: _spinLabEventId,
        sessionId: '__spinlab_session__',
        isSpinLab: true,
      );
    }
    return _SetupView(
      durationSeconds: _durationSeconds,
      cameraFacing: _cameraFacing,
      resolution: _resolution,
      countdownSeconds: _countdownSeconds,
      onDurationChanged: (v) => setState(() => _durationSeconds = v),
      onCameraChanged: (v) => setState(() => _cameraFacing = v),
      onResolutionChanged: (v) => setState(() => _resolution = v),
      onCountdownChanged: (v) => setState(() => _countdownSeconds = v),
      onStart: () => _startSpinLab(),
    );
  }

  Future<void> _startSpinLab() async {
    final config = RecordingConfigEntity(
      id: '__spinlab__',
      eventId: _spinLabEventId,
      durationSeconds: _durationSeconds,
      cameraFacing: _cameraFacing,
      resolution: _resolution,
      countdownSeconds: _countdownSeconds,
      updatedAt: DateTime.now(),
    );
    await ref.read(recordingControllerProvider.notifier).initCamera(
          eventId: _spinLabEventId,
          sessionId: null,
          config: config,
        );
    if (!mounted) return;
    setState(() => _started = true);
  }
}

class _SetupView extends StatelessWidget {
  const _SetupView({
    required this.durationSeconds,
    required this.cameraFacing,
    required this.resolution,
    required this.countdownSeconds,
    required this.onDurationChanged,
    required this.onCameraChanged,
    required this.onResolutionChanged,
    required this.onCountdownChanged,
    required this.onStart,
  });

  final int durationSeconds;
  final String cameraFacing;
  final String resolution;
  final int countdownSeconds;
  final ValueChanged<int> onDurationChanged;
  final ValueChanged<String> onCameraChanged;
  final ValueChanged<String> onResolutionChanged;
  final ValueChanged<int> onCountdownChanged;
  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SpinLab'),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'MODO PRUEBA',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Zona de pruebas',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Las grabaciones no se guardan ni sincronizan. '
                    'Al salir todo el contenido se elimina automáticamente.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          _SegmentRow(
            label: 'Cámara',
            options: const {'back': 'Trasera', 'front': 'Frontal'},
            selected: cameraFacing,
            onChanged: onCameraChanged,
          ),
          const SizedBox(height: 16),
          _SegmentRow(
            label: 'Resolución',
            options: const {'720p': '720p', '1080p': '1080p', '4k': '4K'},
            selected: resolution,
            onChanged: onResolutionChanged,
          ),
          const SizedBox(height: 16),
          _SliderRow(
            label: 'Duración (segundos)',
            value: durationSeconds,
            min: 5,
            max: 120,
            onChanged: onDurationChanged,
          ),
          const SizedBox(height: 16),
          _SliderRow(
            label: 'Cuenta regresiva',
            value: countdownSeconds,
            min: 0,
            max: 10,
            onChanged: onCountdownChanged,
          ),
          const SizedBox(height: 32),
          PrimaryButton(label: 'Iniciar prueba', onPressed: onStart),
        ],
      ),
    );
  }
}

class _SegmentRow extends StatelessWidget {
  const _SegmentRow({
    required this.label,
    required this.options,
    required this.selected,
    required this.onChanged,
  });

  final String label;
  final Map<String, String> options;
  final String selected;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelMedium),
        const SizedBox(height: 6),
        SegmentedButton<String>(
          segments: options.entries
              .map((e) => ButtonSegment(value: e.key, label: Text(e.value)))
              .toList(),
          selected: {selected},
          onSelectionChanged: (s) => onChanged(s.first),
        ),
      ],
    );
  }
}

class _SliderRow extends StatelessWidget {
  const _SliderRow({
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: Theme.of(context).textTheme.labelMedium),
            Text('$value', style: Theme.of(context).textTheme.titleSmall),
          ],
        ),
        Slider(
          value: value.toDouble(),
          min: min.toDouble(),
          max: max.toDouble(),
          onChanged: (v) => onChanged(v.round()),
        ),
      ],
    );
  }
}

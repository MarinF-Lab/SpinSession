import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../../../../shared/widgets/primary_button.dart';
import '../../domain/entities/recording_config_entity.dart';
import '../providers/recording_providers.dart';

class RecordingConfigScreen extends ConsumerStatefulWidget {
  const RecordingConfigScreen({super.key, required this.eventId});

  final String eventId;

  @override
  ConsumerState<RecordingConfigScreen> createState() =>
      _RecordingConfigScreenState();
}

class _RecordingConfigScreenState
    extends ConsumerState<RecordingConfigScreen> {
  int _durationSeconds = 30;
  String _resolution = '1080p';
  String _cameraFacing = 'back';
  String _quality = 'high';
  int _maxTakes = 3;
  int _countdownSeconds = 3;
  bool _initialized = false;
  bool _saving = false;
  static const _uuid = Uuid();

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
        if (!_initialized) {
          if (config != null) {
            _durationSeconds = config.durationSeconds;
            _resolution = config.resolution;
            _cameraFacing = config.cameraFacing;
            _quality = config.quality;
            _maxTakes = config.maxTakesPerSession;
            _countdownSeconds = config.countdownSeconds;
          }
          _initialized = true;
        }
        return _buildBody(context, config);
      },
    );
  }

  Widget _buildBody(BuildContext context, RecordingConfigEntity? existing) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configuración de grabación')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _SectionHeader('Cámara'),
          _SegmentedRow(
            label: 'Cámara',
            options: const {'back': 'Trasera', 'front': 'Frontal'},
            selected: _cameraFacing,
            onChanged: (v) => setState(() => _cameraFacing = v),
          ),
          const SizedBox(height: 16),
          _SegmentedRow(
            label: 'Resolución',
            options: const {'720p': '720p', '1080p': '1080p', '4k': '4K'},
            selected: _resolution,
            onChanged: (v) => setState(() => _resolution = v),
          ),
          const SizedBox(height: 16),
          _SegmentedRow(
            label: 'Calidad',
            options: const {'standard': 'Estándar', 'high': 'Alta'},
            selected: _quality,
            onChanged: (v) => setState(() => _quality = v),
          ),
          const SizedBox(height: 24),
          _SectionHeader('Grabación'),
          _SliderField(
            label: 'Duración (segundos)',
            value: _durationSeconds,
            min: 5,
            max: 300,
            divisions: 59,
            onChanged: (v) => setState(() => _durationSeconds = v),
          ),
          const SizedBox(height: 16),
          _SliderField(
            label: 'Cuenta regresiva (segundos)',
            value: _countdownSeconds,
            min: 0,
            max: 10,
            divisions: 10,
            onChanged: (v) => setState(() => _countdownSeconds = v),
          ),
          const SizedBox(height: 16),
          _SliderField(
            label: 'Máximo de tomas por sesión',
            value: _maxTakes,
            min: 1,
            max: 10,
            divisions: 9,
            onChanged: (v) => setState(() => _maxTakes = v),
          ),
          const SizedBox(height: 32),
          PrimaryButton(
            label: 'Guardar configuración',
            isLoading: _saving,
            onPressed: () => _save(existing),
          ),
        ],
      ),
    );
  }

  Future<void> _save(RecordingConfigEntity? existing) async {
    setState(() => _saving = true);
    final config = RecordingConfigEntity(
      id: existing?.id ?? _uuid.v4(),
      eventId: widget.eventId,
      durationSeconds: _durationSeconds,
      resolution: _resolution,
      cameraFacing: _cameraFacing,
      quality: _quality,
      maxTakesPerSession: _maxTakes,
      countdownSeconds: _countdownSeconds,
      updatedAt: DateTime.now(),
    );
    await ref
        .read(recordingConfigRepositoryProvider)
        .save(config);
    ref.invalidate(recordingConfigProvider(widget.eventId));
    if (!mounted) return;
    setState(() => _saving = false);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Configuración guardada')),
    );
    context.pop();
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
    );
  }
}

class _SegmentedRow extends StatelessWidget {
  const _SegmentedRow({
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

class _SliderField extends StatelessWidget {
  const _SliderField({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.divisions,
    required this.onChanged,
  });

  final String label;
  final int value;
  final int min;
  final int max;
  final int divisions;
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
          divisions: divisions,
          onChanged: (v) => onChanged(v.round()),
        ),
      ],
    );
  }
}

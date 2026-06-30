import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../shared/widgets/date_picker_field.dart';
import '../../../../../shared/widgets/loading_screen.dart';
import '../../../../../shared/widgets/primary_button.dart';
import '../../../../../shared/widgets/time_picker_field.dart';
import '../../domain/entities/event_entity.dart';
import '../providers/event_providers.dart';

class EditEventScreen extends ConsumerStatefulWidget {
  const EditEventScreen({super.key, required this.eventId});

  final String eventId;

  @override
  ConsumerState<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends ConsumerState<EditEventScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();

  DateTime? _eventDate;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  bool _initialized = false;
  bool _submitting = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  DateTime? _toDateTime(DateTime? date, TimeOfDay? time) {
    if (date == null || time == null) return null;
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  Future<void> _submit(EventEntity event) async {
    if (!_formKey.currentState!.validate()) return;
    final start = _toDateTime(_eventDate, _startTime);
    final end = _toDateTime(_eventDate, _endTime);
    if (start == null || end == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Completa la fecha y horario')),
      );
      return;
    }
    setState(() => _submitting = true);
    final updated = event.copyWith(
      name: _nameCtrl.text.trim(),
      eventDate: _eventDate,
      startDatetime: start,
      endDatetime: end,
      notes: _notesCtrl.text.trim().isEmpty ? null : _notesCtrl.text.trim(),
    );
    final ok = await ref
        .read(eventControllerProvider.notifier)
        .updateEvent(updated);
    if (!mounted) return;
    setState(() => _submitting = false);
    if (ok) {
      context.pop();
    } else {
      final error = ref.read(eventControllerProvider).errorMessage;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error ?? 'Error al guardar')),
      );
      ref.read(eventControllerProvider.notifier).clearError();
    }
  }

  @override
  Widget build(BuildContext context) {
    final eventAsync = ref.watch(eventByIdProvider(widget.eventId));

    return eventAsync.when(
      loading: () => const LoadingScreen(),
      error: (e, _) => Scaffold(
        appBar: AppBar(),
        body: Center(child: Text(e.toString())),
      ),
      data: (event) {
        if (event == null) {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(child: Text('Evento no encontrado')),
          );
        }
        if (!_initialized) {
          _nameCtrl.text = event.name;
          _notesCtrl.text = event.notes ?? '';
          _eventDate = event.eventDate;
          _startTime = TimeOfDay.fromDateTime(event.startDatetime);
          _endTime = TimeOfDay.fromDateTime(event.endDatetime);
          _initialized = true;
        }
        return Scaffold(
          appBar: AppBar(title: const Text('Editar evento')),
          body: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                TextFormField(
                  controller: _nameCtrl,
                  decoration:
                      const InputDecoration(labelText: 'Nombre del evento'),
                  textCapitalization: TextCapitalization.words,
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Campo requerido' : null,
                ),
                const SizedBox(height: 16),
                DatePickerField(
                  label: 'Fecha del evento',
                  value: _eventDate,
                  onChanged: (d) => setState(() => _eventDate = d),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TimePickerField(
                        label: 'Inicio',
                        value: _startTime,
                        onChanged: (t) => setState(() => _startTime = t),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TimePickerField(
                        label: 'Fin',
                        value: _endTime,
                        onChanged: (t) => setState(() => _endTime = t),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _notesCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Notas (opcional)',
                    alignLabelWithHint: true,
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 32),
                PrimaryButton(
                  label: 'Guardar cambios',
                  isLoading: _submitting,
                  onPressed: () => _submit(event),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

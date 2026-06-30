import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../shared/widgets/date_picker_field.dart';
import '../../../../../shared/widgets/primary_button.dart';
import '../../../../../shared/widgets/time_picker_field.dart';
import '../providers/event_providers.dart';

class CreateEventScreen extends ConsumerStatefulWidget {
  const CreateEventScreen({super.key});

  @override
  ConsumerState<CreateEventScreen> createState() =>
      _CreateEventScreenState();
}

class _CreateEventScreenState extends ConsumerState<CreateEventScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();

  DateTime? _eventDate;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
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

  Future<void> _submit() async {
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
    final ok = await ref.read(eventControllerProvider.notifier).createEvent(
          name: _nameCtrl.text.trim(),
          eventDate: _eventDate!,
          startDatetime: start,
          endDatetime: end,
          notes: _notesCtrl.text.trim().isEmpty ? null : _notesCtrl.text.trim(),
        );
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
    return Scaffold(
      appBar: AppBar(title: const Text('Nuevo evento')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nameCtrl,
              decoration: const InputDecoration(labelText: 'Nombre del evento'),
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
              label: 'Crear evento',
              isLoading: _submitting,
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }
}

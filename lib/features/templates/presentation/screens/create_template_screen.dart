import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../shared/widgets/primary_button.dart';
import '../providers/template_providers.dart';

class CreateTemplateScreen extends ConsumerStatefulWidget {
  const CreateTemplateScreen({super.key});

  @override
  ConsumerState<CreateTemplateScreen> createState() =>
      _CreateTemplateScreenState();
}

class _CreateTemplateScreenState
    extends ConsumerState<CreateTemplateScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _hoursCtrl = TextEditingController(text: '2');
  final _minutesCtrl = TextEditingController(text: '0');
  bool _submitting = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _hoursCtrl.dispose();
    _minutesCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final hours = int.tryParse(_hoursCtrl.text) ?? 0;
    final minutes = int.tryParse(_minutesCtrl.text) ?? 0;
    final durationSeconds = hours * 3600 + minutes * 60;
    if (durationSeconds <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('La duración debe ser mayor a 0')),
      );
      return;
    }
    setState(() => _submitting = true);
    final ok = await ref.read(templatesProvider.notifier).create(
          name: _nameCtrl.text.trim(),
          durationSeconds: durationSeconds,
        );
    if (!mounted) return;
    setState(() => _submitting = false);
    if (ok) {
      context.pop();
    } else {
      final error = ref.read(templatesProvider).errorMessage;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error ?? 'Error al guardar')),
      );
      ref.read(templatesProvider.notifier).clearError();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nueva plantilla')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nameCtrl,
              decoration:
                  const InputDecoration(labelText: 'Nombre de la plantilla'),
              textCapitalization: TextCapitalization.words,
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Campo requerido' : null,
            ),
            const SizedBox(height: 24),
            Text('Duración por defecto',
                style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _hoursCtrl,
                    decoration:
                        const InputDecoration(labelText: 'Horas', suffixText: 'h'),
                    keyboardType: TextInputType.number,
                    validator: (v) {
                      final n = int.tryParse(v ?? '');
                      if (n == null || n < 0) return 'Inválido';
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: _minutesCtrl,
                    decoration: const InputDecoration(
                        labelText: 'Minutos', suffixText: 'min'),
                    keyboardType: TextInputType.number,
                    validator: (v) {
                      final n = int.tryParse(v ?? '');
                      if (n == null || n < 0 || n > 59) return 'Inválido';
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            PrimaryButton(
              label: 'Crear plantilla',
              isLoading: _submitting,
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../app/router/app_routes.dart';
import '../../../../../shared/widgets/primary_button.dart';
import '../providers/session_providers.dart';

const _countryCodes = [
  '+56', // Chile
  '+54', // Argentina
  '+51', // Perú
  '+57', // Colombia
  '+52', // México
  '+55', // Brasil
  '+1',  // EEUU / Canadá
  '+34', // España
];

class GuestRegistrationScreen extends ConsumerStatefulWidget {
  const GuestRegistrationScreen({super.key, required this.eventId});

  final String eventId;

  @override
  ConsumerState<GuestRegistrationScreen> createState() =>
      _GuestRegistrationScreenState();
}

class _GuestRegistrationScreenState
    extends ConsumerState<GuestRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();
  String _countryCode = '+56';
  bool _submitting = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _submitting = true);

    final session = await ref
        .read(sessionControllerProvider.notifier)
        .createSession(
          eventId: widget.eventId,
          guestName: _nameCtrl.text.trim(),
          phone: _phoneCtrl.text.trim(),
          countryCode: _countryCode,
          notes: _notesCtrl.text.trim().isEmpty
              ? null
              : _notesCtrl.text.trim(),
        );

    if (!mounted) return;
    setState(() => _submitting = false);

    if (session != null) {
      context.push(
        AppRoutes.studioSessionConfig(widget.eventId, session.id),
      );
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
    return Scaffold(
      appBar: AppBar(title: const Text('Registrar invitado')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nameCtrl,
              decoration: const InputDecoration(labelText: 'Nombre completo'),
              textCapitalization: TextCapitalization.words,
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Campo requerido' : null,
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 110,
                  child: DropdownButtonFormField<String>(
                    value: _countryCode,
                    decoration:
                        const InputDecoration(labelText: 'Código'),
                    items: _countryCodes
                        .map((c) => DropdownMenuItem(
                              value: c,
                              child: Text(c),
                            ))
                        .toList(),
                    onChanged: (v) =>
                        setState(() => _countryCode = v ?? _countryCode),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: _phoneCtrl,
                    decoration:
                        const InputDecoration(labelText: 'Teléfono'),
                    keyboardType: TextInputType.phone,
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) {
                        return 'Campo requerido';
                      }
                      if (v.trim().length < 7) return 'Número inválido';
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _notesCtrl,
              decoration: const InputDecoration(
                labelText: 'Observaciones (opcional)',
                alignLabelWithHint: true,
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 32),
            PrimaryButton(
              label: 'Continuar',
              isLoading: _submitting,
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }
}

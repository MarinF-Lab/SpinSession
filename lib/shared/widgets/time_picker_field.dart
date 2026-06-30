import 'package:flutter/material.dart';

class TimePickerField extends StatelessWidget {
  const TimePickerField({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.enabled = true,
  });

  final String label;
  final TimeOfDay? value;
  final ValueChanged<TimeOfDay> onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final display = value != null ? value!.format(context) : 'Seleccionar hora';

    return GestureDetector(
      onTap: enabled ? () => _pick(context) : null,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          suffixIcon: const Icon(Icons.access_time_outlined, size: 20),
          enabled: enabled,
        ),
        child: Text(
          display,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: value == null ? Theme.of(context).hintColor : null,
              ),
        ),
      ),
    );
  }

  Future<void> _pick(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: value ?? TimeOfDay.now(),
      builder: (ctx, child) => MediaQuery(
        data: MediaQuery.of(ctx).copyWith(alwaysUse24HourFormat: true),
        child: child!,
      ),
    );
    if (picked != null) onChanged(picked);
  }
}

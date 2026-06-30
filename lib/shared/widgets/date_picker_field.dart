import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerField extends StatelessWidget {
  const DatePickerField({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.firstDate,
    this.lastDate,
    this.enabled = true,
  });

  final String label;
  final DateTime? value;
  final ValueChanged<DateTime> onChanged;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final display = value != null
        ? DateFormat('dd/MM/yyyy', 'es').format(value!)
        : 'Seleccionar fecha';

    return GestureDetector(
      onTap: enabled ? () => _pick(context) : null,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          suffixIcon: const Icon(Icons.calendar_today_outlined, size: 20),
          enabled: enabled,
        ),
        child: Text(
          display,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: value == null
                    ? Theme.of(context).hintColor
                    : null,
              ),
        ),
      ),
    );
  }

  Future<void> _pick(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: value ?? now,
      firstDate: firstDate ?? DateTime(now.year - 1),
      lastDate: lastDate ?? DateTime(now.year + 5),
    );
    if (picked != null) onChanged(picked);
  }
}

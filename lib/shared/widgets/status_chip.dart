import 'package:flutter/material.dart';

import '../../features/events/domain/entities/event_status.dart';

class StatusChip extends StatelessWidget {
  const StatusChip({super.key, required this.status});

  final EventStatus status;

  @override
  Widget build(BuildContext context) {
    final (label, bg, fg) = _style(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: Theme.of(context)
            .textTheme
            .labelSmall
            ?.copyWith(color: fg, fontWeight: FontWeight.w600),
      ),
    );
  }

  (String, Color, Color) _style(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return switch (status) {
      EventStatus.reserved => ('Reservado', cs.secondaryContainer, cs.onSecondaryContainer),
      EventStatus.pendingPayment => ('Pago Pendiente', const Color(0xFFFFF3CD), const Color(0xFF856404)),
      EventStatus.paid => ('Pagado', const Color(0xFFD4EDDA), const Color(0xFF155724)),
      EventStatus.active => ('Activo', cs.primaryContainer, cs.onPrimaryContainer),
      EventStatus.paused => ('Pausado', cs.surfaceContainerHighest, cs.onSurfaceVariant),
      EventStatus.finished => ('Finalizado', cs.surfaceContainerHighest, cs.onSurfaceVariant),
      EventStatus.archived => ('Archivado', cs.errorContainer, cs.onErrorContainer),
    };
  }
}

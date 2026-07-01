import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
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
      EventStatus.reserved =>
        ('Reservado', AppColors.statusReserved.withValues(alpha: 0.16), AppColors.statusReserved),
      EventStatus.pendingPayment =>
        ('Pago Pendiente', const Color(0xFFFFF3CD), const Color(0xFF856404)),
      EventStatus.paid =>
        ('Pagado', AppColors.statusPaid.withValues(alpha: 0.16), AppColors.statusPaid),
      EventStatus.active =>
        ('Activo', AppColors.statusActive.withValues(alpha: 0.16), AppColors.statusActive),
      EventStatus.paused => ('Pausado', cs.surfaceContainerHighest, cs.onSurfaceVariant),
      EventStatus.finished =>
        ('Finalizado', AppColors.statusFinished.withValues(alpha: 0.16), AppColors.statusFinished),
      EventStatus.archived => ('Archivado', cs.errorContainer, cs.onErrorContainer),
    };
  }
}

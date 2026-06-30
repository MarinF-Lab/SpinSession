import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({
    required this.message,
    this.title,
    this.icon,
    super.key,
  });

  final String? title;
  final String message;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 48, color: cs.outline),
              const SizedBox(height: 12),
            ],
            if (title != null) ...[
              Text(
                title!,
                style: textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
            ],
            Text(message,
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium
                    ?.copyWith(color: cs.outline)),
          ],
        ),
      ),
    );
  }
}

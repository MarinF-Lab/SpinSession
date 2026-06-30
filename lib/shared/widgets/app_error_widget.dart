import 'package:flutter/material.dart';

/// Widget de respaldo mostrado cuando un error de construcción no
/// capturado ocurre dentro del árbol de widgets, en vez de la
/// pantalla roja por defecto de Flutter.
class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget({super.key, this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surface,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.error_outline,
                size: 48,
                color: Theme.of(context).colorScheme.error,
              ),
              const SizedBox(height: 12),
              const Text(
                'Ocurrió un error inesperado',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              if (message != null) ...[
                const SizedBox(height: 8),
                Text(
                  message!,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../../device_selection/presentation/providers/device_mode_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userEmail = ref.watch(currentUserProvider);
    final deviceMode = ref.watch(deviceModeControllerProvider).mode;

    return Scaffold(
      appBar: AppBar(
        title: const Text('SpinSession'),
        actions: [
          IconButton(
            tooltip: 'Configuración',
            onPressed: () => context.go(AppRoutes.settings),
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Text('Inicio', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 8),
          Text(userEmail ?? 'Sesión local no iniciada'),
          const SizedBox(height: 8),
          Text('Modo: ${deviceMode?.label ?? 'Sin seleccionar'}'),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: () => context.go(AppRoutes.calendar),
            child: const Text('Abrir calendario'),
          ),
        ],
      ),
    );
  }
}

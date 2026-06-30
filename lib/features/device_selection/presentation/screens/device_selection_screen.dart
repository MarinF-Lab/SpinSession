import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../../domain/entities/device_mode.dart';
import '../providers/device_mode_provider.dart';

class DeviceSelectionScreen extends ConsumerWidget {
  const DeviceSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedMode = ref.watch(deviceModeControllerProvider).mode;

    return Scaffold(
      appBar: AppBar(title: const Text('Modo del dispositivo')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Text(
              'Selecciona como trabajara este telefono.',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 24),
            for (final mode in DeviceMode.values)
              _DeviceModeTile(
                mode: mode,
                isSelected: selectedMode == mode,
                onTap: () => ref
                    .read(deviceModeControllerProvider.notifier)
                    .selectMode(mode),
              ),
            const SizedBox(height: 24),
            PrimaryButton(
              label: 'Continuar',
              onPressed: selectedMode == null
                  ? null
                  : () => context.go(AppRoutes.home),
            ),
          ],
        ),
      ),
    );
  }
}

class _DeviceModeTile extends StatelessWidget {
  const _DeviceModeTile({
    required this.mode,
    required this.isSelected,
    required this.onTap,
  });

  final DeviceMode mode;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      child: ListTile(
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        leading: Icon(
          isSelected ? Icons.check_circle : Icons.circle_outlined,
          color: isSelected ? colorScheme.primary : colorScheme.outline,
        ),
        title: Text(mode.label),
        subtitle: Text(mode.description),
      ),
    );
  }
}

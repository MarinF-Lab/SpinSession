import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../app/router/app_routes.dart';
import '../../../../../shared/widgets/confirmation_dialog.dart';
import '../../../../../shared/widgets/empty_state.dart';
import '../providers/template_providers.dart';

class TemplatesScreen extends ConsumerWidget {
  const TemplatesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(templatesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Plantillas')),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.templates.isEmpty
              ? const EmptyState(
                  icon: Icons.style_outlined,
                  message: 'Sin plantillas creadas',
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: state.templates.length,
                  itemBuilder: (_, i) {
                    final t = state.templates[i];
                    final hours = t.durationSeconds ~/ 3600;
                    final minutes = (t.durationSeconds % 3600) ~/ 60;
                    final durationLabel = minutes == 0
                        ? '${hours}h'
                        : '${hours}h ${minutes}min';
                    return ListTile(
                      leading: const Icon(Icons.style_outlined),
                      title: Text(t.name),
                      subtitle: Text('Duración: $durationLabel'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () async {
                          final confirmed = await showConfirmationDialog(
                            context,
                            title: 'Eliminar plantilla',
                            message: '¿Eliminar "${t.name}"?',
                            confirmLabel: 'Eliminar',
                            isDestructive: true,
                          );
                          if (confirmed) {
                            ref
                                .read(templatesProvider.notifier)
                                .delete(t.id);
                          }
                        },
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(AppRoutes.templateCreate),
        icon: const Icon(Icons.add),
        label: const Text('Nueva plantilla'),
      ),
    );
  }
}

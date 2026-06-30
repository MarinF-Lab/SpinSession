import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../app/router/app_routes.dart';
import '../../../../../shared/widgets/empty_state.dart';
import '../../../../../shared/widgets/event_card.dart';
import '../../domain/entities/event_status.dart';
import '../providers/event_providers.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(eventControllerProvider);
    final history = state.events
        .where((e) =>
            e.eventStatus == EventStatus.finished ||
            e.eventStatus == EventStatus.archived)
        .toList()
      ..sort((a, b) => b.eventDate.compareTo(a.eventDate));

    return Scaffold(
      appBar: AppBar(title: const Text('Historial')),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : history.isEmpty
              ? const EmptyState(
                  icon: Icons.history,
                  message: 'Sin eventos en el historial',
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: history.length,
                  itemBuilder: (_, i) => EventCard(
                    event: history[i],
                    onTap: () =>
                        context.push(AppRoutes.eventDetail(history[i].id)),
                  ),
                ),
    );
  }
}

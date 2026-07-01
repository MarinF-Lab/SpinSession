import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/app_database.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../data/datasources/event_local_datasource.dart';
import '../../data/datasources/event_remote_datasource.dart';
import '../../data/repositories/event_repository.dart';
import '../../domain/entities/event_entity.dart';
import '../../domain/entities/event_settings_entity.dart';
import '../../domain/entities/event_status.dart';
import '../controllers/event_controller.dart';

final eventRepositoryProvider = Provider<EventRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return EventRepository(
    local: EventLocalDatasource(db),
    remote: EventRemoteDatasource(),
  );
});

final eventControllerProvider =
    StateNotifierProvider<EventController, EventState>((ref) {
  final repo = ref.watch(eventRepositoryProvider);
  final userId = ref.watch(currentUserProvider) ?? '';
  return EventController(repo, userId);
});

final eventsForDateProvider =
    FutureProvider.family<List<EventEntity>, DateTime>((ref, date) async {
  final repo = ref.watch(eventRepositoryProvider);
  final userId = ref.watch(currentUserProvider) ?? '';
  return repo.getByDate(userId, date);
});

final eventByIdProvider =
    FutureProvider.family<EventEntity?, String>((ref, id) async {
  final repo = ref.watch(eventRepositoryProvider);
  return repo.getById(id);
});

final eventSettingsProvider =
    FutureProvider.family<EventSettingsEntity?, String>((ref, eventId) async {
  final repo = ref.watch(eventRepositoryProvider);
  return repo.getSettings(eventId);
});

/// Evento actualmente activo (en curso) para el usuario, si existe.
/// Usado por las pestañas Estudio y Registro para saber sobre qué
/// evento operar sin requerir que el usuario navegue manualmente.
final activeEventProvider = Provider<EventEntity?>((ref) {
  final events = ref.watch(eventControllerProvider).events;
  for (final event in events) {
    if (event.eventStatus == EventStatus.active) return event;
  }
  return null;
});

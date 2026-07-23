import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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

/// Eventos del día indicado. Deriva del estado del controlador (fuente de
/// verdad en memoria) para que la lista se refresque al instante tras crear,
/// editar o pagar un evento, sin esperar a reabrir la app.
final eventsForDateProvider =
    Provider.family<List<EventEntity>, DateTime>((ref, date) {
  final events = ref.watch(eventControllerProvider).events;
  return events
      .where((e) =>
          e.eventDate.year == date.year &&
          e.eventDate.month == date.month &&
          e.eventDate.day == date.day)
      .toList();
});

/// Conjunto de días (normalizados a medianoche local) que tienen al menos un
/// evento, para pintar el marcador en la cuadrícula del calendario.
final eventDaysProvider = Provider<Set<DateTime>>((ref) {
  final events = ref.watch(eventControllerProvider).events;
  return events
      .map((e) => DateTime(e.eventDate.year, e.eventDate.month, e.eventDate.day))
      .toSet();
});

/// Evento por id, derivado del estado del controlador para que los cambios
/// (edición, pago, estado) se reflejen al instante en la pantalla de detalle.
final eventByIdProvider =
    Provider.family<EventEntity?, String>((ref, id) {
  final events = ref.watch(eventControllerProvider).events;
  for (final e in events) {
    if (e.id == id) return e;
  }
  return null;
});

/// Suscribe a cambios en tiempo real de un evento puntual vía Supabase
/// Realtime — así la pantalla de detalle se entera apenas el webhook de
/// Mercado Pago confirma el pago, sin necesidad de polling. Se activa
/// simplemente mirándolo (`ref.watch`) desde la pantalla; Riverpod cierra
/// el canal solo cuando deja de observarse.
final eventRealtimeProvider =
    Provider.autoDispose.family<void, String>((ref, eventId) {
  final channel = Supabase.instance.client
      .channel('event-$eventId')
      .onPostgresChanges(
        event: PostgresChangeEvent.update,
        schema: 'public',
        table: 'events',
        filter: PostgresChangeFilter(
          type: PostgresChangeFilterType.eq,
          column: 'id',
          value: eventId,
        ),
        callback: (payload) {
          ref.read(eventControllerProvider.notifier).syncWithRemote();
        },
      )
      .subscribe();

  ref.onDispose(() {
    Supabase.instance.client.removeChannel(channel);
  });
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

import '../../../../core/errors/app_failure.dart';
import '../../../../core/logging/app_logger.dart';
import '../../domain/entities/event_entity.dart';
import '../../domain/entities/event_settings_entity.dart';
import '../../domain/entities/event_status.dart';
import '../datasources/event_local_datasource.dart';
import '../datasources/event_remote_datasource.dart';

class EventRepository {
  const EventRepository({
    required EventLocalDatasource local,
    required EventRemoteDatasource remote,
  })  : _local = local,
        _remote = remote;

  final EventLocalDatasource _local;
  final EventRemoteDatasource _remote;

  Future<List<EventEntity>> getAll(String userId) =>
      _local.getAll(userId);

  Future<List<EventEntity>> getByDate(String userId, DateTime date) =>
      _local.getByDate(userId, date);

  Future<EventEntity?> getById(String id) => _local.getById(id);

  Future<List<EventEntity>> search(String userId, String query) =>
      _local.search(userId, query);

  Future<void> save(EventEntity event) async {
    _validateEvent(event);
    await _local.upsert(event);
    _syncInBackground(event);
  }

  Future<void> delete(String id) async {
    await _local.delete(id);
    _deleteRemoteInBackground(id);
  }

  Future<void> updateStatus(String id, EventStatus status) async {
    await _local.updateStatus(id, status);
    final event = await _local.getById(id);
    if (event != null) _syncInBackground(event);
  }

  Future<void> updatePaymentStatus(String id, PaymentStatus status) async {
    await _local.updatePaymentStatus(id, status);
    final event = await _local.getById(id);
    if (event != null) _syncInBackground(event);
  }

  Future<EventSettingsEntity?> getSettings(String eventId) =>
      _local.getSettings(eventId);

  Future<void> saveSettings(EventSettingsEntity settings) =>
      _local.upsertSettings(settings);

  Future<void> syncPending() async {
    final pending = await _local.getPendingSync();
    for (final event in pending) {
      try {
        await _remote.upsert(event);
        await _local.markSynced(event.id);
      } catch (error) {
        AppLogger.warning(
            'EventSync', 'Evento ${event.id} quedará pendiente: $error');
      }
    }
  }

  void _syncInBackground(EventEntity event) {
    _remote.upsert(event).then((_) => _local.markSynced(event.id)).ignore();
  }

  void _deleteRemoteInBackground(String id) {
    _remote.delete(id).ignore();
  }

  void _validateEvent(EventEntity event) {
    if (event.name.trim().isEmpty) {
      throw const AppFailure('El nombre del evento es obligatorio.');
    }
    if (!event.endDatetime.isAfter(event.startDatetime)) {
      throw const AppFailure(
        'La hora de término debe ser posterior a la de inicio.',
      );
    }
    if (event.duration.inHours > 24) {
      throw const AppFailure('La duración máxima de un evento es 24 horas.');
    }
  }
}

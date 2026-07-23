import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/event_entity.dart';
import '../../domain/entities/event_settings_entity.dart';
import '../../domain/entities/event_status.dart';
import '../models/event_model.dart';
import '../models/event_settings_model.dart';

class EventLocalDatasource {
  const EventLocalDatasource(this._db);

  final AppDatabase _db;

  Future<List<EventEntity>> getAll(String userId) async {
    final rows = await (_db.select(_db.eventsTable)
          ..where((t) => t.userId.equals(userId))
          ..orderBy([(t) => OrderingTerm.asc(t.startDatetime)]))
        .get();
    return rows.map(EventModel.fromRow).toList();
  }

  Future<List<EventEntity>> getByDate(String userId, DateTime date) async {
    final start = DateTime(date.year, date.month, date.day);
    final end = start.add(const Duration(days: 1));
    final rows = await (_db.select(_db.eventsTable)
          ..where(
            (t) =>
                t.userId.equals(userId) &
                t.eventDate.isBiggerOrEqualValue(start) &
                t.eventDate.isSmallerThanValue(end),
          ))
        .get();
    return rows.map(EventModel.fromRow).toList();
  }

  Future<EventEntity?> getById(String id) async {
    final row = await (_db.select(_db.eventsTable)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    return row != null ? EventModel.fromRow(row) : null;
  }

  Future<void> upsert(EventEntity event) async {
    await _db.into(_db.eventsTable).insertOnConflictUpdate(
          EventModel.toCompanion(event),
        );
  }

  Future<void> delete(String id) async {
    await (_db.delete(_db.eventsTable)..where((t) => t.id.equals(id))).go();
  }

  Future<List<EventEntity>> getPendingSync() async {
    final rows = await (_db.select(_db.eventsTable)
          ..where((t) => t.synced.equals(false)))
        .get();
    return rows.map(EventModel.fromRow).toList();
  }

  Future<void> markSynced(String id) async {
    await (_db.update(_db.eventsTable)..where((t) => t.id.equals(id)))
        .write(const EventsTableCompanion(synced: Value(true)));
  }

  Future<EventSettingsEntity?> getSettings(String eventId) async {
    final row = await (_db.select(_db.eventSettingsTable)
          ..where((t) => t.eventId.equals(eventId)))
        .getSingleOrNull();
    return row != null ? EventSettingsModel.fromRow(row) : null;
  }

  Future<void> upsertSettings(EventSettingsEntity settings) async {
    await _db.into(_db.eventSettingsTable).insertOnConflictUpdate(
          EventSettingsModel.toCompanion(settings),
        );
  }

  Future<List<EventEntity>> search(String userId, String query) async {
    final rows = await (_db.select(_db.eventsTable)
          ..where(
            (t) =>
                t.userId.equals(userId) &
                t.name.like('%$query%'),
          )
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
    return rows.map(EventModel.fromRow).toList();
  }

  Future<void> updateStatus(String id, EventStatus status) async {
    await (_db.update(_db.eventsTable)..where((t) => t.id.equals(id))).write(
      EventsTableCompanion(
        eventStatus: Value(status.value),
        updatedAt: Value(DateTime.now()),
        synced: const Value(false),
      ),
    );
  }

  Future<void> updatePaymentStatus(String id, PaymentStatus status) async {
    await (_db.update(_db.eventsTable)..where((t) => t.id.equals(id))).write(
      EventsTableCompanion(
        paymentStatus: Value(status.name),
        updatedAt: Value(DateTime.now()),
        synced: const Value(false),
      ),
    );
  }

  Future<void> updatePaymentLink(String id, String link) async {
    await (_db.update(_db.eventsTable)..where((t) => t.id.equals(id))).write(
      EventsTableCompanion(
        paymentLink: Value(link),
        updatedAt: Value(DateTime.now()),
        synced: const Value(false),
      ),
    );
  }
}

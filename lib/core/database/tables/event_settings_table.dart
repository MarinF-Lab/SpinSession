import 'package:drift/drift.dart';

import 'events_table.dart';

class EventSettingsTable extends Table {
  @override
  String get tableName => 'event_settings';

  TextColumn get id => text()();
  TextColumn get eventId =>
      text().unique().references(EventsTable, #id, onDelete: KeyAction.cascade)();
  IntColumn get defaultDurationSeconds =>
      integer().withDefault(const Constant(30))();
  TextColumn get defaultEffects => text().withDefault(const Constant('[]'))();
  BoolColumn get allowMultipleSessions =>
      boolean().withDefault(const Constant(true))();
  IntColumn get autoDeleteDays => integer().nullable()();
  TextColumn get galleryName => text().nullable()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

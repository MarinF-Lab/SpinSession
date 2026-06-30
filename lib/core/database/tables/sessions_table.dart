import 'package:drift/drift.dart';

import 'events_table.dart';

class SessionsTable extends Table {
  TextColumn get id => text()();
  TextColumn get eventId =>
      text().references(EventsTable, #id, onDelete: KeyAction.cascade)();
  TextColumn get guestName => text()();
  TextColumn get phone => text()();
  TextColumn get countryCode => text().withDefault(const Constant('+56'))();
  TextColumn get notes => text().nullable()();
  TextColumn get deviceId => text()();
  TextColumn get status =>
      text().withDefault(const Constant('registered'))();
  IntColumn get durationSecondsOverride => integer().nullable()();
  TextColumn get effectsOverride => text().nullable()();
  IntColumn get countdownSecondsOverride => integer().nullable()();
  IntColumn get maxTakesOverride => integer().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

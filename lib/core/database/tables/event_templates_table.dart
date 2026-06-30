import 'package:drift/drift.dart';

class EventTemplatesTable extends Table {
  @override
  String get tableName => 'event_templates';

  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get name => text()();
  IntColumn get durationSeconds => integer().withDefault(const Constant(30))();
  TextColumn get defaultEffects => text().withDefault(const Constant('[]'))();
  IntColumn get autoDeleteDays => integer().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

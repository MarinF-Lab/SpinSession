import 'package:drift/drift.dart';

import 'event_templates_table.dart';

class EventsTable extends Table {
  @override
  String get tableName => 'events';

  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get templateId =>
      text().nullable().references(EventTemplatesTable, #id)();
  TextColumn get name => text()();
  DateTimeColumn get eventDate => dateTime()();
  DateTimeColumn get startDatetime => dateTime()();
  DateTimeColumn get endDatetime => dateTime()();
  TextColumn get eventStatus =>
      text().withDefault(const Constant('reserved'))();
  TextColumn get paymentStatus =>
      text().withDefault(const Constant('pending'))();
  TextColumn get gallerySlug => text()();
  TextColumn get notes => text().nullable()();
  TextColumn get paymentLink => text().nullable()();
  BoolColumn get synced => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

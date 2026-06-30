import 'package:drift/drift.dart';

import 'sessions_table.dart';

class ProcessingJobsTable extends Table {
  TextColumn get id => text()();
  TextColumn get sessionId =>
      text().references(SessionsTable, #id, onDelete: KeyAction.cascade)();
  TextColumn get assetId => text().nullable()();
  TextColumn get jobType => text()();
  IntColumn get priority => integer().withDefault(const Constant(0))();
  TextColumn get payload => text().withDefault(const Constant('{}'))();
  TextColumn get status => text().withDefault(const Constant('pending'))();
  RealColumn get progress => real().withDefault(const Constant(0.0))();
  IntColumn get attempts => integer().withDefault(const Constant(0))();
  TextColumn get errorMessage => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get finishedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

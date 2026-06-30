import 'package:drift/drift.dart';

import 'sessions_table.dart';

class SessionAssetsTable extends Table {
  TextColumn get id => text()();
  TextColumn get sessionId =>
      text().references(SessionsTable, #id, onDelete: KeyAction.cascade)();
  TextColumn get localPath => text()();
  IntColumn get fileSizeBytes =>
      integer().withDefault(const Constant(0))();
  IntColumn get durationMs => integer().withDefault(const Constant(0))();
  IntColumn get takeNumber => integer()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

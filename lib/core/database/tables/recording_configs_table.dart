import 'package:drift/drift.dart';

import 'events_table.dart';

class RecordingConfigsTable extends Table {
  TextColumn get id => text()();
  TextColumn get eventId =>
      text().references(EventsTable, #id, onDelete: KeyAction.cascade)();
  IntColumn get durationSeconds =>
      integer().withDefault(const Constant(30))();
  TextColumn get resolution =>
      text().withDefault(const Constant('1080p'))();
  TextColumn get cameraFacing =>
      text().withDefault(const Constant('back'))();
  TextColumn get quality => text().withDefault(const Constant('high'))();
  TextColumn get defaultEffects =>
      text().withDefault(const Constant('[]'))();
  IntColumn get maxTakesPerSession =>
      integer().withDefault(const Constant(3))();
  IntColumn get countdownSeconds =>
      integer().withDefault(const Constant(3))();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<Set<Column>> get uniqueKeys => [
        {eventId}
      ];
}

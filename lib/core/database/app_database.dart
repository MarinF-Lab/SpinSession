import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'tables/event_settings_table.dart';
import 'tables/event_templates_table.dart';
import 'tables/events_table.dart';
import 'tables/processing_jobs_table.dart';
import 'tables/recording_configs_table.dart';
import 'tables/session_assets_table.dart';
import 'tables/sessions_table.dart';
import 'tables/sync_jobs_table.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    EventTemplatesTable,
    EventsTable,
    EventSettingsTable,
    SyncJobsTable,
    SessionsTable,
    SessionAssetsTable,
    RecordingConfigsTable,
    ProcessingJobsTable,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 5;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
        },
        onUpgrade: (m, from, to) async {
          await m.createAll();
          if (from < 5) {
            await m.addColumn(eventsTable, eventsTable.paymentLink);
          }
        },
      );

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'spinsession');
  }
}

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

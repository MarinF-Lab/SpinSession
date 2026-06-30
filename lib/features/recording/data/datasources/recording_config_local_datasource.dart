import '../../../../core/database/app_database.dart';
import '../../domain/entities/recording_config_entity.dart';
import '../models/recording_config_model.dart';

class RecordingConfigLocalDatasource {
  const RecordingConfigLocalDatasource(this._db);

  final AppDatabase _db;

  Future<RecordingConfigEntity?> getByEvent(String eventId) async {
    final row = await (_db.select(_db.recordingConfigsTable)
          ..where((t) => t.eventId.equals(eventId)))
        .getSingleOrNull();
    return row != null ? RecordingConfigModel.fromRow(row) : null;
  }

  Future<void> upsert(RecordingConfigEntity config) async {
    await _db
        .into(_db.recordingConfigsTable)
        .insertOnConflictUpdate(RecordingConfigModel.toCompanion(config));
  }
}

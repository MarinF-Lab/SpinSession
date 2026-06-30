import '../../domain/entities/recording_config_entity.dart';
import '../datasources/recording_config_local_datasource.dart';

class RecordingConfigRepository {
  const RecordingConfigRepository(this._local);

  final RecordingConfigLocalDatasource _local;

  Future<RecordingConfigEntity?> getByEvent(String eventId) =>
      _local.getByEvent(eventId);

  Future<void> save(RecordingConfigEntity config) => _local.upsert(config);
}

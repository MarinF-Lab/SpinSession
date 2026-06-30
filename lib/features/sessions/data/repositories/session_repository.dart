import '../../../../core/errors/app_failure.dart';
import '../../domain/entities/session_asset_entity.dart';
import '../../domain/entities/session_entity.dart';
import '../../domain/entities/session_status.dart';
import '../datasources/session_local_datasource.dart';

class SessionRepository {
  const SessionRepository(this._local);

  final SessionLocalDatasource _local;

  Future<List<SessionEntity>> getByEvent(String eventId) =>
      _local.getByEvent(eventId);

  Future<SessionEntity?> getById(String id) => _local.getById(id);

  Future<void> save(SessionEntity session) async {
    if (session.guestName.trim().isEmpty) {
      throw const AppFailure('El nombre del invitado es obligatorio.');
    }
    if (session.phone.trim().isEmpty) {
      throw const AppFailure('El número de teléfono es obligatorio.');
    }
    await _local.upsert(session);
  }

  Future<void> updateStatus(String id, SessionStatus status) =>
      _local.updateStatus(id, status);

  Future<void> delete(String id) => _local.delete(id);

  Future<List<SessionAssetEntity>> getAssets(String sessionId) =>
      _local.getAssets(sessionId);

  Future<void> addAsset(SessionAssetEntity asset) =>
      _local.insertAsset(asset);

  Future<void> deleteAsset(String assetId) => _local.deleteAsset(assetId);
}

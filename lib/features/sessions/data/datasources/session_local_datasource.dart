import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/session_asset_entity.dart';
import '../../domain/entities/session_entity.dart';
import '../../domain/entities/session_status.dart';
import '../models/session_asset_model.dart';
import '../models/session_model.dart';

class SessionLocalDatasource {
  const SessionLocalDatasource(this._db);

  final AppDatabase _db;

  Future<List<SessionEntity>> getByEvent(String eventId) async {
    final rows = await (_db.select(_db.sessionsTable)
          ..where((t) => t.eventId.equals(eventId))
          ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]))
        .get();
    return rows.map(SessionModel.fromRow).toList();
  }

  Future<SessionEntity?> getById(String id) async {
    final row = await (_db.select(_db.sessionsTable)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    return row != null ? SessionModel.fromRow(row) : null;
  }

  Future<void> upsert(SessionEntity session) async {
    await _db
        .into(_db.sessionsTable)
        .insertOnConflictUpdate(SessionModel.toCompanion(session));
  }

  Future<void> updateStatus(String id, SessionStatus status) async {
    await (_db.update(_db.sessionsTable)
          ..where((t) => t.id.equals(id)))
        .write(SessionsTableCompanion(status: Value(status.value)));
  }

  Future<void> delete(String id) async {
    await (_db.delete(_db.sessionsTable)
          ..where((t) => t.id.equals(id)))
        .go();
  }

  Future<List<SessionAssetEntity>> getAssets(String sessionId) async {
    final rows = await (_db.select(_db.sessionAssetsTable)
          ..where((t) => t.sessionId.equals(sessionId))
          ..orderBy([(t) => OrderingTerm.asc(t.takeNumber)]))
        .get();
    return rows.map(SessionAssetModel.fromRow).toList();
  }

  Future<void> insertAsset(SessionAssetEntity asset) async {
    await _db
        .into(_db.sessionAssetsTable)
        .insert(SessionAssetModel.toCompanion(asset));
  }

  Future<void> deleteAsset(String assetId) async {
    await (_db.delete(_db.sessionAssetsTable)
          ..where((t) => t.id.equals(assetId)))
        .go();
  }
}

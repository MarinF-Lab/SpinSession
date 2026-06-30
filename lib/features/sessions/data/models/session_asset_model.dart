import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/session_asset_entity.dart';

class SessionAssetModel {
  static SessionAssetEntity fromRow(SessionAssetsTableData row) {
    return SessionAssetEntity(
      id: row.id,
      sessionId: row.sessionId,
      localPath: row.localPath,
      fileSizeBytes: row.fileSizeBytes,
      durationMs: row.durationMs,
      takeNumber: row.takeNumber,
      createdAt: row.createdAt,
    );
  }

  static SessionAssetsTableCompanion toCompanion(SessionAssetEntity e) {
    return SessionAssetsTableCompanion(
      id: Value(e.id),
      sessionId: Value(e.sessionId),
      localPath: Value(e.localPath),
      fileSizeBytes: Value(e.fileSizeBytes),
      durationMs: Value(e.durationMs),
      takeNumber: Value(e.takeNumber),
      createdAt: Value(e.createdAt),
    );
  }
}

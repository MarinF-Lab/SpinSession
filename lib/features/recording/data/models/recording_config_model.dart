import 'dart:convert';

import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/recording_config_entity.dart';

class RecordingConfigModel {
  static RecordingConfigEntity fromRow(RecordingConfigsTableData row) {
    return RecordingConfigEntity(
      id: row.id,
      eventId: row.eventId,
      durationSeconds: row.durationSeconds,
      resolution: row.resolution,
      cameraFacing: row.cameraFacing,
      quality: row.quality,
      defaultEffects: List<String>.from(jsonDecode(row.defaultEffects)),
      maxTakesPerSession: row.maxTakesPerSession,
      countdownSeconds: row.countdownSeconds,
      updatedAt: row.updatedAt,
    );
  }

  static RecordingConfigsTableCompanion toCompanion(RecordingConfigEntity e) {
    return RecordingConfigsTableCompanion(
      id: Value(e.id),
      eventId: Value(e.eventId),
      durationSeconds: Value(e.durationSeconds),
      resolution: Value(e.resolution),
      cameraFacing: Value(e.cameraFacing),
      quality: Value(e.quality),
      defaultEffects: Value(jsonEncode(e.defaultEffects)),
      maxTakesPerSession: Value(e.maxTakesPerSession),
      countdownSeconds: Value(e.countdownSeconds),
      updatedAt: Value(e.updatedAt),
    );
  }
}

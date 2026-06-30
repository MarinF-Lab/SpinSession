import 'dart:convert';

import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/event_settings_entity.dart';

class EventSettingsModel {
  static EventSettingsEntity fromRow(EventSettingsTableData row) {
    final effects = (jsonDecode(row.defaultEffects) as List)
        .map((e) => e as String)
        .toList();
    return EventSettingsEntity(
      id: row.id,
      eventId: row.eventId,
      defaultDurationSeconds: row.defaultDurationSeconds,
      defaultEffects: effects,
      allowMultipleSessions: row.allowMultipleSessions,
      autoDeleteDays: row.autoDeleteDays,
      galleryName: row.galleryName,
      updatedAt: row.updatedAt,
    );
  }

  static EventSettingsTableCompanion toCompanion(EventSettingsEntity e) {
    return EventSettingsTableCompanion(
      id: Value(e.id),
      eventId: Value(e.eventId),
      defaultDurationSeconds: Value(e.defaultDurationSeconds),
      defaultEffects: Value(jsonEncode(e.defaultEffects)),
      allowMultipleSessions: Value(e.allowMultipleSessions),
      autoDeleteDays: Value(e.autoDeleteDays),
      galleryName: Value(e.galleryName),
      updatedAt: Value(e.updatedAt),
    );
  }
}

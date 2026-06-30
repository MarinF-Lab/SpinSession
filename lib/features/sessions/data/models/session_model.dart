import 'dart:convert';

import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/session_entity.dart';
import '../../domain/entities/session_status.dart';

class SessionModel {
  static SessionEntity fromRow(SessionsTableData row) {
    return SessionEntity(
      id: row.id,
      eventId: row.eventId,
      guestName: row.guestName,
      phone: row.phone,
      countryCode: row.countryCode,
      notes: row.notes,
      deviceId: row.deviceId,
      status: SessionStatus.fromString(row.status),
      durationSecondsOverride: row.durationSecondsOverride,
      effectsOverride: row.effectsOverride != null
          ? List<String>.from(jsonDecode(row.effectsOverride!))
          : null,
      countdownSecondsOverride: row.countdownSecondsOverride,
      maxTakesOverride: row.maxTakesOverride,
      createdAt: row.createdAt,
    );
  }

  static SessionsTableCompanion toCompanion(SessionEntity e) {
    return SessionsTableCompanion(
      id: Value(e.id),
      eventId: Value(e.eventId),
      guestName: Value(e.guestName),
      phone: Value(e.phone),
      countryCode: Value(e.countryCode),
      notes: Value(e.notes),
      deviceId: Value(e.deviceId),
      status: Value(e.status.value),
      durationSecondsOverride: Value(e.durationSecondsOverride),
      effectsOverride: Value(
        e.effectsOverride != null ? jsonEncode(e.effectsOverride) : null,
      ),
      countdownSecondsOverride: Value(e.countdownSecondsOverride),
      maxTakesOverride: Value(e.maxTakesOverride),
      createdAt: Value(e.createdAt),
    );
  }
}

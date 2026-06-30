import 'dart:convert';

import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/template_entity.dart';

class TemplateModel {
  static TemplateEntity fromRow(EventTemplatesTableData row) {
    final effects = (jsonDecode(row.defaultEffects) as List)
        .map((e) => e as String)
        .toList();
    return TemplateEntity(
      id: row.id,
      userId: row.userId,
      name: row.name,
      durationSeconds: row.durationSeconds,
      defaultEffects: effects,
      autoDeleteDays: row.autoDeleteDays,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }

  static EventTemplatesTableCompanion toCompanion(TemplateEntity e) {
    return EventTemplatesTableCompanion(
      id: Value(e.id),
      userId: Value(e.userId),
      name: Value(e.name),
      durationSeconds: Value(e.durationSeconds),
      defaultEffects: Value(jsonEncode(e.defaultEffects)),
      autoDeleteDays: Value(e.autoDeleteDays),
      createdAt: Value(e.createdAt),
      updatedAt: Value(e.updatedAt),
    );
  }

  static Map<String, dynamic> toSupabaseMap(TemplateEntity e) {
    return {
      'id': e.id,
      'user_id': e.userId,
      'name': e.name,
      'duration': e.durationSeconds,
      'default_effects': jsonEncode(e.defaultEffects),
      'auto_delete_days': e.autoDeleteDays,
      'created_at': e.createdAt.toIso8601String(),
      'updated_at': e.updatedAt.toIso8601String(),
    };
  }
}

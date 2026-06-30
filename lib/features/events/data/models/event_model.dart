import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/event_entity.dart';
import '../../domain/entities/event_status.dart';

class EventModel {
  static EventEntity fromRow(EventsTableData row) {
    return EventEntity(
      id: row.id,
      userId: row.userId,
      templateId: row.templateId,
      name: row.name,
      eventDate: row.eventDate,
      startDatetime: row.startDatetime,
      endDatetime: row.endDatetime,
      eventStatus: EventStatus.fromString(row.eventStatus),
      paymentStatus: PaymentStatus.fromString(row.paymentStatus),
      gallerySlug: row.gallerySlug,
      notes: row.notes,
      synced: row.synced,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }

  static EventsTableCompanion toCompanion(EventEntity e) {
    return EventsTableCompanion(
      id: Value(e.id),
      userId: Value(e.userId),
      templateId: Value(e.templateId),
      name: Value(e.name),
      eventDate: Value(e.eventDate),
      startDatetime: Value(e.startDatetime),
      endDatetime: Value(e.endDatetime),
      eventStatus: Value(e.eventStatus.value),
      paymentStatus: Value(e.paymentStatus.name),
      gallerySlug: Value(e.gallerySlug),
      notes: Value(e.notes),
      synced: Value(e.synced),
      createdAt: Value(e.createdAt),
      updatedAt: Value(e.updatedAt),
    );
  }

  static Map<String, dynamic> toSupabaseMap(EventEntity e) {
    return {
      'id': e.id,
      'user_id': e.userId,
      'template_id': e.templateId,
      'name': e.name,
      'event_date': e.eventDate.toIso8601String(),
      'start_datetime': e.startDatetime.toIso8601String(),
      'end_datetime': e.endDatetime.toIso8601String(),
      'event_status': e.eventStatus.value,
      'payment_status': e.paymentStatus.name,
      'gallery_slug': e.gallerySlug,
      'notes': e.notes,
      'created_at': e.createdAt.toIso8601String(),
      'updated_at': e.updatedAt.toIso8601String(),
    };
  }

  static EventEntity fromSupabaseMap(Map<String, dynamic> map) {
    return EventEntity(
      id: map['id'] as String,
      userId: map['user_id'] as String,
      templateId: map['template_id'] as String?,
      name: map['name'] as String,
      eventDate: DateTime.parse(map['event_date'] as String),
      startDatetime: DateTime.parse(map['start_datetime'] as String),
      endDatetime: DateTime.parse(map['end_datetime'] as String),
      eventStatus: EventStatus.fromString(map['event_status'] as String),
      paymentStatus: PaymentStatus.fromString(map['payment_status'] as String),
      gallerySlug: map['gallery_slug'] as String,
      notes: map['notes'] as String?,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }
}

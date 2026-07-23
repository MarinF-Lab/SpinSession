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
      paymentLink: row.paymentLink,
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
      paymentLink: Value(e.paymentLink),
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
      // `event_date` es una fecha de calendario (sin hora). Se envía como
      // medianoche UTC del día elegido para que, al volver del servidor,
      // conserve el mismo día independientemente de la zona horaria.
      'event_date': _dateOnly(e.eventDate),
      // Los instantes reales viajan en UTC y se reconvierten a local al leer.
      'start_datetime': e.startDatetime.toUtc().toIso8601String(),
      'end_datetime': e.endDatetime.toUtc().toIso8601String(),
      'event_status': e.eventStatus.value,
      'payment_status': e.paymentStatus.name,
      'gallery_slug': e.gallerySlug,
      'notes': e.notes,
      'payment_link': e.paymentLink,
      'created_at': e.createdAt.toUtc().toIso8601String(),
      'updated_at': e.updatedAt.toUtc().toIso8601String(),
    };
  }

  static EventEntity fromSupabaseMap(Map<String, dynamic> map) {
    return EventEntity(
      id: map['id'] as String,
      userId: map['user_id'] as String,
      templateId: map['template_id'] as String?,
      name: map['name'] as String,
      eventDate: _parseDateOnly(map['event_date'] as String),
      startDatetime: DateTime.parse(map['start_datetime'] as String).toLocal(),
      endDatetime: DateTime.parse(map['end_datetime'] as String).toLocal(),
      eventStatus: EventStatus.fromString(map['event_status'] as String),
      paymentStatus: PaymentStatus.fromString(map['payment_status'] as String),
      gallerySlug: map['gallery_slug'] as String,
      notes: map['notes'] as String?,
      paymentLink: map['payment_link'] as String?,
      createdAt: DateTime.parse(map['created_at'] as String).toLocal(),
      updatedAt: DateTime.parse(map['updated_at'] as String).toLocal(),
    );
  }

  /// Serializa solo la parte de fecha (año-mes-día) a medianoche UTC, para
  /// que una fecha de calendario no se desplace de día al cruzar zonas.
  static String _dateOnly(DateTime d) {
    final utc = DateTime.utc(d.year, d.month, d.day);
    return utc.toIso8601String();
  }

  /// Lee una fecha de calendario tomando sus componentes año-mes-día tal
  /// cual (sin desplazamiento horario) y la reconstruye como fecha local.
  static DateTime _parseDateOnly(String raw) {
    final parsed = DateTime.parse(raw);
    return DateTime(parsed.year, parsed.month, parsed.day);
  }
}

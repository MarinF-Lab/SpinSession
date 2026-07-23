import 'event_status.dart';

class EventEntity {
  const EventEntity({
    required this.id,
    required this.userId,
    required this.name,
    required this.eventDate,
    required this.startDatetime,
    required this.endDatetime,
    required this.eventStatus,
    required this.paymentStatus,
    required this.gallerySlug,
    required this.createdAt,
    required this.updatedAt,
    this.templateId,
    this.notes,
    this.paymentLink,
    this.synced = false,
  });

  final String id;
  final String userId;
  final String? templateId;
  final String name;
  final DateTime eventDate;
  final DateTime startDatetime;
  final DateTime endDatetime;
  final EventStatus eventStatus;
  final PaymentStatus paymentStatus;
  final String gallerySlug;
  final String? notes;
  final String? paymentLink;
  final bool synced;
  final DateTime createdAt;
  final DateTime updatedAt;

  Duration get duration => endDatetime.difference(startDatetime);

  bool get isActive => eventStatus == EventStatus.active;
  bool get isPaid => paymentStatus == PaymentStatus.paid;

  EventEntity copyWith({
    String? name,
    DateTime? eventDate,
    DateTime? startDatetime,
    DateTime? endDatetime,
    EventStatus? eventStatus,
    PaymentStatus? paymentStatus,
    String? notes,
    String? templateId,
    String? paymentLink,
    bool? synced,
    DateTime? updatedAt,
  }) {
    return EventEntity(
      id: id,
      userId: userId,
      name: name ?? this.name,
      eventDate: eventDate ?? this.eventDate,
      startDatetime: startDatetime ?? this.startDatetime,
      endDatetime: endDatetime ?? this.endDatetime,
      eventStatus: eventStatus ?? this.eventStatus,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      gallerySlug: gallerySlug,
      notes: notes ?? this.notes,
      templateId: templateId ?? this.templateId,
      paymentLink: paymentLink ?? this.paymentLink,
      synced: synced ?? this.synced,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

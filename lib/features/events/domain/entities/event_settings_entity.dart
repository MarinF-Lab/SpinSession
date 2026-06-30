class EventSettingsEntity {
  const EventSettingsEntity({
    required this.id,
    required this.eventId,
    required this.defaultDurationSeconds,
    required this.defaultEffects,
    required this.allowMultipleSessions,
    required this.updatedAt,
    this.autoDeleteDays,
    this.galleryName,
  });

  final String id;
  final String eventId;
  final int defaultDurationSeconds;
  final List<String> defaultEffects;
  final bool allowMultipleSessions;
  final int? autoDeleteDays;
  final String? galleryName;
  final DateTime updatedAt;

  EventSettingsEntity copyWith({
    int? defaultDurationSeconds,
    List<String>? defaultEffects,
    bool? allowMultipleSessions,
    int? autoDeleteDays,
    String? galleryName,
    DateTime? updatedAt,
  }) {
    return EventSettingsEntity(
      id: id,
      eventId: eventId,
      defaultDurationSeconds:
          defaultDurationSeconds ?? this.defaultDurationSeconds,
      defaultEffects: defaultEffects ?? this.defaultEffects,
      allowMultipleSessions:
          allowMultipleSessions ?? this.allowMultipleSessions,
      autoDeleteDays: autoDeleteDays ?? this.autoDeleteDays,
      galleryName: galleryName ?? this.galleryName,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

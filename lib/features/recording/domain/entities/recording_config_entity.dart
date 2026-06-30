class RecordingConfigEntity {
  const RecordingConfigEntity({
    required this.id,
    required this.eventId,
    required this.updatedAt,
    this.durationSeconds = 30,
    this.resolution = '1080p',
    this.cameraFacing = 'back',
    this.quality = 'high',
    this.defaultEffects = const [],
    this.maxTakesPerSession = 3,
    this.countdownSeconds = 3,
  });

  final String id;
  final String eventId;
  final int durationSeconds;
  final String resolution;
  final String cameraFacing;
  final String quality;
  final List<String> defaultEffects;
  final int maxTakesPerSession;
  final int countdownSeconds;
  final DateTime updatedAt;

  RecordingConfigEntity copyWith({
    int? durationSeconds,
    String? resolution,
    String? cameraFacing,
    String? quality,
    List<String>? defaultEffects,
    int? maxTakesPerSession,
    int? countdownSeconds,
  }) {
    return RecordingConfigEntity(
      id: id,
      eventId: eventId,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      resolution: resolution ?? this.resolution,
      cameraFacing: cameraFacing ?? this.cameraFacing,
      quality: quality ?? this.quality,
      defaultEffects: defaultEffects ?? this.defaultEffects,
      maxTakesPerSession: maxTakesPerSession ?? this.maxTakesPerSession,
      countdownSeconds: countdownSeconds ?? this.countdownSeconds,
      updatedAt: DateTime.now(),
    );
  }
}

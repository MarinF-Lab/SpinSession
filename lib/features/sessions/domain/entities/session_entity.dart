import 'session_status.dart';

class SessionEntity {
  const SessionEntity({
    required this.id,
    required this.eventId,
    required this.guestName,
    required this.phone,
    required this.countryCode,
    required this.deviceId,
    required this.status,
    required this.createdAt,
    this.notes,
    this.durationSecondsOverride,
    this.effectsOverride,
    this.countdownSecondsOverride,
    this.maxTakesOverride,
  });

  final String id;
  final String eventId;
  final String guestName;
  final String phone;
  final String countryCode;
  final String? notes;
  final String deviceId;
  final SessionStatus status;
  final int? durationSecondsOverride;
  final List<String>? effectsOverride;
  final int? countdownSecondsOverride;
  final int? maxTakesOverride;
  final DateTime createdAt;

  SessionEntity copyWith({
    SessionStatus? status,
    int? durationSecondsOverride,
    List<String>? effectsOverride,
    int? countdownSecondsOverride,
    int? maxTakesOverride,
  }) {
    return SessionEntity(
      id: id,
      eventId: eventId,
      guestName: guestName,
      phone: phone,
      countryCode: countryCode,
      notes: notes,
      deviceId: deviceId,
      status: status ?? this.status,
      durationSecondsOverride:
          durationSecondsOverride ?? this.durationSecondsOverride,
      effectsOverride: effectsOverride ?? this.effectsOverride,
      countdownSecondsOverride:
          countdownSecondsOverride ?? this.countdownSecondsOverride,
      maxTakesOverride: maxTakesOverride ?? this.maxTakesOverride,
      createdAt: createdAt,
    );
  }
}

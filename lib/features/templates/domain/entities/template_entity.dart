class TemplateEntity {
  const TemplateEntity({
    required this.id,
    required this.userId,
    required this.name,
    required this.durationSeconds,
    required this.defaultEffects,
    required this.createdAt,
    required this.updatedAt,
    this.autoDeleteDays,
  });

  final String id;
  final String userId;
  final String name;
  final int durationSeconds;
  final List<String> defaultEffects;
  final int? autoDeleteDays;
  final DateTime createdAt;
  final DateTime updatedAt;

  TemplateEntity copyWith({
    String? name,
    int? durationSeconds,
    List<String>? defaultEffects,
    int? autoDeleteDays,
    DateTime? updatedAt,
  }) {
    return TemplateEntity(
      id: id,
      userId: userId,
      name: name ?? this.name,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      defaultEffects: defaultEffects ?? this.defaultEffects,
      autoDeleteDays: autoDeleteDays ?? this.autoDeleteDays,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

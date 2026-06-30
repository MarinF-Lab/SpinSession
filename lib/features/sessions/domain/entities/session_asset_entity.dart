class SessionAssetEntity {
  const SessionAssetEntity({
    required this.id,
    required this.sessionId,
    required this.localPath,
    required this.takeNumber,
    required this.createdAt,
    this.fileSizeBytes = 0,
    this.durationMs = 0,
  });

  final String id;
  final String sessionId;
  final String localPath;
  final int fileSizeBytes;
  final int durationMs;
  final int takeNumber;
  final DateTime createdAt;
}

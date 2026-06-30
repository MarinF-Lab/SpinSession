import 'job_status.dart';
import 'job_type.dart';

class ProcessingJobEntity {
  const ProcessingJobEntity({
    required this.id,
    required this.sessionId,
    this.assetId,
    required this.jobType,
    this.priority = 0,
    this.payload = const {},
    this.status = JobStatus.pending,
    this.progress = 0.0,
    this.attempts = 0,
    this.errorMessage,
    required this.createdAt,
    required this.updatedAt,
    this.finishedAt,
  });

  final String id;
  final String sessionId;
  final String? assetId;
  final JobType jobType;
  final int priority;
  final Map<String, dynamic> payload;
  final JobStatus status;
  final double progress;
  final int attempts;
  final String? errorMessage;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? finishedAt;

  ProcessingJobEntity copyWith({
    JobStatus? status,
    double? progress,
    int? attempts,
    String? errorMessage,
    DateTime? updatedAt,
    DateTime? finishedAt,
  }) {
    return ProcessingJobEntity(
      id: id,
      sessionId: sessionId,
      assetId: assetId,
      jobType: jobType,
      priority: priority,
      payload: payload,
      status: status ?? this.status,
      progress: progress ?? this.progress,
      attempts: attempts ?? this.attempts,
      errorMessage: errorMessage ?? this.errorMessage,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      finishedAt: finishedAt ?? this.finishedAt,
    );
  }
}

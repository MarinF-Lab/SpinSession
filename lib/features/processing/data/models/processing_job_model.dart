import 'dart:convert';

import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/job_status.dart';
import '../../domain/entities/job_type.dart';
import '../../domain/entities/processing_job_entity.dart';

class ProcessingJobModel {
  static ProcessingJobEntity fromRow(ProcessingJobsTableData row) {
    return ProcessingJobEntity(
      id: row.id,
      sessionId: row.sessionId,
      assetId: row.assetId,
      jobType: JobType.fromString(row.jobType),
      priority: row.priority,
      payload: jsonDecode(row.payload) as Map<String, dynamic>,
      status: JobStatus.fromString(row.status),
      progress: row.progress,
      attempts: row.attempts,
      errorMessage: row.errorMessage,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
      finishedAt: row.finishedAt,
    );
  }

  static ProcessingJobsTableCompanion toCompanion(ProcessingJobEntity e) {
    return ProcessingJobsTableCompanion(
      id: Value(e.id),
      sessionId: Value(e.sessionId),
      assetId: Value(e.assetId),
      jobType: Value(e.jobType.value),
      priority: Value(e.priority),
      payload: Value(jsonEncode(e.payload)),
      status: Value(e.status.name),
      progress: Value(e.progress),
      attempts: Value(e.attempts),
      errorMessage: Value(e.errorMessage),
      createdAt: Value(e.createdAt),
      updatedAt: Value(e.updatedAt),
      finishedAt: Value(e.finishedAt),
    );
  }
}

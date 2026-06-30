import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/job_status.dart';
import '../../domain/entities/processing_job_entity.dart';
import '../models/processing_job_model.dart';

class ProcessingJobLocalDatasource {
  ProcessingJobLocalDatasource(this._db);

  final AppDatabase _db;

  Stream<List<ProcessingJobEntity>> watchBySession(String sessionId) {
    return (_db.select(_db.processingJobsTable)
          ..where((t) => t.sessionId.equals(sessionId))
          ..orderBy([(t) => OrderingTerm.desc(t.priority),
                     (t) => OrderingTerm.asc(t.createdAt)]))
        .watch()
        .map((rows) => rows.map(ProcessingJobModel.fromRow).toList());
  }

  Future<List<ProcessingJobEntity>> getPending() async {
    final rows = await (_db.select(_db.processingJobsTable)
          ..where((t) => t.status.isIn([
                JobStatus.pending.name,
                JobStatus.queued.name,
                JobStatus.retrying.name,
              ]))
          ..orderBy([
            (t) => OrderingTerm.desc(t.priority),
            (t) => OrderingTerm.asc(t.createdAt),
          ]))
        .get();
    return rows.map(ProcessingJobModel.fromRow).toList();
  }

  Future<ProcessingJobEntity?> getNextPending() async {
    final rows = await (_db.select(_db.processingJobsTable)
          ..where((t) => t.status.isIn([
                JobStatus.pending.name,
                JobStatus.queued.name,
                JobStatus.retrying.name,
              ]))
          ..orderBy([
            (t) => OrderingTerm.desc(t.priority),
            (t) => OrderingTerm.asc(t.createdAt),
          ])
          ..limit(1))
        .get();
    if (rows.isEmpty) return null;
    return ProcessingJobModel.fromRow(rows.first);
  }

  Future<void> upsert(ProcessingJobEntity job) async {
    await _db.into(_db.processingJobsTable).insertOnConflictUpdate(
          ProcessingJobModel.toCompanion(job),
        );
  }

  Future<void> updateStatus(String id, JobStatus status) async {
    await (_db.update(_db.processingJobsTable)..where((t) => t.id.equals(id)))
        .write(ProcessingJobsTableCompanion(
      status: Value(status.name),
      updatedAt: Value(DateTime.now()),
    ));
  }

  Future<void> updateProgress(String id, double progress) async {
    await (_db.update(_db.processingJobsTable)..where((t) => t.id.equals(id)))
        .write(ProcessingJobsTableCompanion(
      progress: Value(progress),
      updatedAt: Value(DateTime.now()),
    ));
  }

  Future<void> markCompleted(String id) async {
    final now = DateTime.now();
    await (_db.update(_db.processingJobsTable)..where((t) => t.id.equals(id)))
        .write(ProcessingJobsTableCompanion(
      status: Value(JobStatus.completed.name),
      progress: const Value(1.0),
      updatedAt: Value(now),
      finishedAt: Value(now),
    ));
  }

  Future<void> markFailed(String id, String error, int attempts) async {
    await (_db.update(_db.processingJobsTable)..where((t) => t.id.equals(id)))
        .write(ProcessingJobsTableCompanion(
      status: Value(JobStatus.failed.name),
      errorMessage: Value(error),
      attempts: Value(attempts),
      updatedAt: Value(DateTime.now()),
    ));
  }

  Future<void> markRetrying(String id, int attempts) async {
    await (_db.update(_db.processingJobsTable)..where((t) => t.id.equals(id)))
        .write(ProcessingJobsTableCompanion(
      status: Value(JobStatus.retrying.name),
      attempts: Value(attempts),
      updatedAt: Value(DateTime.now()),
    ));
  }

  Future<bool> areAllMediaJobsComplete(String sessionId) async {
    final mediaTypes = [
      'generate_thumbnail', 'generate_slow_motion', 'generate_reverse',
      'generate_boomerang', 'generate_burst',
    ];
    final incomplete = await (_db.select(_db.processingJobsTable)
          ..where((t) =>
              t.sessionId.equals(sessionId) &
              t.jobType.isIn(mediaTypes) &
              t.status.isNotIn(['completed', 'failed'])))
        .get();
    return incomplete.isEmpty;
  }

  Future<bool> hasSyncJobs(String sessionId) async {
    final syncTypes = [
      'upload_asset', 'sync_session', 'generate_private_session',
      'generate_gallery', 'send_whatsapp', 'cleanup_storage',
    ];
    final rows = await (_db.select(_db.processingJobsTable)
          ..where((t) =>
              t.sessionId.equals(sessionId) & t.jobType.isIn(syncTypes))
          ..limit(1))
        .get();
    return rows.isNotEmpty;
  }

  Future<List<ProcessingJobEntity>> getCompletedMediaJobs(
      String sessionId) async {
    final mediaTypes = [
      'generate_thumbnail', 'generate_slow_motion', 'generate_reverse',
      'generate_boomerang', 'generate_burst',
    ];
    final rows = await (_db.select(_db.processingJobsTable)
          ..where((t) =>
              t.sessionId.equals(sessionId) &
              t.jobType.isIn(mediaTypes) &
              t.status.equals('completed')))
        .get();
    return rows.map(ProcessingJobModel.fromRow).toList();
  }
}

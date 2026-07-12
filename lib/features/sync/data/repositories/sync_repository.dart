import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';

import '../../../../core/logging/app_logger.dart';
import '../../../processing/data/datasources/processing_job_local_datasource.dart';
import '../../../processing/domain/entities/job_status.dart';
import '../../../processing/domain/entities/job_type.dart';
import '../../../processing/domain/entities/processing_job_entity.dart';
import '../../../sessions/data/datasources/session_local_datasource.dart';
import '../../../sessions/domain/entities/session_status.dart';

class SyncRepository {
  SyncRepository(this._jobDatasource, this._sessionDatasource);

  final ProcessingJobLocalDatasource _jobDatasource;
  final SessionLocalDatasource _sessionDatasource;
  static const _uuid = Uuid();

  Future<bool> areAllMediaJobsComplete(String sessionId) =>
      _jobDatasource.areAllMediaJobsComplete(sessionId);

  Future<bool> hasSyncJobs(String sessionId) =>
      _jobDatasource.hasSyncJobs(sessionId);

  Future<void> createSyncJobsForSession(String sessionId) async {
    final alreadyQueued = await _jobDatasource.hasSyncJobs(sessionId);
    if (alreadyQueued) return;

    final session = await _sessionDatasource.getById(sessionId);
    if (session == null) return;

    final completedJobs =
        await _jobDatasource.getCompletedMediaJobs(sessionId);
    final now = DateTime.now();

    // Upload jobs for each completed media output
    for (final job in completedJobs) {
      final localPath = _resolveOutputPath(job);
      if (localPath == null) continue;
      if (!File(localPath).existsSync()) continue;

      final fileName = p.basename(localPath);
      final takeNumber = _takeNumberFromPath(localPath);
      final remotePath =
          'sessions/$sessionId/$takeNumber/$fileName';

      await _jobDatasource.upsert(ProcessingJobEntity(
        id: _uuid.v4(),
        sessionId: sessionId,
        assetId: job.assetId,
        jobType: JobType.uploadAsset,
        priority: -1,
        payload: {
          'localPath': localPath,
          'remotePath': remotePath,
          'jobType': job.jobType.value,
          'takeNumber': takeNumber,
        },
        status: JobStatus.pending,
        createdAt: now,
        updatedAt: now,
      ));
    }

    // sync_session
    await _jobDatasource.upsert(ProcessingJobEntity(
      id: _uuid.v4(),
      sessionId: sessionId,
      jobType: JobType.syncSession,
      priority: -2,
      payload: {'sessionId': sessionId},
      status: JobStatus.pending,
      createdAt: now,
      updatedAt: now,
    ));

    // generate_private_session
    await _jobDatasource.upsert(ProcessingJobEntity(
      id: _uuid.v4(),
      sessionId: sessionId,
      jobType: JobType.generatePrivateSession,
      priority: -3,
      payload: {
        'sessionId': sessionId,
        'phone': session.phone,
        'countryCode': session.countryCode,
        'guestName': session.guestName,
      },
      status: JobStatus.pending,
      createdAt: now,
      updatedAt: now,
    ));

    // generate_gallery
    await _jobDatasource.upsert(ProcessingJobEntity(
      id: _uuid.v4(),
      sessionId: sessionId,
      jobType: JobType.generateGallery,
      priority: -4,
      payload: {'eventId': session.eventId},
      status: JobStatus.pending,
      createdAt: now,
      updatedAt: now,
    ));

    // Nota: el envío por WhatsApp ya NO se encola automáticamente. Es una
    // acción disparada por el usuario (al elegir "esperar y enviar" tras
    // confirmar, o manualmente desde el Registro), porque el mensaje es
    // semiautomático y requiere que la app esté en primer plano.

    // cleanup_storage
    await _jobDatasource.upsert(ProcessingJobEntity(
      id: _uuid.v4(),
      sessionId: sessionId,
      jobType: JobType.cleanupStorage,
      priority: -6,
      payload: {'sessionId': sessionId},
      status: JobStatus.pending,
      createdAt: now,
      updatedAt: now,
    ));

    await _sessionDatasource.updateStatus(sessionId, SessionStatus.pendingSync);
    AppLogger.info('Sync', 'Jobs de sincronización creados para sesión $sessionId');
  }

  String? _resolveOutputPath(ProcessingJobEntity job) {
    if (job.jobType == JobType.generateBurst) {
      return job.payload['outputDir'] as String?;
    }
    return job.payload['outputPath'] as String?;
  }

  int _takeNumberFromPath(String path) {
    final parts = path.split('/');
    for (int i = parts.length - 2; i >= 0; i--) {
      final n = int.tryParse(parts[i]);
      if (n != null) return n;
    }
    return 1;
  }
}

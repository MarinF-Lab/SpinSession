import '../../../../core/logging/app_logger.dart';
import '../../../sessions/data/datasources/session_local_datasource.dart';
import '../../../sessions/domain/entities/session_status.dart';
import '../../../sync/data/repositories/sync_repository.dart';
import '../../../sync/data/services/storage_service.dart';
import '../../../sync/data/services/sync_service.dart';
import '../../domain/entities/job_status.dart';
import '../../domain/entities/job_type.dart';
import '../../domain/entities/processing_job_entity.dart';
import '../repositories/processing_repository.dart';
import 'ffmpeg_service.dart';

class TaskQueueService {
  TaskQueueService(
    this._repo,
    this._ffmpeg,
    this._storage,
    this._sync,
    this._syncRepo,
    this._sessionDatasource,
  );

  final ProcessingRepository _repo;
  final FFmpegService _ffmpeg;
  final StorageService _storage;
  final SyncService _sync;
  final SyncRepository _syncRepo;
  final SessionLocalDatasource _sessionDatasource;

  bool _isRunning = false;
  bool _isProcessing = false;

  void start() {
    if (_isRunning) return;
    _isRunning = true;
    _processNext();
  }

  void stop() => _isRunning = false;

  Future<void> resumePending() async {
    final pending = await _repo.getPending();
    if (pending.isEmpty) return;
    _isRunning = true;
    _processNext();
  }

  Future<void> _processNext() async {
    if (!_isRunning || _isProcessing) return;
    _isProcessing = true;

    try {
      final job = await _repo.getNextPending();
      if (job == null) {
        _isRunning = false;
        return;
      }

      await _repo.updateStatus(job.id, JobStatus.running);
      final success = await _executeJob(job);

      if (success) {
        await _repo.markCompleted(job.id);
        AppLogger.info('TaskQueue', 'Job completado: ${job.jobType.name}');
        if (job.jobType.isMediaJob) {
          await _triggerSyncIfReady(job.sessionId);
        }
      } else {
        final nextAttempts = job.attempts + 1;
        if (nextAttempts >= 3) {
          await _repo.markFailed(
              job.id, 'Máximo de reintentos alcanzado', nextAttempts);
          AppLogger.error('TaskQueue',
              'Job agotó reintentos: ${job.jobType.name} (${job.id})');
        } else {
          await _repo.markRetrying(job.id, nextAttempts);
          AppLogger.warning('TaskQueue',
              'Reintentando job ${job.jobType.name} (intento $nextAttempts)');
        }
      }
    } catch (error) {
      AppLogger.error('TaskQueue', 'Excepción inesperada en cola', error);
      // Continúa con el siguiente job aunque el actual falle inesperadamente
    } finally {
      _isProcessing = false;
      if (_isRunning) _processNext();
    }
  }

  Future<void> _triggerSyncIfReady(String sessionId) async {
    final allDone = await _syncRepo.areAllMediaJobsComplete(sessionId);
    if (allDone) {
      await _syncRepo.createSyncJobsForSession(sessionId);
    }
  }

  Future<bool> _executeJob(ProcessingJobEntity job) async {
    final payload = job.payload;

    try {
      switch (job.jobType) {
        // ── Sprint 4: FFmpeg ────────────────────────────────────────────────
        case JobType.generateThumbnail:
          return await _ffmpeg.generateThumbnail(
            payload['inputPath']!,
            payload['outputPath']!,
            (p) => _updateProgress(job.id, p),
          );
        case JobType.generateSlowMotion:
          return await _ffmpeg.generateSlowMotion(
            payload['inputPath']!,
            payload['outputPath']!,
            (p) => _updateProgress(job.id, p),
          );
        case JobType.generateReverse:
          return await _ffmpeg.generateReverse(
            payload['inputPath']!,
            payload['outputPath']!,
            (p) => _updateProgress(job.id, p),
          );
        case JobType.generateBoomerang:
          return await _ffmpeg.generateBoomerang(
            payload['inputPath']!,
            payload['outputPath']!,
            (p) => _updateProgress(job.id, p),
          );
        case JobType.generateBurst:
          return await _ffmpeg.generateBurst(
            payload['inputPath']!,
            payload['outputDir']!,
            (p) => _updateProgress(job.id, p),
          );

        // ── Sprint 5: Sync ──────────────────────────────────────────────────
        case JobType.uploadAsset:
          return await _executeUploadAsset(job);
        case JobType.syncSession:
          return await _executeSyncSession(job);
        case JobType.generatePrivateSession:
          return await _executeGeneratePrivateSession(job);
        case JobType.generateGallery:
          return await _executeGenerateGallery(job);
        case JobType.sendWhatsapp:
          return await _executeSendWhatsapp(job);
        case JobType.cleanupStorage:
          return await _executeCleanup(job);
        case JobType.deleteExpiredAssets:
          return true; // Implementado en Sprint 6
      }
    } catch (error) {
      AppLogger.error(
          'TaskQueue', 'Fallo ejecutando ${job.jobType.name}', error);
      return false;
    }
  }

  Future<bool> _executeUploadAsset(ProcessingJobEntity job) async {
    final localPath = job.payload['localPath'] as String?;
    final remotePath = job.payload['remotePath'] as String?;
    final assetType = job.payload['jobType'] as String?;
    final takeNumber = job.payload['takeNumber'] as int?;
    if (localPath == null || remotePath == null) return false;

    await _updateProgress(job.id, 0.1);
    await _storage.uploadFile(localPath, remotePath);
    await _sync.syncAsset(
      id: job.assetId ?? job.id,
      sessionId: job.sessionId,
      localPath: localPath,
      remotePath: remotePath,
      assetType: assetType ?? 'unknown',
      takeNumber: takeNumber ?? 1,
    );
    await _updateProgress(job.id, 1.0);
    return true;
  }

  Future<bool> _executeSyncSession(ProcessingJobEntity job) async {
    final sessionId = job.payload['sessionId'] as String?;
    if (sessionId == null) return false;

    final session = await _sessionDatasource.getById(sessionId);
    if (session == null) return false;

    await _sync.syncSession(session);
    await _sessionDatasource.updateStatus(sessionId, SessionStatus.syncing);
    return true;
  }

  Future<bool> _executeGeneratePrivateSession(
      ProcessingJobEntity job) async {
    final sessionId = job.payload['sessionId'] as String?;
    if (sessionId == null) return false;

    // Verifica que el thumbnail ya esté disponible en Storage antes de
    // marcar la sesión como lista — session.html arma la página en vivo.
    try {
      await _storage.createSignedUrl('sessions/$sessionId/1/thumbnail.jpg');
      await _repo.updateStatus(job.id, JobStatus.running);
    } catch (error) {
      AppLogger.warning('TaskQueue',
          'Sesión privada: archivo aún no disponible en storage ($error)');
      return false;
    }

    await _sessionDatasource.updateStatus(sessionId, SessionStatus.synced);
    return true;
  }

  Future<bool> _executeGenerateGallery(ProcessingJobEntity job) async {
    // gallery.html arma la galería en vivo (consulta Supabase al abrirse),
    // no hace falta pre-generar nada del lado del dispositivo.
    return true;
  }

  Future<bool> _executeSendWhatsapp(ProcessingJobEntity job) async {
    final phone = job.payload['phone'] as String?;
    final countryCode = job.payload['countryCode'] as String?;
    final guestName = job.payload['guestName'] as String?;
    final sessionId = job.payload['sessionId'] as String?;
    if (phone == null || countryCode == null || sessionId == null) return false;

    await _sync.sendWhatsapp(
      phone: phone,
      countryCode: countryCode,
      sessionId: sessionId,
      guestName: guestName ?? 'invitado',
    );

    await _sessionDatasource.updateStatus(sessionId, SessionStatus.sent);
    return true;
  }

  Future<bool> _executeCleanup(ProcessingJobEntity job) async {
    // Limpieza de archivos temporales locales — Sprint 6 implementará reglas de retención
    await _sessionDatasource.updateStatus(
        job.sessionId, SessionStatus.completed);
    return true;
  }

  Future<void> _updateProgress(String jobId, double progress) async {
    await _repo.updateProgress(jobId, progress);
  }
}

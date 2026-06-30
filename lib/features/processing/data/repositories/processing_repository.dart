import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/job_status.dart';
import '../../domain/entities/job_type.dart';
import '../../domain/entities/processing_job_entity.dart';
import '../datasources/processing_job_local_datasource.dart';

class ProcessingRepository {
  ProcessingRepository(this._datasource);

  final ProcessingJobLocalDatasource _datasource;
  static const _uuid = Uuid();

  static const _jobTypes = [
    JobType.generateThumbnail,
    JobType.generateSlowMotion,
    JobType.generateReverse,
    JobType.generateBoomerang,
    JobType.generateBurst,
  ];

  static const _priorities = {
    JobType.generateThumbnail: 10,
    JobType.generateSlowMotion: 5,
    JobType.generateReverse: 4,
    JobType.generateBoomerang: 3,
    JobType.generateBurst: 2,
  };

  Stream<List<ProcessingJobEntity>> watchBySession(String sessionId) =>
      _datasource.watchBySession(sessionId);

  Future<List<ProcessingJobEntity>> getPending() =>
      _datasource.getPending();

  Future<ProcessingJobEntity?> getNextPending() =>
      _datasource.getNextPending();

  Future<void> createJobsForSession(
    String sessionId,
    List<({String id, String localPath, int takeNumber})> assets,
    String outputBaseDir,
  ) async {
    final now = DateTime.now();

    for (final asset in assets) {
      final assetOutDir = '$outputBaseDir/${asset.takeNumber}';

      for (final type in _jobTypes) {
        final outputPath = _outputPath(type, assetOutDir, asset.takeNumber);
        final payload = type == JobType.generateBurst
            ? {'inputPath': asset.localPath, 'outputDir': '$assetOutDir/burst'}
            : {'inputPath': asset.localPath, 'outputPath': outputPath};

        final job = ProcessingJobEntity(
          id: _uuid.v4(),
          sessionId: sessionId,
          assetId: asset.id,
          jobType: type,
          priority: _priorities[type] ?? 0,
          payload: payload,
          status: JobStatus.pending,
          createdAt: now,
          updatedAt: now,
        );

        await _datasource.upsert(job);
      }
    }
  }

  Future<void> updateStatus(String id, JobStatus status) =>
      _datasource.updateStatus(id, status);

  Future<void> updateProgress(String id, double progress) =>
      _datasource.updateProgress(id, progress);

  Future<void> markCompleted(String id) => _datasource.markCompleted(id);

  Future<void> markFailed(String id, String error, int attempts) =>
      _datasource.markFailed(id, error, attempts);

  Future<void> markRetrying(String id, int attempts) =>
      _datasource.markRetrying(id, attempts);

  static Future<String> resolveOutputBaseDir(String sessionId) async {
    final appDir = await getApplicationDocumentsDirectory();
    return '${appDir.path}/processing/$sessionId';
  }

  static String _outputPath(JobType type, String dir, int take) =>
      switch (type) {
        JobType.generateThumbnail => '$dir/thumbnail.jpg',
        JobType.generateSlowMotion => '$dir/slow_motion.mp4',
        JobType.generateReverse => '$dir/reverse.mp4',
        JobType.generateBoomerang => '$dir/boomerang.mp4',
        JobType.generateBurst => '$dir/burst',
        _ => dir,
      };
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/database/app_database.dart';
import '../../../sessions/data/datasources/session_local_datasource.dart';
import '../../../sync/data/repositories/sync_repository.dart';
import '../../../sync/data/services/storage_service.dart';
import '../../../sync/data/services/sync_service.dart';
import '../../data/datasources/processing_job_local_datasource.dart';
import '../../data/repositories/processing_repository.dart';
import '../../data/services/ffmpeg_service.dart';
import '../../data/services/task_queue_service.dart';
import '../../domain/entities/processing_job_entity.dart';

final processingRepositoryProvider = Provider<ProcessingRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return ProcessingRepository(ProcessingJobLocalDatasource(db));
});

final ffmpegServiceProvider = Provider<FFmpegService>((ref) => FFmpegService());

final storageServiceProvider = Provider<StorageService>((ref) {
  return StorageService(Supabase.instance.client);
});

final syncServiceProvider = Provider<SyncService>((ref) {
  return SyncService(Supabase.instance.client);
});

final syncRepositoryProvider = Provider<SyncRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return SyncRepository(
    ProcessingJobLocalDatasource(db),
    SessionLocalDatasource(db),
  );
});

final taskQueueServiceProvider = Provider<TaskQueueService>((ref) {
  final repo = ref.watch(processingRepositoryProvider);
  final ffmpeg = ref.watch(ffmpegServiceProvider);
  final storage = ref.watch(storageServiceProvider);
  final sync = ref.watch(syncServiceProvider);
  final syncRepo = ref.watch(syncRepositoryProvider);
  final db = ref.watch(appDatabaseProvider);
  return TaskQueueService(
    repo,
    ffmpeg,
    storage,
    sync,
    syncRepo,
    SessionLocalDatasource(db),
  );
});

final processingJobsBySessionProvider =
    StreamProvider.family<List<ProcessingJobEntity>, String>(
        (ref, sessionId) {
  final repo = ref.watch(processingRepositoryProvider);
  return repo.watchBySession(sessionId);
});

class ProcessingState {
  ProcessingState({
    required this.jobs,
    this.isLoading = false,
    this.errorMessage,
  });

  ProcessingState.initial() : this(jobs: const [], isLoading: true);

  final List<ProcessingJobEntity> jobs;
  final bool isLoading;
  final String? errorMessage;

  ProcessingState copyWith({
    List<ProcessingJobEntity>? jobs,
    bool? isLoading,
    String? errorMessage,
  }) {
    return ProcessingState(
      jobs: jobs ?? this.jobs,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

final processingControllerProvider =
    StateNotifierProvider<ProcessingController, ProcessingState>((ref) {
  final repo = ref.watch(processingRepositoryProvider);
  final queue = ref.watch(taskQueueServiceProvider);
  return ProcessingController(repo, queue);
});

class ProcessingController extends StateNotifier<ProcessingState> {
  ProcessingController(this._repo, this._queue)
      : super(ProcessingState.initial()) {
    _resumePending();
  }

  final ProcessingRepository _repo;
  final TaskQueueService _queue;

  Future<void> _resumePending() async {
    state = state.copyWith(isLoading: true);
    try {
      await _queue.resumePending();
      final jobs = await _repo.getPending();
      state = ProcessingState(jobs: jobs);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  void clearError() => state = state.copyWith(errorMessage: null);
}

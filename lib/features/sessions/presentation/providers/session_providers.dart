import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/preferences/local_preferences_repository.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../../processing/data/repositories/processing_repository.dart';
import '../../../processing/presentation/providers/processing_providers.dart'
    show
        processingRepositoryProvider,
        taskQueueServiceProvider,
        syncServiceProvider;
import '../../../recording/presentation/providers/recording_providers.dart'
    show recordingConfigRepositoryProvider;
import '../../data/datasources/session_local_datasource.dart';
import '../../data/repositories/session_repository.dart';
import '../../domain/entities/session_asset_entity.dart';
import '../../domain/entities/session_entity.dart';
import '../../domain/entities/session_status.dart';

final sessionRepositoryProvider = Provider<SessionRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return SessionRepository(SessionLocalDatasource(db));
});

final deviceIdProvider = FutureProvider<String>((ref) async {
  final prefs = ref.watch(localPreferencesRepositoryProvider);
  final existing = await prefs.readDeviceId();
  if (existing != null) return existing;
  final newId = const Uuid().v4();
  await prefs.saveDeviceId(newId);
  return newId;
});

final sessionsByEventProvider =
    FutureProvider.family<List<SessionEntity>, String>((ref, eventId) async {
  final repo = ref.watch(sessionRepositoryProvider);
  return repo.getByEvent(eventId);
});

final sessionByIdProvider =
    FutureProvider.family<SessionEntity?, String>((ref, id) async {
  final repo = ref.watch(sessionRepositoryProvider);
  return repo.getById(id);
});

final sessionAssetsBySessionProvider =
    FutureProvider.family<List<SessionAssetEntity>, String>(
        (ref, sessionId) async {
  final repo = ref.watch(sessionRepositoryProvider);
  return repo.getAssets(sessionId);
});

final sessionControllerProvider =
    StateNotifierProvider<SessionController, SessionState>((ref) {
  final repo = ref.watch(sessionRepositoryProvider);
  final userId = ref.watch(currentUserProvider) ?? '';
  return SessionController(repo, userId, ref);
});

class SessionState {
  const SessionState({
    required this.sessions,
    this.isLoading = false,
    this.errorMessage,
  });

  SessionState.initial() : this(sessions: const [], isLoading: true);

  final List<SessionEntity> sessions;
  final bool isLoading;
  final String? errorMessage;

  SessionState copyWith({
    List<SessionEntity>? sessions,
    bool? isLoading,
    String? errorMessage,
  }) {
    return SessionState(
      sessions: sessions ?? this.sessions,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

class SessionController extends StateNotifier<SessionState> {
  SessionController(this._repo, this._userId, this._ref)
      : super(SessionState.initial());

  final SessionRepository _repo;
  // ignore: unused_field
  final String _userId;
  final Ref _ref;
  static const _uuid = Uuid();

  Future<void> loadByEvent(String eventId) async {
    state = state.copyWith(isLoading: true);
    try {
      final sessions = await _repo.getByEvent(eventId);
      state = SessionState(sessions: sessions);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<SessionEntity?> createSession({
    required String eventId,
    required String guestName,
    required String phone,
    required String countryCode,
    String? notes,
  }) async {
    try {
      final deviceIdAsync = await _ref.read(deviceIdProvider.future);
      final session = SessionEntity(
        id: _uuid.v4(),
        eventId: eventId,
        guestName: guestName,
        phone: phone,
        countryCode: countryCode,
        notes: notes,
        deviceId: deviceIdAsync,
        status: SessionStatus.registered,
        createdAt: DateTime.now(),
      );
      await _repo.save(session);
      await loadByEvent(eventId);
      return session;
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
      return null;
    }
  }

  Future<void> updateStatus(String id, SessionStatus status) async {
    await _repo.updateStatus(id, status);
  }

  Future<void> addAsset({
    required String sessionId,
    required String localPath,
    required int takeNumber,
    int fileSizeBytes = 0,
    int durationMs = 0,
  }) async {
    final asset = SessionAssetEntity(
      id: _uuid.v4(),
      sessionId: sessionId,
      localPath: localPath,
      fileSizeBytes: fileSizeBytes,
      durationMs: durationMs,
      takeNumber: takeNumber,
      createdAt: DateTime.now(),
    );
    await _repo.addAsset(asset);
  }

  Future<void> confirmSession(String id, String eventId) async {
    await _repo.updateStatus(id, SessionStatus.confirmed);
    await _repo.updateStatus(id, SessionStatus.pendingProcessing);

    final assets = await _repo.getAssets(id);
    if (assets.isNotEmpty) {
      final processingRepo = _ref.read(processingRepositoryProvider);
      final queue = _ref.read(taskQueueServiceProvider);
      final outputBaseDir = await ProcessingRepository.resolveOutputBaseDir(id);
      final assetRefs = assets
          .map((a) => (id: a.id, localPath: a.localPath, takeNumber: a.takeNumber))
          .toList();
      final recordingConfig = await _ref
          .read(recordingConfigRepositoryProvider)
          .getByEvent(eventId);
      await processingRepo.createJobsForSession(
        id,
        assetRefs,
        outputBaseDir,
        activeEffects: recordingConfig?.defaultEffects ?? const [],
      );
      queue.start();
    }

    await loadByEvent(eventId);
  }

  Future<void> cancelSession(String id, String eventId) async {
    await _repo.delete(id);
    await loadByEvent(eventId);
  }

  /// Envía (o reenvía) los videos de la sesión por WhatsApp: abre/crea la
  /// conversación del invitado y luego dispara el selector nativo de
  /// Compartir con los archivos adjuntos. Marca la sesión como "enviada"
  /// al terminar.
  Future<bool> sendWhatsappForSession(SessionEntity session) async {
    try {
      final sync = _ref.read(syncServiceProvider);
      final filePaths = await _ref
          .read(processingRepositoryProvider)
          .getCompletedVideoPaths(session.id);

      await sync.sendWhatsapp(
        phone: session.phone,
        countryCode: session.countryCode,
        guestName: session.guestName,
        filePaths: filePaths,
      );
      await _repo.updateStatus(session.id, SessionStatus.sent);
      await loadByEvent(session.eventId);
      return true;
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
      return false;
    }
  }

  void clearError() => state = state.copyWith(errorMessage: null);
}

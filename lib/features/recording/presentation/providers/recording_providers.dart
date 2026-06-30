import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/app_database.dart';
import '../../../sessions/domain/entities/session_status.dart';
import '../../../sessions/presentation/providers/session_providers.dart';
import '../../data/datasources/recording_config_local_datasource.dart';
import '../../data/repositories/recording_config_repository.dart';
import '../../data/services/camera_service.dart';
import '../../domain/entities/recording_config_entity.dart';

final recordingConfigRepositoryProvider =
    Provider<RecordingConfigRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return RecordingConfigRepository(RecordingConfigLocalDatasource(db));
});

final recordingConfigProvider =
    FutureProvider.family<RecordingConfigEntity?, String>((ref, eventId) async {
  final repo = ref.watch(recordingConfigRepositoryProvider);
  return repo.getByEvent(eventId);
});

final cameraServiceProvider = Provider<CameraService>((ref) {
  final service = CameraService();
  ref.onDispose(service.dispose);
  return service;
});

final recordingControllerProvider =
    StateNotifierProvider<RecordingController, RecordingState>((ref) {
  final camera = ref.watch(cameraServiceProvider);
  return RecordingController(camera, ref);
});

class RecordingState {
  const RecordingState({
    this.isCameraReady = false,
    this.hasPermissions = false,
    this.isCountingDown = false,
    this.countdownRemaining = 0,
    this.isRecording = false,
    this.elapsedSeconds = 0,
    this.takes = const [],
    this.currentSessionId,
    this.currentEventId,
    this.error,
  });

  final bool isCameraReady;
  final bool hasPermissions;
  final bool isCountingDown;
  final int countdownRemaining;
  final bool isRecording;
  final int elapsedSeconds;
  final List<String> takes;
  final String? currentSessionId;
  final String? currentEventId;
  final String? error;

  int get takeCount => takes.length;

  RecordingState copyWith({
    bool? isCameraReady,
    bool? hasPermissions,
    bool? isCountingDown,
    int? countdownRemaining,
    bool? isRecording,
    int? elapsedSeconds,
    List<String>? takes,
    String? currentSessionId,
    String? currentEventId,
    String? error,
  }) {
    return RecordingState(
      isCameraReady: isCameraReady ?? this.isCameraReady,
      hasPermissions: hasPermissions ?? this.hasPermissions,
      isCountingDown: isCountingDown ?? this.isCountingDown,
      countdownRemaining: countdownRemaining ?? this.countdownRemaining,
      isRecording: isRecording ?? this.isRecording,
      elapsedSeconds: elapsedSeconds ?? this.elapsedSeconds,
      takes: takes ?? this.takes,
      currentSessionId: currentSessionId ?? this.currentSessionId,
      currentEventId: currentEventId ?? this.currentEventId,
      error: error,
    );
  }
}

class RecordingController extends StateNotifier<RecordingState> {
  RecordingController(this._camera, this._ref) : super(const RecordingState());

  final CameraService _camera;
  final Ref _ref;
  Timer? _countdownTimer;
  Timer? _elapsedTimer;
  CameraController? get cameraController => _camera.controller;

  Future<void> initCamera({
    required String eventId,
    required String? sessionId,
    required RecordingConfigEntity config,
  }) async {
    state = state.copyWith(error: null);
    try {
      final granted = await _camera.requestPermissions();
      if (!granted) {
        state = state.copyWith(
          error: 'Se requieren permisos de cámara y micrófono.',
        );
        return;
      }
      await _camera.initialize(
        useFrontCamera: config.cameraFacing == 'front',
        resolution: config.resolution,
      );
      state = state.copyWith(
        isCameraReady: true,
        hasPermissions: true,
        currentSessionId: sessionId,
        currentEventId: eventId,
      );
    } catch (e) {
      state = state.copyWith(
        error: 'Error al inicializar la cámara.',
      );
    }
  }

  Future<void> startCountdown(int seconds) async {
    if (!state.isCameraReady || state.isRecording) return;
    state = state.copyWith(
      isCountingDown: true,
      countdownRemaining: seconds,
    );
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (t) {
      final remaining = state.countdownRemaining - 1;
      if (remaining <= 0) {
        t.cancel();
        _startRecording();
      } else {
        state = state.copyWith(countdownRemaining: remaining);
      }
    });
  }

  Future<void> _startRecording() async {
    try {
      await _camera.startRecording();
      state = state.copyWith(
        isCountingDown: false,
        isRecording: true,
        elapsedSeconds: 0,
      );
      _elapsedTimer = Timer.periodic(const Duration(seconds: 1), (_) {
        state = state.copyWith(elapsedSeconds: state.elapsedSeconds + 1);
      });
    } catch (e) {
      state = state.copyWith(
        isCountingDown: false,
        error: 'No se pudo iniciar la grabación.',
      );
    }
  }

  Future<void> stopRecording() async {
    if (!state.isRecording) return;
    _elapsedTimer?.cancel();
    try {
      final path = await _camera.stopRecording();
      final updatedTakes = [...state.takes, path];
      state = state.copyWith(
        isRecording: false,
        elapsedSeconds: 0,
        takes: updatedTakes,
      );

      if (state.currentSessionId != null) {
        final sessionCtrl = _ref.read(sessionControllerProvider.notifier);
        await sessionCtrl.updateStatus(
          state.currentSessionId!,
          SessionStatus.pendingConfirmation,
        );
        await sessionCtrl.addAsset(
          sessionId: state.currentSessionId!,
          localPath: path,
          takeNumber: updatedTakes.length,
        );
      }
    } catch (e) {
      state = state.copyWith(
        isRecording: false,
        error: 'No se pudo detener la grabación.',
      );
    }
  }

  void deleteTake(int index) {
    if (index < 0 || index >= state.takes.length) return;
    final path = state.takes[index];
    try {
      File(path).deleteSync();
    } catch (_) {}
    final updated = [...state.takes]..removeAt(index);
    state = state.copyWith(takes: updated);
  }

  Future<void> clearAllTakes() async {
    _countdownTimer?.cancel();
    _elapsedTimer?.cancel();
    for (final path in state.takes) {
      try {
        await File(path).delete();
      } catch (_) {}
    }
    state = state.copyWith(
      takes: const [],
      isRecording: false,
      isCountingDown: false,
      elapsedSeconds: 0,
      countdownRemaining: 0,
    );
  }

  void prepareNewTake() {
    state = state.copyWith(
      isCountingDown: false,
      isRecording: false,
      elapsedSeconds: 0,
      countdownRemaining: 0,
    );
  }

  void clearError() => state = state.copyWith(error: null);

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _elapsedTimer?.cancel();
    super.dispose();
  }
}

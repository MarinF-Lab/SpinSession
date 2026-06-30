import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraService {
  CameraController? _controller;

  CameraController? get controller => _controller;

  bool get isInitialized => _controller?.value.isInitialized ?? false;
  bool get isRecording => _controller?.value.isRecordingVideo ?? false;

  Future<bool> requestPermissions() async {
    final camera = await Permission.camera.request();
    final microphone = await Permission.microphone.request();
    return camera.isGranted && microphone.isGranted;
  }

  Future<void> initialize({
    required bool useFrontCamera,
    required String resolution,
  }) async {
    await _controller?.dispose();
    _controller = null;

    final cameras = await availableCameras();
    if (cameras.isEmpty) throw Exception('No se encontraron cámaras.');

    final facing = useFrontCamera
        ? CameraLensDirection.front
        : CameraLensDirection.back;

    final camera = cameras.firstWhere(
      (c) => c.lensDirection == facing,
      orElse: () => cameras.first,
    );

    final preset = _resolutionPreset(resolution);
    _controller = CameraController(camera, preset, enableAudio: true);
    await _controller!.initialize();
  }

  Future<String> startRecording() async {
    if (_controller == null || !isInitialized) {
      throw Exception('La cámara no está inicializada.');
    }
    await _controller!.startVideoRecording();
    return '';
  }

  Future<String> stopRecording() async {
    if (_controller == null || !isRecording) {
      throw Exception('No hay grabación activa.');
    }
    final file = await _controller!.stopVideoRecording();
    return file.path;
  }

  Future<void> dispose() async {
    await _controller?.dispose();
    _controller = null;
  }

  ResolutionPreset _resolutionPreset(String resolution) => switch (resolution) {
        '4k' => ResolutionPreset.ultraHigh,
        '720p' => ResolutionPreset.high,
        _ => ResolutionPreset.veryHigh, // 1080p default
      };
}

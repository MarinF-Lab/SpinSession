import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../app/router/app_routes.dart';
import '../providers/recording_providers.dart';

class RecordingScreen extends ConsumerStatefulWidget {
  const RecordingScreen({
    super.key,
    required this.eventId,
    required this.sessionId,
    this.isSpinLab = false,
  });

  final String eventId;
  final String sessionId;
  final bool isSpinLab;

  @override
  ConsumerState<RecordingScreen> createState() => _RecordingScreenState();
}

class _RecordingScreenState extends ConsumerState<RecordingScreen> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(recordingControllerProvider);
    final controller =
        ref.read(recordingControllerProvider.notifier).cameraController;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          if (state.isCameraReady && controller != null)
            _CameraPreviewWidget(controller: controller),
          if (!state.isCameraReady)
            const Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
          if (state.error != null)
            _ErrorOverlay(message: state.error!),
          if (state.isCountingDown)
            _CountdownOverlay(count: state.countdownRemaining),
          _TopBar(
            isSpinLab: widget.isSpinLab,
            takeCount: state.takeCount,
          ),
          if (state.isRecording)
            _RecordingIndicator(elapsed: state.elapsedSeconds),
          _BottomControls(
            state: state,
            isSpinLab: widget.isSpinLab,
            eventId: widget.eventId,
            sessionId: widget.sessionId,
          ),
        ],
      ),
    );
  }
}

class _CameraPreviewWidget extends StatelessWidget {
  const _CameraPreviewWidget({required this.controller});

  final CameraController controller;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: OverflowBox(
        alignment: Alignment.center,
        child: FittedBox(
          fit: BoxFit.cover,
          child: SizedBox(
            width: controller.value.previewSize?.height ?? 1,
            height: controller.value.previewSize?.width ?? 1,
            child: CameraPreview(controller),
          ),
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.isSpinLab, required this.takeCount});

  final bool isSpinLab;
  final int takeCount;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => context.pop(),
            ),
            if (isSpinLab)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'MODO PRUEBA',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            const Spacer(),
            if (takeCount > 0)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '$takeCount toma${takeCount != 1 ? 's' : ''}',
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _CountdownOverlay extends StatelessWidget {
  const _CountdownOverlay({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '$count',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 120,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _RecordingIndicator extends StatelessWidget {
  const _RecordingIndicator({required this.elapsed});

  final int elapsed;

  @override
  Widget build(BuildContext context) {
    final minutes = elapsed ~/ 60;
    final seconds = elapsed % 60;
    final label =
        '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    return Positioned(
      top: 80,
      left: 0,
      right: 0,
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.red.withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.fiber_manual_record,
                  color: Colors.white, size: 12),
              const SizedBox(width: 6),
              Text(label,
                  style: const TextStyle(color: Colors.white, fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }
}

class _ErrorOverlay extends StatelessWidget {
  const _ErrorOverlay({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(24),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.red.shade900,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          message,
          style: const TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class _BottomControls extends ConsumerWidget {
  const _BottomControls({
    required this.state,
    required this.isSpinLab,
    required this.eventId,
    required this.sessionId,
  });

  final RecordingState state;
  final bool isSpinLab;
  final String eventId;
  final String sessionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(recordingControllerProvider.notifier);

    return Positioned(
      bottom: 40,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (state.takeCount > 0 && !state.isRecording && !state.isCountingDown)
            _CircleButton(
              icon: Icons.check,
              label: 'Confirmar',
              color: Colors.green,
              onTap: isSpinLab
                  ? null
                  : () => context.pushReplacement(
                        AppRoutes.studioConfirmation(eventId, sessionId),
                      ),
            ),
          _RecordButton(state: state, notifier: notifier),
          if (state.isRecording)
            _CircleButton(
              icon: Icons.stop,
              label: 'Detener',
              color: Colors.red,
              onTap: () => notifier.stopRecording(),
            ),
        ],
      ),
    );
  }
}

class _RecordButton extends StatelessWidget {
  const _RecordButton({required this.state, required this.notifier});

  final RecordingState state;
  final RecordingController notifier;

  @override
  Widget build(BuildContext context) {
    final canStart = state.isCameraReady &&
        !state.isRecording &&
        !state.isCountingDown;

    return GestureDetector(
      onTap: canStart ? () => notifier.startCountdown(3) : null,
      child: Container(
        width: 72,
        height: 72,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 4),
          color: state.isRecording
              ? Colors.red
              : canStart
                  ? Colors.white
                  : Colors.white38,
        ),
        child: Icon(
          state.isRecording ? Icons.stop : Icons.circle,
          color: state.isRecording ? Colors.white : Colors.red,
          size: 36,
        ),
      ),
    );
  }
}

class _CircleButton extends StatelessWidget {
  const _CircleButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withValues(alpha: onTap != null ? 1.0 : 0.4),
            ),
            child: Icon(icon, color: Colors.white, size: 26),
          ),
          const SizedBox(height: 6),
          Text(label,
              style: const TextStyle(color: Colors.white, fontSize: 11)),
        ],
      ),
    );
  }
}

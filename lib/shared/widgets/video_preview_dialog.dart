import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

/// Reproduce un video local en un diálogo simple (play/pause + cerrar).
/// Usado tanto para la vista previa de tomas recién grabadas
/// (confirmation_screen.dart) como para los archivos ya procesados en el
/// detalle de sesión del Registro (session_detail_screen.dart).
Future<void> showVideoPreviewDialog(BuildContext context, String path) {
  return showDialog<void>(
    context: context,
    barrierColor: Colors.black87,
    builder: (_) => _VideoPreviewDialog(path: path),
  );
}

class _VideoPreviewDialog extends StatefulWidget {
  const _VideoPreviewDialog({required this.path});

  final String path;

  @override
  State<_VideoPreviewDialog> createState() => _VideoPreviewDialogState();
}

class _VideoPreviewDialogState extends State<_VideoPreviewDialog> {
  late final VideoPlayerController _controller;
  bool _ready = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.path));
    _controller.initialize().then((_) {
      if (!mounted) return;
      setState(() => _ready = true);
      _controller.play();
    }).catchError((Object error) {
      if (!mounted) return;
      setState(() => _error = 'No se pudo reproducir el video.');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black,
      insetPadding: const EdgeInsets.all(16),
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (_error != null)
            Padding(
              padding: const EdgeInsets.all(24),
              child: Text(_error!, style: const TextStyle(color: Colors.white)),
            )
          else if (_ready)
            GestureDetector(
              onTap: () => setState(() {
                _controller.value.isPlaying
                    ? _controller.pause()
                    : _controller.play();
              }),
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
            )
          else
            const SizedBox(
              height: 200,
              child: Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            ),
          Positioned(
            top: 4,
            right: 4,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }
}

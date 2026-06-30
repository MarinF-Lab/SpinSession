import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../shared/widgets/error_screen.dart';
import '../../../../shared/widgets/loading_screen.dart';
import '../../../processing/domain/entities/job_status.dart';
import '../../../processing/domain/entities/job_type.dart';
import '../../../processing/presentation/providers/processing_providers.dart';
import '../../../sessions/presentation/providers/session_providers.dart';

class PrivateSessionScreen extends ConsumerWidget {
  const PrivateSessionScreen({super.key, required this.sessionId});

  final String sessionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionState = ref.watch(sessionControllerProvider);
    final jobsAsync = ref.watch(processingJobsBySessionProvider(sessionId));

    final session = sessionState.sessions
        .where((s) => s.id == sessionId)
        .firstOrNull;

    if (sessionState.isLoading) return const LoadingScreen();

    return Scaffold(
      appBar: AppBar(
        title: Text(session?.guestName ?? 'Sesión privada'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined),
            tooltip: 'Compartir sesión',
            onPressed: () => _shareSession(context, session?.guestName ?? ''),
          ),
        ],
      ),
      body: jobsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => ErrorScreen(message: e.toString()),
        data: (jobs) {
          final mediaJobs = jobs.where((j) => j.jobType.isMediaJob).toList();
          if (mediaJobs.isEmpty) {
            return const Center(
              child: Text('No hay archivos procesados para esta sesión.'),
            );
          }
          return _MediaList(sessionId: sessionId, jobs: mediaJobs);
        },
      ),
    );
  }

  Future<void> _shareSession(BuildContext context, String guestName) async {
    final appDir = await getApplicationDocumentsDirectory();
    final thumbPath = '${appDir.path}/processing/$sessionId/1/thumbnail.jpg';
    final file = File(thumbPath);

    if (file.existsSync()) {
      await Share.shareXFiles(
        [XFile(thumbPath)],
        text: 'Sesión de $guestName — SpinSession',
      );
    } else {
      await Share.share('Sesión de $guestName — SpinSession');
    }
  }
}

class _MediaList extends StatelessWidget {
  const _MediaList({required this.sessionId, required this.jobs});

  final String sessionId;
  final List jobs;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getApplicationDocumentsDirectory()
          .then((d) => '${d.path}/processing/$sessionId'),
      builder: (context, snap) {
        final baseDir = snap.data ?? '';
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: jobs.length,
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemBuilder: (context, i) {
            return _MediaTile(
              job: jobs[i],
              baseDir: baseDir,
            );
          },
        );
      },
    );
  }
}

class _MediaTile extends StatelessWidget {
  const _MediaTile({required this.job, required this.baseDir});

  final dynamic job;
  final String baseDir;

  String? _localPath() {
    if (job.jobType == JobType.generateBurst) {
      return job.payload['outputDir'] as String?;
    }
    return job.payload['outputPath'] as String?;
  }

  @override
  Widget build(BuildContext context) {
    final localPath = _localPath();
    final exists = localPath != null && File(localPath).existsSync();

    return Card(
      child: ListTile(
        leading: _LeadingWidget(job: job, localPath: localPath),
        title: Text(job.jobType.label),
        subtitle: Text(
          exists ? 'Disponible localmente' : 'Procesando...',
          style: TextStyle(
            color: exists
                ? Colors.green
                : Theme.of(context).colorScheme.outline,
          ),
        ),
        trailing: exists
            ? IconButton(
                icon: const Icon(Icons.share_outlined),
                onPressed: () => _shareFile(localPath),
              )
            : job.status == JobStatus.running
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : null,
      ),
    );
  }

  Future<void> _shareFile(String? path) async {
    if (path == null) return;
    await Share.shareXFiles([XFile(path)]);
  }
}

class _LeadingWidget extends StatelessWidget {
  const _LeadingWidget({required this.job, required this.localPath});

  final dynamic job;
  final String? localPath;

  @override
  Widget build(BuildContext context) {
    if (job.jobType == JobType.generateThumbnail &&
        localPath != null &&
        File(localPath!).existsSync()) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Image.file(
          File(localPath!),
          width: 48,
          height: 48,
          fit: BoxFit.cover,
        ),
      );
    }

    final icon = switch (job.jobType) {
      JobType.generateThumbnail => Icons.image_outlined,
      JobType.generateSlowMotion => Icons.slow_motion_video_outlined,
      JobType.generateReverse => Icons.replay_outlined,
      JobType.generateBoomerang => Icons.loop_outlined,
      JobType.generateBurst => Icons.burst_mode_outlined,
      _ => Icons.video_file_outlined,
    };

    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Icon(icon, size: 24),
    );
  }
}

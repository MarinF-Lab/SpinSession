import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../processing/domain/entities/job_status.dart';
import '../../../processing/domain/entities/job_type.dart';
import '../../../processing/domain/entities/processing_job_entity.dart';
import '../../../processing/presentation/providers/processing_providers.dart';

class SyncScreen extends ConsumerWidget {
  const SyncScreen({super.key, required this.sessionId});

  final String sessionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobsAsync = ref.watch(processingJobsBySessionProvider(sessionId));

    return Scaffold(
      appBar: AppBar(title: const Text('Sincronización')),
      body: jobsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (allJobs) {
          final syncJobs = allJobs
              .where((j) => !j.jobType.isMediaJob)
              .toList();

          if (syncJobs.isEmpty) {
            return const Center(
              child: Text('No hay tareas de sincronización para esta sesión.'),
            );
          }

          return _SyncJobList(jobs: syncJobs);
        },
      ),
    );
  }
}

class _SyncJobList extends StatelessWidget {
  const _SyncJobList({required this.jobs});

  final List<ProcessingJobEntity> jobs;

  @override
  Widget build(BuildContext context) {
    final total = jobs.length;
    final done = jobs.where((j) => j.status == JobStatus.completed).length;
    final running = jobs.where((j) => j.status == JobStatus.running).toList();
    final pending = jobs
        .where((j) =>
            j.status == JobStatus.pending || j.status == JobStatus.queued)
        .toList();
    final completed =
        jobs.where((j) => j.status == JobStatus.completed).toList();
    final failed = jobs
        .where((j) =>
            j.status == JobStatus.failed || j.status == JobStatus.retrying)
        .toList();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _SyncSummaryCard(total: total, done: done),
        const SizedBox(height: 16),
        if (running.isNotEmpty) ...[
          _SectionLabel('En progreso', running.length),
          ...running.map((j) => _SyncJobTile(job: j)),
          const SizedBox(height: 12),
        ],
        if (pending.isNotEmpty) ...[
          _SectionLabel('Pendiente', pending.length),
          ...pending.map((j) => _SyncJobTile(job: j)),
          const SizedBox(height: 12),
        ],
        if (completed.isNotEmpty) ...[
          _SectionLabel('Completado', completed.length),
          ...completed.map((j) => _SyncJobTile(job: j)),
          const SizedBox(height: 12),
        ],
        if (failed.isNotEmpty) ...[
          _SectionLabel('Error', failed.length),
          ...failed.map((j) => _SyncJobTile(job: j)),
        ],
      ],
    );
  }
}

class _SyncSummaryCard extends StatelessWidget {
  const _SyncSummaryCard({required this.total, required this.done});

  final int total;
  final int done;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Progreso de sincronización',
                    style: Theme.of(context).textTheme.titleSmall),
                Text('$done / $total',
                    style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: total > 0 ? done / total : 0,
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.title, this.count);

  final String title;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        '$title ($count)',
        style: Theme.of(context).textTheme.labelLarge,
      ),
    );
  }
}

class _SyncJobTile extends StatelessWidget {
  const _SyncJobTile({required this.job});

  final ProcessingJobEntity job;

  IconData _iconForType(JobType type) => switch (type) {
        JobType.uploadAsset => Icons.cloud_upload_outlined,
        JobType.syncSession => Icons.sync_outlined,
        JobType.generatePrivateSession => Icons.lock_outline,
        JobType.generateGallery => Icons.photo_library_outlined,
        JobType.sendWhatsapp => Icons.send_outlined,
        JobType.cleanupStorage => Icons.cleaning_services_outlined,
        JobType.deleteExpiredAssets => Icons.delete_outline,
        _ => Icons.work_outline,
      };

  Color _colorForStatus(BuildContext ctx) => switch (job.status) {
        JobStatus.completed => Colors.green,
        JobStatus.running => Theme.of(ctx).colorScheme.primary,
        JobStatus.failed => Theme.of(ctx).colorScheme.error,
        JobStatus.retrying => Colors.orange,
        _ => Theme.of(ctx).colorScheme.outline,
      };

  @override
  Widget build(BuildContext context) {
    final color = _colorForStatus(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(_iconForType(job.jobType), color: color),
        title: Text(job.jobType.label),
        subtitle: job.errorMessage != null
            ? Text(job.errorMessage!,
                style: TextStyle(color: Theme.of(context).colorScheme.error))
            : null,
        trailing: job.status == JobStatus.running
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                    strokeWidth: 2, color: color),
              )
            : Icon(
                job.status == JobStatus.completed
                    ? Icons.check_circle
                    : job.status == JobStatus.failed
                        ? Icons.error_outline
                        : Icons.schedule,
                color: color,
                size: 20,
              ),
      ),
    );
  }
}

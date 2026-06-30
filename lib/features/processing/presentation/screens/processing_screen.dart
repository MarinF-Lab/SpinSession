import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/job_status.dart';
import '../../domain/entities/processing_job_entity.dart';
import '../providers/processing_providers.dart';

class ProcessingScreen extends ConsumerWidget {
  const ProcessingScreen({super.key, required this.sessionId});

  final String sessionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobsAsync = ref.watch(processingJobsBySessionProvider(sessionId));

    return Scaffold(
      appBar: AppBar(title: const Text('Procesamiento')),
      body: jobsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (jobs) {
          if (jobs.isEmpty) {
            return const Center(
              child: Text('No hay tareas de procesamiento para esta sesión.'),
            );
          }
          return _JobList(jobs: jobs);
        },
      ),
    );
  }
}

class _JobList extends StatelessWidget {
  const _JobList({required this.jobs});

  final List<ProcessingJobEntity> jobs;

  @override
  Widget build(BuildContext context) {
    final pending = jobs.where((j) =>
        j.status == JobStatus.pending || j.status == JobStatus.queued).toList();
    final running = jobs.where((j) => j.status == JobStatus.running).toList();
    final completed = jobs.where((j) => j.status == JobStatus.completed).toList();
    final failed = jobs.where((j) =>
        j.status == JobStatus.failed || j.status == JobStatus.retrying).toList();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _SummaryRow(jobs: jobs),
        const SizedBox(height: 16),
        if (running.isNotEmpty) ...[
          _SectionHeader(title: 'Procesando', count: running.length),
          ...running.map((j) => _JobTile(job: j)),
          const SizedBox(height: 12),
        ],
        if (pending.isNotEmpty) ...[
          _SectionHeader(title: 'En cola', count: pending.length),
          ...pending.map((j) => _JobTile(job: j)),
          const SizedBox(height: 12),
        ],
        if (completed.isNotEmpty) ...[
          _SectionHeader(title: 'Completados', count: completed.length),
          ...completed.map((j) => _JobTile(job: j)),
          const SizedBox(height: 12),
        ],
        if (failed.isNotEmpty) ...[
          _SectionHeader(title: 'Con error', count: failed.length),
          ...failed.map((j) => _JobTile(job: j)),
        ],
      ],
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.jobs});

  final List<ProcessingJobEntity> jobs;

  @override
  Widget build(BuildContext context) {
    final total = jobs.length;
    final done = jobs.where((j) => j.status == JobStatus.completed).length;
    final overallProgress = total > 0 ? done / total : 0.0;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Progreso general',
                    style: Theme.of(context).textTheme.titleSmall),
                Text('$done / $total',
                    style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(value: overallProgress),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, required this.count});

  final String title;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text(title, style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text('$count',
                style: Theme.of(context).textTheme.labelSmall),
          ),
        ],
      ),
    );
  }
}

class _JobTile extends StatelessWidget {
  const _JobTile({required this.job});

  final ProcessingJobEntity job;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _StatusIcon(status: job.status),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    job.jobType.label,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
                _StatusChip(status: job.status),
              ],
            ),
            if (job.status == JobStatus.running) ...[
              const SizedBox(height: 8),
              LinearProgressIndicator(value: job.progress),
            ],
            if (job.errorMessage != null) ...[
              const SizedBox(height: 6),
              Text(
                job.errorMessage!,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.error,
                    ),
              ),
            ],
            if (job.attempts > 0)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  'Intentos: ${job.attempts}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _StatusIcon extends StatelessWidget {
  const _StatusIcon({required this.status});

  final JobStatus status;

  @override
  Widget build(BuildContext context) {
    return switch (status) {
      JobStatus.completed => const Icon(Icons.check_circle, color: Colors.green, size: 20),
      JobStatus.running => SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      JobStatus.failed => const Icon(Icons.error_outline, color: Colors.red, size: 20),
      JobStatus.retrying => const Icon(Icons.refresh, color: Colors.orange, size: 20),
      _ => Icon(Icons.schedule,
            color: Theme.of(context).colorScheme.outline, size: 20),
    };
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});

  final JobStatus status;

  Color _color(BuildContext context) => switch (status) {
        JobStatus.completed => Colors.green,
        JobStatus.running => Theme.of(context).colorScheme.primary,
        JobStatus.failed => Colors.red,
        JobStatus.retrying => Colors.orange,
        _ => Theme.of(context).colorScheme.outline,
      };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: _color(context).withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _color(context).withValues(alpha: 0.4)),
      ),
      child: Text(
        status.label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: _color(context),
            ),
      ),
    );
  }
}

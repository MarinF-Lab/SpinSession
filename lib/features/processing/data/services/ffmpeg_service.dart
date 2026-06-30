import 'dart:io';

import 'package:ffmpeg_kit_flutter_new/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_new/ffprobe_kit.dart';
import 'package:ffmpeg_kit_flutter_new/return_code.dart';

class FFmpegService {
  Future<bool> generateThumbnail(
    String inputPath,
    String outputPath,
    void Function(double) onProgress,
  ) async {
    onProgress(0.1);
    final session = await FFmpegKit.execute(
      '-y -i "$inputPath" -ss 00:00:01 -vframes 1 -q:v 2 "$outputPath"',
    );
    final rc = await session.getReturnCode();
    onProgress(1.0);
    return ReturnCode.isSuccess(rc);
  }

  Future<bool> generateSlowMotion(
    String inputPath,
    String outputPath,
    void Function(double) onProgress,
  ) async {
    onProgress(0.05);
    final duration = await _getVideoDuration(inputPath);
    if (duration <= 0) return false;

    final t1 = duration * 0.2;
    final t2 = duration * 0.8;

    final filter =
        '[0:v]trim=0:$t1,setpts=PTS-STARTPTS[p1];'
        '[0:v]trim=$t1:$t2,setpts=2.5*(PTS-STARTPTS)[p2];'
        '[0:v]trim=$t2,setpts=PTS-STARTPTS[p3];'
        '[p1][p2][p3]concat=n=3:v=1:a=0[out]';

    onProgress(0.1);
    final totalMs = duration * 1000;

    final session = await FFmpegKit.executeAsync(
      '-y -i "$inputPath" -filter_complex "$filter" -map "[out]" -an "$outputPath"',
      null,
      null,
      (stats) {
        if (totalMs > 0) {
          onProgress((stats.getTime() / totalMs).clamp(0.1, 0.95));
        }
      },
    );
    final rc = await session.getReturnCode();
    onProgress(1.0);
    return ReturnCode.isSuccess(rc);
  }

  Future<bool> generateReverse(
    String inputPath,
    String outputPath,
    void Function(double) onProgress,
  ) async {
    onProgress(0.05);
    final duration = await _getVideoDuration(inputPath);
    final totalMs = duration * 1000;

    final session = await FFmpegKit.executeAsync(
      '-y -i "$inputPath" -vf reverse -an "$outputPath"',
      null,
      null,
      (stats) {
        if (totalMs > 0) {
          onProgress((stats.getTime() / totalMs).clamp(0.05, 0.95));
        }
      },
    );
    final rc = await session.getReturnCode();
    onProgress(1.0);
    return ReturnCode.isSuccess(rc);
  }

  Future<bool> generateBoomerang(
    String inputPath,
    String outputPath,
    void Function(double) onProgress,
  ) async {
    onProgress(0.05);
    final duration = await _getVideoDuration(inputPath);
    // Two passes: original + reverse, so total = 2x duration
    final totalMs = duration * 2000;

    final filter =
        '[0:v]split[orig][forrev];[forrev]reverse[rev];[orig][rev]concat=n=2:v=1:a=0[out]';

    final session = await FFmpegKit.executeAsync(
      '-y -i "$inputPath" -filter_complex "$filter" -map "[out]" -an "$outputPath"',
      null,
      null,
      (stats) {
        if (totalMs > 0) {
          onProgress((stats.getTime() / totalMs).clamp(0.05, 0.95));
        }
      },
    );
    final rc = await session.getReturnCode();
    onProgress(1.0);
    return ReturnCode.isSuccess(rc);
  }

  Future<bool> generateBurst(
    String inputPath,
    String outputDir,
    void Function(double) onProgress,
  ) async {
    onProgress(0.05);
    await Directory(outputDir).create(recursive: true);
    final outputPattern = '$outputDir/burst_%04d.jpg';

    final duration = await _getVideoDuration(inputPath);
    final totalMs = duration * 1000;

    final session = await FFmpegKit.executeAsync(
      '-y -i "$inputPath" -vf fps=2 -q:v 2 "$outputPattern"',
      null,
      null,
      (stats) {
        if (totalMs > 0) {
          onProgress((stats.getTime() / totalMs).clamp(0.05, 0.95));
        }
      },
    );
    final rc = await session.getReturnCode();
    onProgress(1.0);
    return ReturnCode.isSuccess(rc);
  }

  Future<double> _getVideoDuration(String path) async {
    final session = await FFprobeKit.getMediaInformation(path);
    final info = session.getMediaInformation();
    return double.tryParse(info?.getDuration() ?? '0') ?? 0;
  }
}

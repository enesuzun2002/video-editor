import 'dart:io';

import 'package:cross_file/cross_file.dart';
import 'package:ffmpeg_kit_flutter_min_gpl/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_min_gpl/return_code.dart';
import 'package:ffmpeg_wasm/ffmpeg_wasm.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';

import '../ffmpeg_operation.dart';
import 'core.dart';

class FfmpegServiceMobile implements FfmpegService {
  @override
  Future<String> getVideoThumbnail(String path, {FFmpeg? ffmpeg}) async {
    return await _getVideoThumbnail(path);
  }

  Future<String> _getVideoThumbnail(
    String path,
  ) async {
    XFile video = XFile(path);
    String thumbnailPath = video.name
        .replaceRange(video.path.length - 3, video.path.length, "jpg");
    String command =
        "-i ${video.path} -ss 2 -vframes 1 -vf scale=-1:400 -f image2 $thumbnailPath";
    return FFmpegKit.execute(command).then((session) async {
      final returnCode = await session.getReturnCode();
      if (ReturnCode.isSuccess(returnCode)) {
        return thumbnailPath;
      } else {
        throw ("FFMPEG: There was an error when creating output!\nCode: ${returnCode.toString()}\nError: ${session.getFailStackTrace()}");
      }
    });
  }

  @override
  Future<String> editVideo(
    String path, {
    String? start,
    String? duration,
    FFmpeg? ffmpeg,
    FfmpegOperation operation = FfmpegOperation.trim,
    // constant rate factor
    String compressionRate = "25",
    bool scale = true,
    String quality = "720",
  }) async {
    if (operation == FfmpegOperation.trim &&
        (start == null || duration == null)) {
      throw ArgumentError("Start and duration must not be null for trimming.");
    }

    List<String> command = [
      "-i",
      path,
      if (operation == FfmpegOperation.trim) ...[
        "-ss",
        start!,
        "-t",
        duration!,
      ],
      if (scale) ...[
        "-vf",
        "scale='if(gt(iw/ih,1),-2,$quality)':'if(gt(iw/ih,1),$quality,-2)'",
      ],
      "-c:v",
      "libx264",
      "-pix_fmt",
      "yuv420p",
      "-c:a",
      "aac",
      "-b:a",
      "128k",
      "-preset",
      "superfast",
      "-crf",
      compressionRate,
      "-movflags",
      "+faststart",
    ];

    // Start the timer
    final startTime = DateTime.now();

    final result = await _editVideo(path, command);

    // Stop the timer
    final endTime = DateTime.now();
    final session = endTime.difference(startTime);
    debugPrint("Video editing completed in: ${session.inSeconds} seconds");

    return result;
  }

  Future<String> _editVideo(String path, List<String> command) async {
    String trimmedVideoPath = "${dirname(path)}/trimmed_video.mp4";
    final outputFile = File(trimmedVideoPath);
    if (await outputFile.exists()) {
      outputFile.delete();
    }
    return await FFmpegKit.executeWithArguments([...command, trimmedVideoPath])
        .then((session) async {
      final returnCode = await session.getReturnCode();

      if (ReturnCode.isSuccess(returnCode)) {
        return trimmedVideoPath;
      } else {
        throw ("FFMPEG: There was an error when creating output!\nCode: ${returnCode.toString()}\nError: ${await session.getFailStackTrace()}");
      }
    });
  }

  @override
  Future<FFmpeg?> loadFFmpegScript() {
    throw UnimplementedError("loadFFmpegScript is not implemented for mobile!");
  }
}

FfmpegService getPlatformFfmpegService() => FfmpegServiceMobile();

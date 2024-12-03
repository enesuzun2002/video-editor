import 'dart:io';

import 'package:cross_file/cross_file.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/return_code.dart';
import 'package:ffmpeg_wasm/ffmpeg_wasm.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';

import '../ffmpeg_operation.dart';
import 'core.dart';

class FfmpegServiceMobile implements FfmpegService {
  @override
  Future<String> getVideoThumbnail(XFile video, {FFmpeg? ffmpeg}) async {
    return await _getVideoThumbnail(video);
  }

  Future<String> _getVideoThumbnail(
    XFile video,
  ) async {
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
    XFile video, {
    String? start,
    String? duration,
    FFmpeg? ffmpeg,
    FfmpegOperation operation = FfmpegOperation.trim,
    // constant rate factor
    String compressionRate = "25",
    bool scale = true,
    String quality = "720",
  }) async {
    List<String> command = [
      if (operation == FfmpegOperation.trim) ...[
        // start
        "-ss",
        start!,
        // duration
        "-t",
        duration!,
      ],
      // scale
      if (scale) ...[
        "-vf",
        "scale='if(gt(iw/ih,1),-2,$quality)':'if(gt(iw/ih,1),$quality,-2)'",
      ],
      // video codec
      "-c:v",
      "libx264",
      // pixel format
      "-pix_fmt",
      "yuv420p",
      // audio codec
      "-c:a",
      "aac",
      // lower audio bitrate
      "-b:a",
      "128k",
      // codec preset (faster => ultrafast)
      "-preset",
      "superfast",
      // Constant Rate Factor (lower means better quality, higher means faster)
      "-crf",
      compressionRate,
      // fast start for streaming
      "-movflags",
      "+faststart",
    ];

    // Start the timer
    final startTime = DateTime.now();

    final result = await compute(_editVideo, {
      "video": video,
      "command": command.join(" "),
    });

    // Stop the timer
    final endTime = DateTime.now();
    final session = endTime.difference(startTime);
    debugPrint("Video editing completed in: ${session.inSeconds} seconds");

    return result;
  }

  Future<String> _editVideo(Map<String, dynamic> args) async {
    // Args
    XFile video = args["video"];
    String command = args["command"];

    String trimmedVideoPath = "${dirname(video.path)}/trimmed_video.mp4";
    final outputFile = File(trimmedVideoPath);
    if (await outputFile.exists()) {
      outputFile.delete();
    }
    return await FFmpegKit.execute(
            "-i ${video.path} $command $trimmedVideoPath")
        .then((session) async {
      final returnCode = await session.getReturnCode();

      if (ReturnCode.isSuccess(returnCode)) {
        return trimmedVideoPath;
      } else {
        throw ("FFMPEG: There was an error when creating output!\nCode: ${returnCode.toString()}\nError: ${session.getFailStackTrace()}");
      }
    });
  }

  @override
  Future<FFmpeg?> loadFFmpegScript() {
    throw UnimplementedError("loadFFmpegScript is not implemented for mobile!");
  }
}

FfmpegService getPlatformFfmpegService() => FfmpegServiceMobile();

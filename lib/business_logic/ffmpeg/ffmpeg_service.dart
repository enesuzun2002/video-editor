// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:io';

import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/return_code.dart';
import 'package:ffmpeg_wasm/ffmpeg_wasm.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

final ffmpegServiceProvider = Provider<FfmpegService>((ref) {
  return FfmpegService();
});

class FfmpegService {
  Future<FFmpeg?> loadFFmpegScript() async {
    try {
      // This should only be for web
      if (!kIsWeb) return null;

      final script = html.ScriptElement()
        ..src = '/assets/ffmpeg/ffmpeg.min.js'
        ..crossOrigin = 'anonymous'
        ..defer = true;
      html.document.body!.append(script);
      await script.onLoad.first;

      FFmpeg? ffmpeg;

      ffmpeg = createFFmpeg(CreateFFmpegParam(
          log: true,
          corePath:
              Uri.base.resolve('/assets/ffmpeg/ffmpeg-core.js').toString()));
      // Wait for ffmpeg to load
      await ffmpeg.load();

      return ffmpeg;
    } catch (e) {
      rethrow;
    }
  }

  Future<Uint8List> getVideoThumbnail(XFile video, {FFmpeg? ffmpeg}) async {
    if (kIsWeb) {
      if (ffmpeg == null || !ffmpeg.isLoaded()) throw ("FFMPEG isn't loaded!");
      return await _getVideoThumbnailWeb(video, ffmpeg: ffmpeg);
    } else {
      return await _getVideoThumbnail(video);
    }
  }

  Future<Uint8List> _getVideoThumbnail(
    XFile video,
  ) async {
    String thumbnailPath = video.name
        .replaceRange(video.path.length - 3, video.path.length, "jpg");
    String command =
        "-i ${video.path} -ss 2 -vframes 1 -vf scale=-1:400 -f image2 $thumbnailPath";
    return FFmpegKit.execute(command).then((session) async {
      final returnCode = await session.getReturnCode();
      if (ReturnCode.isSuccess(returnCode)) {
        return File(thumbnailPath).readAsBytesSync();
      } else {
        throw ("FFMPEG: There was an error when creating output!\nCode: ${returnCode.toString()}\nError: ${session.getFailStackTrace()}");
      }
    });
  }

  Future<Uint8List> _getVideoThumbnailWeb(XFile video,
      {required FFmpeg ffmpeg}) async {
    String inputFile = video.name;
    String outputFile =
        inputFile.replaceRange(inputFile.length - 3, inputFile.length, "jpg");
    var data = await video.readAsBytes();

    ffmpeg.writeFile(inputFile, data);

    String command =
        "-i $inputFile -ss 2 -vframes 1 -vf scale=-1:400 -f image2 $outputFile";
    await ffmpeg.runCommand(command);

    return ffmpeg.readFile(outputFile);
  }

  Future<String> trimVideo(XFile video, String start, String duration,
      {FFmpeg? ffmpeg}) async {
    if (kIsWeb) {
      if (ffmpeg == null || !ffmpeg.isLoaded()) throw ("FFMPEG isn't loaded!");
      return await _trimVideoWeb(video, start, duration, ffmpeg: ffmpeg);
    } else {
      return await _trimVideo(video, start, duration);
    }
  }

  Future<String> _trimVideo(
    XFile video,
    String start,
    String duration,
  ) async {
    String trimmedVideoPath = "${dirname(video.path)}/trimmed_video.mp4";
    final outputFile = File(trimmedVideoPath);
    if (await outputFile.exists()) {
      outputFile.delete();
    }
    return await FFmpegKit.execute(
            "-i ${video.path} -ss $start -t $duration -c:a aac $trimmedVideoPath")
        .then((session) async {
      final returnCode = await session.getReturnCode();

      if (ReturnCode.isSuccess(returnCode)) {
        return trimmedVideoPath;
      } else {
        throw ("FFMPEG: There was an error when creating output!\nCode: ${returnCode.toString()}\nError: ${session.getFailStackTrace()}");
      }
    });
  }

  Future<String> _trimVideoWeb(XFile video, String start, String duration,
      {required FFmpeg ffmpeg}) async {
    String inputFile = video.name;
    String outputFile =
        inputFile.replaceRange(inputFile.length - 3, inputFile.length, "mp4");

    var data = await video.readAsBytes();

    ffmpeg.writeFile(inputFile, data);

    await ffmpeg.runCommand(
        "-i $inputFile -ss $start -t $duration -c:a aac $outputFile");

    return Uri.base
        .resolve(XFile.fromData(ffmpeg.readFile(outputFile)).path)
        .toString();
  }
}

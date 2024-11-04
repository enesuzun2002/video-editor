// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:cross_file/cross_file.dart';
import 'package:ffmpeg_wasm/ffmpeg_wasm.dart';
import 'package:flutter/foundation.dart';
import 'package:video_editor/src/business_logic/ffmpeg/ffmpeg_operation.dart';

import 'core.dart';

class FfmpegServiceWeb implements FfmpegService {
  @override
  Future<FFmpeg?> loadFFmpegScript() async {
    try {
      final script = html.ScriptElement()
        ..src = 'packages/video_editor/assets/ffmpeg/ffmpeg.min.js'
        ..crossOrigin = 'anonymous'
        ..defer = true;
      html.document.body!.append(script);
      await script.onLoad.first;

      FFmpeg? ffmpeg;

      ffmpeg = createFFmpeg(CreateFFmpegParam(
          log: true,
          corePath: Uri.base
              .resolve('packages/video_editor/assets/ffmpeg/ffmpeg-core.js')
              .toString()));
      // Wait for ffmpeg to load
      await ffmpeg.load();

      return ffmpeg;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> getVideoThumbnail(XFile video, {FFmpeg? ffmpeg}) async {
    if (ffmpeg == null || !ffmpeg.isLoaded()) throw ("FFMPEG isn't loaded!");
    return await _getVideoThumbnail(video, ffmpeg: ffmpeg);
  }

  Future<String> _getVideoThumbnail(XFile video,
      {required FFmpeg ffmpeg}) async {
    String inputFile = video.name;
    String outputFile =
        inputFile.replaceRange(inputFile.length - 3, inputFile.length, "jpg");
    var data = await video.readAsBytes();

    ffmpeg.writeFile(inputFile, data);

    String command =
        "-i $inputFile -ss 2 -vframes 1 -vf scale=-1:400 -f image2 $outputFile";
    await ffmpeg.runCommand(command);

    return XFile.fromData(ffmpeg.readFile(outputFile)).path;
  }

  @override
  Future<String> editVideo(XFile video,
      {String? start,
      String? duration,
      FFmpeg? ffmpeg,
      FfmpegOperation operation = FfmpegOperation.trim}) async {
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
      "-vf",
      "scale='if(gt(iw/ih,1),-2,720)':'if(gt(iw/ih,1),720,-2)'",
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
      "25",
      // fast start for streaming
      "-movflags",
      "+faststart",
    ];

    // Start the timer
    final startTime = DateTime.now();

    if (ffmpeg == null || !ffmpeg.isLoaded()) throw ("FFMPEG isn't loaded!");
    final result = await compute(_editVideo, {
      "video": video,
      "command": command.join(" "),
      "ffmpeg": ffmpeg,
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
    FFmpeg ffmpeg = args["ffmpeg"];
    String command = args["command"];

    String inputFile = video.name;
    String outputFile = "output.mp4";

    var data = await video.readAsBytes();

    ffmpeg.writeFile(inputFile, data);

    await ffmpeg.runCommand("-i $inputFile $command $outputFile");

    return XFile.fromData(ffmpeg.readFile(outputFile)).path;
  }
}

FfmpegService getPlatformFfmpegService() => FfmpegServiceWeb();

import 'dart:html' as html;

import 'package:ffmpeg_wasm/ffmpeg_wasm.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class WebVideoThumbnailScreen extends StatefulWidget {
  const WebVideoThumbnailScreen({super.key, required this.video});
  final XFile video;

  @override
  State<WebVideoThumbnailScreen> createState() =>
      _WebVideoThumbnailScreenState();
}

class _WebVideoThumbnailScreenState extends State<WebVideoThumbnailScreen> {
  Uint8List? thumbnail;

  @override
  void initState() {
    super.initState();
    loadFFmpegScript().then((_) {
      getVideoThumbnail();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Video Thumbnail"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (thumbnail != null)
            Image.memory(
              thumbnail!,
            ),
        ],
      ),
    );
  }

  Future<void> loadFFmpegScript() async {
    try {
      final script = html.ScriptElement()
        ..src = '/assets/ffmpeg/ffmpeg.min.js'
        ..crossOrigin = 'anonymous'
        ..defer = true;
      html.document.body!.append(script);
      await script.onLoad.first;
    } catch (e, stackTrace) {
      // Delay the call to show the SnackBar until the widget tree is built
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
        debugPrint(e.toString());
        debugPrint(stackTrace.toString());
      });
    }
  }

  void getVideoThumbnail() async {
    FFmpeg? ffmpeg;
    try {
      ffmpeg = createFFmpeg(CreateFFmpegParam(
          log: true,
          corePath:
              Uri.base.resolve('/assets/ffmpeg/ffmpeg-core.js').toString()));
      // Wait for ffmpeg to load
      await ffmpeg.load();

      print(widget.video.name);

      const inputFile = 'input.mp4';
      const outputFile = 'output.jpg';
      var data = await widget.video.readAsBytes();

      ffmpeg.writeFile(inputFile, data);

      String command =
          "-i $inputFile -ss 2 -vframes 1 -vf scale=-1:400 -f image2 $outputFile";
      await ffmpeg.runCommand(command); // Await to ensure it's completed

      thumbnail = ffmpeg.readFile(outputFile);
      setState(() {});
    } catch (e, stackTrace) {
      if (!mounted) return;

      // Delay the call to show the SnackBar until the widget tree is built
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
        debugPrint(e.toString());
        debugPrint(stackTrace.toString());
      });
    } finally {
      ffmpeg?.exit();
    }
  }
}

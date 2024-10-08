import 'dart:io';
import 'dart:html' as html;

import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/return_code.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:video_player/video_player.dart';

import '../widget/web_video_player.dart';

class VideoTrimmer extends StatefulWidget {
  const VideoTrimmer({
    super.key,
    required this.video,
    this.mimeType = "video/mp4",
  });
  final dynamic video;
  final String mimeType;

  @override
  State<VideoTrimmer> createState() => _VideoTrimmerState();
}

class _VideoTrimmerState extends State<VideoTrimmer> {
  String _trimmedVideoPath = "";
  VideoPlayerController? _originalController;
  VideoPlayerController? _trimmedController;
  RangeValues _rangeValues = RangeValues(
    0.0,
    30.0,
  );

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  void _initializeVideoPlayer() {
    if (kIsWeb) return;
    print("Initializing video player...");

    try {
      _originalController = VideoPlayerController.file(widget.video);
      print("Initialized video from file: ${widget.video}");
      if (_originalController != null) {
        _originalController?.initialize().then((value) {
          print("Video player initialized successfully.");
          setState(() {});
        }).catchError((error) {
          print("Error during video initialization: $error");
        });

        _originalController?.play().then((_) {
          print("Video started playing.");
        }).catchError((error) {
          print("Error playing video: $error");
        });
      } else {
        print("Video controller is null.");
      }
    } catch (e) {
      print("Error initializing video file: $e");
    }
  }

  @override
  void dispose() {
    _originalController?.dispose();
    super.dispose();
  }

  void _trimVideo() async {
    String start = _rangeValues.start.toInt() < 10
        ? "00:00:0${_rangeValues.start.toInt()}"
        : "00:00:${_rangeValues.start.toInt()}";
    String duration = (_rangeValues.end - _rangeValues.start).toInt() < 10
        ? "00:00:0${(_rangeValues.end - _rangeValues.start).toInt()}"
        : "00:00:${(_rangeValues.end - _rangeValues.start).toInt()}";
    _trimmedVideoPath = "${dirname(widget.video.path)}/trimmed_video.mp4";
    final outputFile = File(_trimmedVideoPath);
    if (await outputFile.exists()) {
      outputFile.delete();
    }
    await FFmpegKit.execute(
            "-i ${widget.video.path} -ss $start -t $duration -c:a aac $_trimmedVideoPath")
        .then((session) async {
      if (ReturnCode.isSuccess(await session.getReturnCode())) {
        _trimmedController =
            VideoPlayerController.file(File(_trimmedVideoPath));
        _trimmedController!.initialize();
        _trimmedController!.play();
      }
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Video Trimmer"),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 400,
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: kIsWeb
                    ? WebVideoPlayer(
                        id: "video",
                        bytes: widget.video,
                        mimeType: widget.mimeType)
                    : _trimmedController == null
                        ? _originalController == null
                            ? SizedBox()
                            : VideoPlayer(_originalController!)
                        : VideoPlayer(_trimmedController!),
              ),
            ),
            if (_trimmedController == null) ...[
              /* RangeSlider(
                min: 0.0,
                max: _originalController?.value.duration.inSeconds.toDouble() ??
                    30.0,
                values: _rangeValues,
                divisions: _originalController?.value.duration.inSeconds,
                labels: RangeLabels(
                  _rangeValues.start.round().toString(),
                  _rangeValues.end.round().toString(),
                ),
                onChanged: (RangeValues value) {
                  setState(() {
                    if (value.end - value.start <= 30) {
                      if (!(_originalController?.value.isPlaying ?? true)) {
                        _originalController?.play();
                      }
                      _originalController
                          ?.seekTo(Duration(seconds: value.start.toInt()));
                      _rangeValues = value;
                    }
                  });
                },
              ), */
              IconButton(
                icon: const Icon(Icons.play_arrow),
                onPressed: _trimVideo,
              ),
            ]
          ],
        ),
      ),
    );
  }
}

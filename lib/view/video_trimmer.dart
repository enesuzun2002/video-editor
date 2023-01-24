import 'dart:io';

import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/return_code.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:video_player/video_player.dart';

class VideoTrimmer extends StatefulWidget {
  const VideoTrimmer({
    super.key,
    required this.video,
  });
  final File video;

  @override
  State<VideoTrimmer> createState() => _VideoTrimmerState();
}

class _VideoTrimmerState extends State<VideoTrimmer> {
  String _trimmedVideoPath = "";
  VideoPlayerController? _originalController;
  VideoPlayerController? _trimmedController;
  late RangeValues _rangeValues;

  @override
  void initState() {
    _originalController = VideoPlayerController.file(widget.video);
    _originalController!.initialize().then((value) {
      _rangeValues = RangeValues(
        0.0,
        _originalController!.value.duration.inSeconds <= 30
            ? _originalController!.value.duration.inSeconds.toDouble()
            : 30.0,
      );
      setState(() {});
    });
    _originalController!.play();
    super.initState();
  }

  @override
  void dispose() {
    _originalController!.dispose();
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
                aspectRatio: _originalController!.value.aspectRatio,
                child: _trimmedController == null
                    ? VideoPlayer(_originalController!)
                    : VideoPlayer(_trimmedController!),
              ),
            ),
            if (_trimmedController == null) ...[
              RangeSlider(
                min: 0.0,
                max: _originalController!.value.duration.inSeconds.toDouble(),
                values: _rangeValues,
                divisions: _originalController!.value.duration.inSeconds,
                labels: RangeLabels(
                  _rangeValues.start.round().toString(),
                  _rangeValues.end.round().toString(),
                ),
                onChanged: (RangeValues value) {
                  setState(() {
                    if (value.end - value.start <= 30) {
                      if (!(_originalController!.value.isPlaying)) {
                        _originalController!.play();
                      }
                      _originalController!
                          .seekTo(Duration(seconds: value.start.toInt()));
                      _rangeValues = value;
                    }
                  });
                },
              ),
              Row(
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.play_arrow),
                    onPressed: _trimVideo,
                  ),
                ],
              ),
            ]
          ],
        ),
      ),
    );
  }
}

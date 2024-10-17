import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_editor/features/trimmer/business_logic/trimmer_controller.dart';
import 'package:video_editor/widgets/padding_box.dart';
import 'package:video_player/video_player.dart';

import '../../../business_logic/ffmpeg/ffmpeg_controller.dart';

class VideoTrimmerScreen extends ConsumerStatefulWidget {
  const VideoTrimmerScreen({
    super.key,
  });

  @override
  ConsumerState<VideoTrimmerScreen> createState() => _VideoTrimmerState();
}

class _VideoTrimmerState extends ConsumerState<VideoTrimmerScreen> {
  @override
  Widget build(BuildContext context) {
    var ffmpegController = ref.watch(ffmpegControllerProvider);
    var ffmpegControllerNotifier = ref.watch(ffmpegControllerProvider.notifier);

    var trimmerController =
        ref.watch(trimmerControllerProvider(ffmpegController.videoFile!.path));
    var trimmerControllerNotifier = ref.watch(
        trimmerControllerProvider(ffmpegController.videoFile!.path).notifier);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Video Trimmer"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              trimmerController.inputController.when(
                data: (data) => Column(
                  children: [
                    Text("Original Video"),
                    SizedBox(
                      height: 400,
                      child: AspectRatio(
                        aspectRatio: data!.value.aspectRatio,
                        child: VideoPlayer(data),
                      ),
                    ),
                  ],
                ),
                error: (error, stackTrace) => Text("Error: $error"),
                loading: () => CircularProgressIndicator(),
              ),
              PaddingBox.m,
              trimmerController.rangeValues.when(
                data: (data) {
                  var controller = trimmerController.inputController.value!;
                  return Column(
                    children: [
                      RangeSlider(
                        min: 0.0,
                        max: controller.value.duration.inSeconds.toDouble(),
                        values: data!,
                        divisions: controller.value.duration.inSeconds,
                        labels: RangeLabels(
                          data.start.round().toString(),
                          controller.value.duration.inSeconds
                              .round()
                              .toString(),
                        ),
                        onChanged: (RangeValues value) {
                          if (value.end - value.start <= 30) {
                            if (!(controller.value.isPlaying)) {
                              controller.play();
                            }
                            controller
                                .seekTo(Duration(seconds: value.start.toInt()));
                            trimmerControllerNotifier.updateRangeValues(value);
                          }
                        },
                      ),
                      ElevatedButton.icon(
                        onPressed: () async {
                          String path = await ffmpegControllerNotifier.trimVideo(
                              data.start.toInt() < 10
                                  ? "00:00:0${data.start.toInt()}"
                                  : "00:00:${data.start.toInt()}",
                              (data.end - data.start).toInt() < 10
                                  ? "00:00:0${(data.end - data.start).toInt()}"
                                  : "00:00:${(data.end - data.start).toInt()}");

                          trimmerControllerNotifier
                              .createOutputController(path);
                        },
                        label: Text("Trim Video"),
                        icon: Icon(Icons.play_arrow),
                      ),
                    ],
                  );
                },
                error: (error, stackTrace) => Text("Error: $error"),
                loading: () => CircularProgressIndicator(),
              ),
              PaddingBox.m,
              if (trimmerController.outputController != null)
                trimmerController.outputController!.when(
                  data: (data) => Column(
                    children: [
                      Text("Trimmed Video"),
                      SizedBox(
                        height: 400,
                        child: AspectRatio(
                          aspectRatio: data!.value.aspectRatio,
                          child: VideoPlayer(data),
                        ),
                      ),
                    ],
                  ),
                  error: (error, stackTrace) => Text("Error: $error"),
                  loading: () => CircularProgressIndicator(),
                ),
              PaddingBox.vl,
            ],
          ),
        ),
      ),
    );
  }
}

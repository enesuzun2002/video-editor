import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_editor/features/compression/business_logic/compression_controller.dart';
import 'package:video_editor/features/video-player/screen/video_player.dart';
import 'package:video_editor/widgets/padding_box.dart';
import 'package:video_player/video_player.dart';

import '../../../business_logic/ffmpeg/ffmpeg_controller.dart';

class VideoCompressionScreen extends ConsumerStatefulWidget {
  const VideoCompressionScreen({
    super.key,
  });

  @override
  ConsumerState<VideoCompressionScreen> createState() =>
      _VideoCompressionState();
}

class _VideoCompressionState extends ConsumerState<VideoCompressionScreen> {
  String outputPath = "";
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    var ffmpegController = ref.watch(ffmpegControllerProvider);
    var ffmpegControllerNotifier = ref.watch(ffmpegControllerProvider.notifier);

    var compressionController = ref
        .watch(compressionControllerProvider(ffmpegController.videoFile!.path));
    var compressionControllerNotifier = ref.watch(
        compressionControllerProvider(ffmpegController.videoFile!.path)
            .notifier);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Video Compressor"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              compressionController.inputController.when(
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
              ElevatedButton.icon(
                onPressed: () async {
                  isLoading = true;
                  setState(() {});
                  outputPath = await ffmpegControllerNotifier.compressVideo();

                  compressionControllerNotifier
                      .createOutputController(outputPath);
                  isLoading = false;
                  setState(() {});
                },
                label: Text("Compress Video"),
                icon: Icon(Icons.play_arrow),
              ),
              if (isLoading) ...[PaddingBox.m, CircularProgressIndicator()],
              PaddingBox.m,
              if (compressionController.outputController != null)
                compressionController.outputController!.when(
                  data: (data) {
                    // Defer the navigation until the widget tree is fully built
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      compressionController.inputController.value?.pause();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VideoPlayerScreen(
                            videoPlayerController:
                                compressionController.outputController!.value!,
                            fileName: ffmpegController.videoFile?.name,
                            url: outputPath,
                          ),
                        ),
                      );
                    });
                    return SizedBox();
                  },
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

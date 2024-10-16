import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_editor/business_logic/ffmpeg/ffmpeg_controller.dart';

class VideoThumbnailScreen extends ConsumerWidget {
  const VideoThumbnailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var ffmpegControllerNotifier = ref.watch(ffmpegControllerProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Video Thumbnail"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: FutureBuilder(
                future: ffmpegControllerNotifier.getVideoThumbnail(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text(
                        "Error occured trying to get thumbnail for selected video file!\n\n${snapshot.error.toString()}");
                  } else if (snapshot.hasData) {
                    return Image.memory(snapshot.data!);
                  }
                  return CircularProgressIndicator();
                }),
          ),
        ],
      ),
    );
  }
}

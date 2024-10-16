import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_editor/business_logic/ffmpeg/ffmpeg_controller.dart';
import 'package:video_editor/widgets/padding_box.dart';
import 'package:video_editor/widgets/pick_video_bottom_sheet.dart';

import '../features/thumbnail/screen/video_thumbnail.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var ffmpegController = ref.watch(ffmpegControllerProvider);
    var ffmpegControllerNotifier = ref.watch(ffmpegControllerProvider.notifier);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Video Editor"),
          centerTitle: true,
        ),
        body: Center(
            child: ffmpegController.ffmpeg.when(
                data: (ffmpeg) => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (ffmpegController.videoFile != null)
                          Text(
                              "Selected video file: ${ffmpegController.videoFile!.name}"),
                        ElevatedButton(
                          onPressed: () async {
                            if (kIsWeb) {
                              final video = await ImagePicker()
                                  .pickVideo(source: ImageSource.gallery);
                              if (video != null) {
                                ffmpegControllerNotifier.setPickedVideo(video);
                              }
                            } else {
                              PickVideoBottomSheet.show(context, ref);
                            }
                          },
                          child: Text("Select Video File"),
                        ),
                        if (ffmpegController.videoFile != null) ...[
                          PaddingBox.m,
                          ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            VideoThumbnailScreen()));
                              },
                              child: Text("Video Thumbnail Generator")),
                          PaddingBox.m,
                          ElevatedButton(
                              onPressed: () {}, child: Text("Video Trimmer")),
                        ],
                      ],
                    ),
                error: (error, stackTrace) =>
                    Text("Error occured: ${error.toString()}"),
                loading: () => CircularProgressIndicator())));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_editor/business_logic/ffmpeg/ffmpeg_controller.dart';

class PickVideoBottomSheet {
  PickVideoBottomSheet.show(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0)),
      ),
      context: context,
      builder: (context) {
        // Using Wrap makes the bottom sheet height the height of the content.
        // Otherwise, the height will be half the height of the screen.
        return Wrap(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 16.0),
              child: Center(
                child: Text(
                  "How do you want to pick your video file?",
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
              child: Column(
                children: [
                  ListTile(
                    onTap: () async {
                      final video = await ImagePicker()
                          .pickVideo(source: ImageSource.camera);
                      if (video != null) {
                        ref
                            .read(ffmpegControllerProvider.notifier)
                            .setPickedVideo(video);
                      }
                    },
                    leading: const Icon(Icons.camera),
                    title: const Text(
                      "Camera",
                    ),
                  ),
                  ListTile(
                    onTap: () async {
                      final video = await ImagePicker()
                          .pickVideo(source: ImageSource.gallery);
                      if (video != null) {
                        ref
                            .read(ffmpegControllerProvider.notifier)
                            .setPickedVideo(video);
                      }
                    },
                    leading: const Icon(Icons.file_present),
                    title: const Text("Gallery"),
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

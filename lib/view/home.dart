import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_editor/features/thumbnail/screen/web_video_thumbnail.dart';
import 'package:video_editor/view/video_trimmer.dart';

import '../features/thumbnail/screen/video_thumbnail.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Video Editor"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            getButton(
                context,
                const Text(
                  "Video Thumbnail",
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                0),
            getButton(
                context,
                const Text(
                  "Video Trimmer",
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                1),
          ],
        ),
      ),
    );
  }

  ElevatedButton getButton(BuildContext context, Widget child, int type) {
    return ElevatedButton(
      onPressed: () async {
        if (kIsWeb) {
          final video =
              await ImagePicker().pickVideo(source: ImageSource.gallery);
          if (video != null) {
            if (!context.mounted) return;
            if (type == 0) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          WebVideoThumbnailScreen(video: video)));
            } else {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          VideoTrimmer(video: File(video.path))));
            }
          }
        } else {
          showModalBottomSheet(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25.0)),
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
                      child: child,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        top: 16.0, left: 16.0, right: 16.0),
                    child: Column(
                      children: [
                        ListTile(
                          onTap: () async {
                            final video = await ImagePicker()
                                .pickVideo(source: ImageSource.camera);
                            if (video != null) {
                              if (type == 0) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            VideoThumbnailScreen(
                                                video: File(video.path))));
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => VideoTrimmer(
                                            video: File(video.path))));
                              }
                            }
                          },
                          leading: const Icon(Icons.camera),
                          title: const Text(
                            "Take video from camera",
                          ),
                        ),
                        ListTile(
                          onTap: () async {
                            final video = await ImagePicker()
                                .pickVideo(source: ImageSource.gallery);
                            if (video != null) {
                              if (type == 0) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            VideoThumbnailScreen(
                                                video: File(video.path))));
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => VideoTrimmer(
                                            video: File(video.path))));
                              }
                            }
                          },
                          leading: const Icon(Icons.file_present),
                          title: const Text("Select video from gallery"),
                        )
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        }
      },
      child: child,
    );
  }
}

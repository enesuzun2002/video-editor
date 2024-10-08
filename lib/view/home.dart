import 'dart:async';
import 'dart:io';
import 'dart:html' as html;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_editor/view/video_thumbnail.dart';
import 'package:video_editor/view/video_trimmer.dart';

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
            SizedBox(height: 16.0),
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

  Future<Uint8List> pickFileAndGetBytes() async {
    final completer = Completer<Uint8List>();

    // Create a file input element
    final html.FileUploadInputElement uploadInput =
        html.FileUploadInputElement();
    uploadInput.accept = 'video/*'; // Optionally restrict to video files
    uploadInput.click(); // Trigger the file selection dialog

    // When a file is selected, read the file as bytes
    uploadInput.onChange.listen((event) {
      final files = uploadInput.files;
      if (files != null && files.isNotEmpty) {
        final file = files[0];
        final reader = html.FileReader();

        reader.onLoadEnd.listen((_) {
          // FileReader.result will contain the file data as Uint8List
          completer.complete(reader.result as Uint8List);
        });

        // Read the file as array buffer (bytes)
        reader.readAsArrayBuffer(file);
      }
    });

    return completer.future;
  }

  ElevatedButton getButton(BuildContext context, Widget child, int type) {
    return ElevatedButton(
      onPressed: () async => kIsWeb
          ? pickFileAndGetBytes().then((value) {
              if (!context.mounted) return;
              if (type == 0) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VideoTrimmer(video: value)));
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VideoTrimmer(video: value)));
              }
            })
          : showModalBottomSheet(
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
                                if (!context.mounted) return;
                                if (type == 0) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              VideoThumbnailView(
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
                                              VideoThumbnailView(
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
            ),
      child: child,
    );
  }
}

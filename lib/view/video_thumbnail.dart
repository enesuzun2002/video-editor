import 'dart:io';

import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/return_code.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class VideoThumbnailView extends StatefulWidget {
  const VideoThumbnailView({super.key});

  @override
  State<VideoThumbnailView> createState() => _VideoThumbnailViewState();
}

class _VideoThumbnailViewState extends State<VideoThumbnailView> {
  String filePath = "";

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
          if (filePath != "")
            Image.file(
              File(filePath),
            ),
          ElevatedButton(
            onPressed: () => showModalBottomSheet(
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
                      child: const Center(
                        child: Text(
                          "Video Thumbnail",
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          top: 16.0, left: 16.0, right: 16.0),
                      child: Column(
                        children: [
                          ListTile(
                            onTap: () => getVideoThumbnail(ImageSource.camera),
                            leading: const Icon(Icons.camera),
                            title: const Text(
                              "Take video from camera",
                            ),
                          ),
                          ListTile(
                            onTap: () => getVideoThumbnail(ImageSource.gallery),
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
            child: const Text("Select Video File"),
          ),
        ],
      ),
    );
  }

  void getVideoThumbnail(ImageSource source) async {
    final video = await ImagePicker().pickVideo(source: source);
    if (video != null) {
      String thumbnailPath = video.path
          .replaceRange(video.path.length - 3, video.path.length, "jpg");
      String command =
          "-i ${video.path} -ss 2 -vframes 1 -vf scale=-1:400 -f image2 $thumbnailPath";
      FFmpegKit.execute(command).then((session) async {
        final returnCode = await session.getReturnCode();
        if (ReturnCode.isSuccess(returnCode)) {
          filePath = thumbnailPath;
          setState(() {});
        }
      });
    }
  }
}

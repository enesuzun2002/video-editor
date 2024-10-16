import 'dart:io';

import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/return_code.dart';
import 'package:flutter/material.dart';

class VideoThumbnailScreen extends StatefulWidget {
  const VideoThumbnailScreen({super.key, required this.video});
  final File video;

  @override
  State<VideoThumbnailScreen> createState() => _VideoThumbnailScreenState();
}

class _VideoThumbnailScreenState extends State<VideoThumbnailScreen> {
  String filePath = "";

  @override
  void initState() {
    getVideoThumbnail();
    super.initState();
  }

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
        ],
      ),
    );
  }

  void getVideoThumbnail() async {
    String thumbnailPath = widget.video.path.replaceRange(
        widget.video.path.length - 3, widget.video.path.length, "jpg");
    String command =
        "-i ${widget.video.path} -ss 2 -vframes 1 -vf scale=-1:400 -f image2 $thumbnailPath";
    FFmpegKit.execute(command).then((session) async {
      final returnCode = await session.getReturnCode();
      if (ReturnCode.isSuccess(returnCode)) {
        filePath = thumbnailPath;
        setState(() {});
      }
    });
  }
}

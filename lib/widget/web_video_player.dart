import 'dart:typed_data';
import 'dart:ui_web' as ui_web;
import 'dart:html' as html;
import 'package:flutter/material.dart';

class WebVideoPlayer extends StatelessWidget {
  const WebVideoPlayer({
    required this.id,
    required this.bytes,
    required this.mimeType,
    super.key,
  });

  // unique id
  final String id;

  // mimetype like video/mp4, video/webm
  final String mimeType;

  // video data
  final Uint8List bytes;

  @override
  Widget build(BuildContext context) {
    // Read file as bytes using FileReader
    final videoElement = html.VideoElement();
    videoElement.controls = true;
    videoElement.src = Uri.dataFromBytes(bytes, mimeType: mimeType).toString();
    videoElement.style.height = '100%';
    videoElement.style.width = '100%';

    ui_web.platformViewRegistry
        .registerViewFactory("video", (int viewId) => videoElement);

    return HtmlElementView(viewType: id);
  }
}

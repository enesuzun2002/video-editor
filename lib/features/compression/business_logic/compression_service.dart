import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

final compressionServiceProvider = Provider<CompressionService>((ref) {
  return CompressionService();
});

class CompressionService {
  Future<VideoPlayerController> createController(String path) async {
    VideoPlayerController controller;
    if (kIsWeb) {
      controller = VideoPlayerController.networkUrl(Uri.base.resolve(path));
    } else {
      controller = VideoPlayerController.file(File(path));
    }

    await controller.initialize();
    return controller;
  }
}

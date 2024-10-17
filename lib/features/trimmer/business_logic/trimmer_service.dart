import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

final trimmerServiceProvider = Provider<TrimmerService>((ref) {
  return TrimmerService();
});

class TrimmerService {
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

  RangeValues setInitialRangeValues(VideoPlayerController controller) =>
      RangeValues(
        0.0,
        controller.value.duration.inSeconds <= 30
            ? controller.value.duration.inSeconds.toDouble()
            : 30.0,
      );
}

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../widgets/animated_play_button.dart';

class VideoPlayerScreen extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  const VideoPlayerScreen({
    super.key,
    required this.videoPlayerController,
  });

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen>
    with TickerProviderStateMixin {
  late AnimationController controller;
  double opacity = 0.0;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    if (!widget.videoPlayerController.value.isPlaying) {
      widget.videoPlayerController.play();
    }
  }

  @override
  void dispose() {
    widget.videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Video Player"),
      ),
      body: Center(
        child: Stack(
          children: [
            SizedBox(
              height: widget.videoPlayerController.value.size.height,
              width: widget.videoPlayerController.value.size.width,
              child: AspectRatio(
                aspectRatio: widget.videoPlayerController.value.aspectRatio,
                child: VideoPlayer(widget.videoPlayerController),
              ),
            ),
            AnimatedPlayButton(
              opacity: opacity,
              controller: controller,
              size: 40.0,
              onTap: () {
                if (widget.videoPlayerController.value.isPlaying) {
                  widget.videoPlayerController.pause();
                  opacity = 1.0;
                  setState(() {});
                  controller.forward();
                } else {
                  widget.videoPlayerController.play();
                  opacity = 0.0;
                  setState(() {});
                  controller.reverse();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

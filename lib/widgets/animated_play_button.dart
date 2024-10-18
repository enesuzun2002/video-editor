import 'package:flutter/material.dart';

class AnimatedPlayButton extends StatefulWidget {
  final AnimationController controller;
  final double size;
  final void Function() onTap;
  final double opacity;
  const AnimatedPlayButton(
      {super.key,
      required this.controller,
      required this.size,
      required this.onTap,
      required this.opacity});

  @override
  State<AnimatedPlayButton> createState() => _AnimatedPlayButtonState();
}

class _AnimatedPlayButtonState extends State<AnimatedPlayButton>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      // TODO: Find a better way to disable this ink effect
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: widget.onTap,
      child: Center(
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 800),
          opacity: widget.opacity,
          child: AnimatedIcon(
            color: Colors.grey.shade100,
            icon: AnimatedIcons.play_pause,
            progress: widget.controller,
            size: widget.size,
          ),
        ),
      ),
    );
  }
}

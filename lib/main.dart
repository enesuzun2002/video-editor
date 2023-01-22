import 'package:flutter/material.dart';
import 'package:video_editor/view/video_thumbnail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Editor',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const VideoThumbnailView(),
    );
  }
}

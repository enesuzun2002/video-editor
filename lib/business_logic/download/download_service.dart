import 'dart:html' as html;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart'; // For kIsWeb
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart'; // For non-web platforms
import 'package:permission_handler/permission_handler.dart';

class DownloadService {
  static Future<void> downloadFile(String url,
      {required String fileName}) async {
    try {
      if (kIsWeb) {
        _downloadFileWeb(Uri.base.resolve(url).toString(), fileName);
      } else {
        _downloadFile(url, fileName);
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  static Future<void> _downloadFile(String url, String fileName) async {
    final hasPermission = await _requestWritePermission();
    if (!hasPermission) return;

    var dir = await getApplicationDocumentsDirectory();

    final savePath = "${dir.path}/$fileName";

    try {
      await Dio().download(url, savePath, onReceiveProgress: (received, total) {
        if (total != -1) {
          debugPrint("${(received / total * 100).toStringAsFixed(0)}%");
        }
      });
    } catch (e) {
      rethrow;
    }

    OpenFilex.open(savePath);
  }

  static Future<bool> _requestWritePermission() async {
    await Permission.storage.request();
    return await Permission.storage.request().isGranted;
  }

  static Future<void> _downloadFileWeb(String url, String fileName) async {
    try {
      // create an anchor element
      var anchor = html.AnchorElement(href: url)
        ..setAttribute("download", fileName);

      // Download the file
      anchor.click();
    } catch (e) {
      rethrow;
    }
  }
}

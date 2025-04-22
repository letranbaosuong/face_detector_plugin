import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'face_detector_plugin_platform_interface.dart';

/// An implementation of [FaceDetectorPluginPlatform] that uses method channels.
class MethodChannelFaceDetectorPlugin extends FaceDetectorPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('face_detector_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>(
      'getPlatformVersion',
    );
    return version;
  }

  /// Phát hiện khuôn mặt từ đường dẫn hình ảnh
  /// Trả về danh sách các khuôn mặt với tọa độ và kích thước
  @override
  Future<List<Map<String, dynamic>>> detectFaces(String imagePath) async {
    try {
      final List<dynamic> faces = await methodChannel.invokeMethod(
        'detectFaces',
        {'imagePath': imagePath},
      );
      return faces.map((face) => Map<String, dynamic>.from(face)).toList();
    } on PlatformException catch (e) {
      print('Lỗi phát hiện khuôn mặt: ${e.message}');
      return [];
    }
  }
}

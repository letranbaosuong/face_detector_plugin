import 'face_detector_plugin_platform_interface.dart';

class FaceDetectorPlugin {
  Future<String?> getPlatformVersion() {
    return FaceDetectorPluginPlatform.instance.getPlatformVersion();
  }

  Future<List<Map<String, dynamic>>> detectFaces(String imagePath) {
    return FaceDetectorPluginPlatform.instance.detectFaces(imagePath);
  }
}

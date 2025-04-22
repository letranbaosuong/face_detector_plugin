import 'package:face_detector_plugin/face_detector_plugin.dart';
import 'package:face_detector_plugin/face_detector_plugin_method_channel.dart';
import 'package:face_detector_plugin/face_detector_plugin_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFaceDetectorPluginPlatform
    with MockPlatformInterfaceMixin
    implements FaceDetectorPluginPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<List<Map<String, dynamic>>> detectFaces(String imagePath) {
    // TODO: implement detectFaces
    throw UnimplementedError();
  }
}

void main() {
  final FaceDetectorPluginPlatform initialPlatform =
      FaceDetectorPluginPlatform.instance;

  test('$MethodChannelFaceDetectorPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFaceDetectorPlugin>());
  });

  test('getPlatformVersion', () async {
    FaceDetectorPlugin faceDetectorPlugin = FaceDetectorPlugin();
    MockFaceDetectorPluginPlatform fakePlatform =
        MockFaceDetectorPluginPlatform();
    FaceDetectorPluginPlatform.instance = fakePlatform;

    expect(await faceDetectorPlugin.getPlatformVersion(), '42');
  });
}

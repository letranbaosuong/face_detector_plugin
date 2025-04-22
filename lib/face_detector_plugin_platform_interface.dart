import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'face_detector_plugin_method_channel.dart';

abstract class FaceDetectorPluginPlatform extends PlatformInterface {
  /// Constructs a FaceDetectorPluginPlatform.
  FaceDetectorPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static FaceDetectorPluginPlatform _instance =
      MethodChannelFaceDetectorPlugin();

  /// The default instance of [FaceDetectorPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelFaceDetectorPlugin].
  static FaceDetectorPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FaceDetectorPluginPlatform] when
  /// they register themselves.
  static set instance(FaceDetectorPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<List<Map<String, dynamic>>> detectFaces(String imagePath) {
    throw UnimplementedError('detectFaces() has not been implemented.');
  }
}

#ifndef FLUTTER_PLUGIN_FACE_DETECTOR_PLUGIN_H_
#define FLUTTER_PLUGIN_FACE_DETECTOR_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace face_detector_plugin {

class FaceDetectorPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  FaceDetectorPlugin();

  virtual ~FaceDetectorPlugin();

  // Disallow copy and assign.
  FaceDetectorPlugin(const FaceDetectorPlugin&) = delete;
  FaceDetectorPlugin& operator=(const FaceDetectorPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace face_detector_plugin

#endif  // FLUTTER_PLUGIN_FACE_DETECTOR_PLUGIN_H_

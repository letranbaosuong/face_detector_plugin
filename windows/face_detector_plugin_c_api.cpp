#include "include/face_detector_plugin/face_detector_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "face_detector_plugin.h"

void FaceDetectorPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  face_detector_plugin::FaceDetectorPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}

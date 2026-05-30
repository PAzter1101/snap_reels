#include "include/snap_reels/snap_reels_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "snap_reels_plugin.h"

void SnapReelsPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  snap_reels::SnapReelsPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}

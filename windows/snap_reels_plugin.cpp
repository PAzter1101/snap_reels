#include "snap_reels_plugin.h"

#include <flutter/plugin_registrar_windows.h>

namespace snap_reels {

void SnapReelsPlugin::RegisterWithRegistrar(
    flutter::PluginRegistrarWindows *registrar) {
  auto plugin = std::make_unique<SnapReelsPlugin>();
  registrar->AddPlugin(std::move(plugin));
}

SnapReelsPlugin::SnapReelsPlugin() {}

SnapReelsPlugin::~SnapReelsPlugin() {}

}  // namespace snap_reels

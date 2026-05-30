#ifndef FLUTTER_PLUGIN_SNAP_REELS_PLUGIN_H_
#define FLUTTER_PLUGIN_SNAP_REELS_PLUGIN_H_

#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace snap_reels {

class SnapReelsPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  SnapReelsPlugin();
  virtual ~SnapReelsPlugin();

  SnapReelsPlugin(const SnapReelsPlugin&) = delete;
  SnapReelsPlugin& operator=(const SnapReelsPlugin&) = delete;
};

}  // namespace snap_reels

#endif  // FLUTTER_PLUGIN_SNAP_REELS_PLUGIN_H_

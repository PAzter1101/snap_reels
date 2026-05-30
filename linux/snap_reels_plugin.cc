#include "include/snap_reels/snap_reels_plugin.h"

#include <flutter_linux/flutter_linux.h>

#define SNAP_REELS_PLUGIN(obj) \
  (G_TYPE_CHECK_INSTANCE_CAST((obj), snap_reels_plugin_get_type(), \
                              SnapReelsPlugin))

struct _SnapReelsPlugin {
  GObject parent_instance;
};

G_DEFINE_TYPE(SnapReelsPlugin, snap_reels_plugin, g_object_get_type())

static void snap_reels_plugin_class_init(SnapReelsPluginClass* klass) {}

static void snap_reels_plugin_init(SnapReelsPlugin* self) {}

void snap_reels_plugin_register_with_registrar(FlPluginRegistrar* registrar) {}

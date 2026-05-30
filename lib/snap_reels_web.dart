import 'package:flutter_web_plugins/flutter_web_plugins.dart';

/// Web packaging shim. The widgets themselves are pure Dart and do not
/// rely on any native code on the web; `media_kit` handles video playback
/// through HTML5 `<video>` directly.
class SnapReelsWebPlugin {
  /// Registers this plugin with the [Registrar].
  static void registerWith(Registrar registrar) {}
}

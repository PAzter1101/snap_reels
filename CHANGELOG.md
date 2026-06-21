## 3.2.0

### Changes
- Dropped the unmaintained `iconly` dependency (it extended `IconData`, which is now a `final` class and no longer compiles on recent Flutter). Default like / comment / share icons now use Material icons (`favorite`/`favorite_border`, `chat_bubble_outline`, `send_outlined`).

### Fixes
- `ReelController.peekNext` re-checks `hasClients` after each animation step, avoiding a `ScrollController not attached` assertion when the controller detaches mid-animation (e.g. the widget is torn down during the peek).

---

## 3.1.0

### New platforms
- iOS, macOS, Linux, Windows, and Web are now declared in `flutter.plugin.platforms` with no-op shim plugins. 3.0.0 declared only Android, which made pub.dev list the package as Android-only; 3.1.0 restores the wide platform coverage that pre-3.0.0 releases got transitively through `media_kit`.

### Documentation
- CHANGELOG translated to English (was a mix of Russian and English).
- README clarifies the Android-emulator caveat: the underlying `media_kit` works in macOS / Linux / Windows / Web VMs and browsers, but Android's emulator codec path does not deliver a usable hardware decoder.

---

## 3.0.0

Major refactor across the public API, models, internals, and packaging.
See the **2.x → 3.0.0** section in [README.md](README.md#2x--300) for the
field mapping table and a before/after code example.

### Breaking changes
- **`ReelConfig` flattened fields grouped into sub-configs.** Colors / button visibility / sizes / builders / callbacks moved under `styling: ReelStylingConfig`, `actions: ReelActionsConfig`, `builders: ReelOverlayBuildersConfig`, `callbacks: ReelInteractionCallbacks`. See README migration table.
- **Video frame size: `Size` → `VideoSize`.** Avoids the clash with `dart:ui.Size`; `VideoSource.dimensions` is now `VideoSize?`.
- **Analytics bool parameters are named.** `trackLike(reelId, position, {required bool isLiked})`, `trackFollow(..., {required bool isFollowing})`, `setEnabled({required bool enabled})`.
- **Removed dead controller stubs**: `toggleLike`, `incrementShare`, `downloadReel`, `blockUser`, `followUser`, the `refresh()` override, and `StreamingService.dispose()`. Hosts already receive the events through callbacks / `onRefresh`.
- **Removed unwired `ReelConfig.preloadRange`** — configure preload via `preloadConfig: PreloadConfig(preloadAhead, preloadBehind)`.
- **Models live in dedicated files**: `video_format.dart`, `video_size.dart`, `video_source.dart`, `reel_user.dart`, `reel_audio.dart`. `reel_model.dart` re-exports them for source compatibility.
- **`ReelController.dispose()` is now best-effort.** It fires `close()` without awaiting (Flutter's sync `dispose()` cannot await). Use `await controller.close()` from a navigation hook when deterministic teardown is required.

### New API
- **Android Flutter plugin packaging.** Adds `android/consumer-rules.pro` with media_kit / libmpv keep-rules merged automatically through `consumerProguardFiles`. Host apps can drop the duplicates from their own `proguard-rules.pro`.
- **`ReelController.close()`** — awaitable teardown of native (libmpv) handles.
- **`ReelController.pauseAll()`** — pauses every player in the pool (used by hosts when the feed becomes hidden through a non-route mechanism like bottom-nav tab switch).
- **`ReelController.setAppVisibility()` / `setVisibility()` split** — independent app-lifecycle and widget-visibility flags. Resuming the app while the widget is still hidden by a tab no longer triggers playback.
- **`SnapReelItem`, `SnapReelsExtension.fromUrls`** — moved into separate files. `SnapReelsExtension.fromUrls` re-exported through the package barrel.
- **Analytics shortcut extensions** — `trackVideoStarted`, `trackLike`, etc. moved into `AnalyticsServicePlaybackShortcuts` / `AnalyticsServiceInteractionShortcuts` extensions. Re-exported through `analytics_service.dart` so call sites still work via the singleton.
- **Focused `*Utils` classes** — `FormatUtils`, `ColorUtils`, `MathUtils`, `ResponsiveUtils`, `TimingUtils`, `StringUtils`, `PlatformUtils`, `VideoUrlUtils`. `ReelUtils` remains as a delegating facade so existing call sites compile unchanged.

### Bug fixes
- **`_showCommentsBottomSheet` leaked `TextEditingController` / `FocusNode`.** Now wrapped in `try/finally` so the controllers are disposed when the sheet closes.
- **Late visibility callback could pause a recycled player from the pool.** Pause now revalidates `controller.getPlayerForReel(reel) == _assignedPlayer` before calling `player.pause()`.
- **Follow action no longer dropped the `onFollow` callback.** The default snackbar handler invokes the host callback after rendering.
- **Block / follow callbacks no longer crash for reels without a `user`.** Null-guard added before invoking host callbacks.
- **Cache LRU dual-budget bug.** Removed the parallel `_evictIfOverCacheSize` path (hardcoded 200 MB) that ran alongside `_enforceCacheSize` (configurable). A single `CacheEvictor.evictToFit` enforces `CacheConfig.maxCacheSize`.
- **Cache alias double-counting and orphan entries.** Aliases created by `linkCachedUrl` store `fileSize: 0`; eviction collapses entries by `filePath` and removes every key sharing the deleted path.
- **`evictToFit` could over-evict when a zero-size alias was the oldest entry for its path.** Pre-aggregation by path is now done before sorting and budget subtraction.
- **`enablePullToRefresh` was broken.** The internal `refresh()` override only printed `'Refresh called'`; replaced with a direct call to `widget.config.onRefresh` from the `RefreshIndicator`.

### Internal
- All models migrated to `freezed`; generated `*.freezed.dart` / `*.g.dart` marked `linguist-generated` in `.gitattributes`.
- Lint set switched to `very_good_analysis`; 207 `public_member_api_docs` docstrings added across the public API.
- Large files decomposed: `reel_actions.dart`, `reel_overlay.dart`, `reel_progress_indicator.dart`, `analytics_service.dart`, `cache_manager.dart`, `snap_reels_widget.dart` — split into focused widgets / services (`ReelCommentsSheet`, `ReelMoreOptionsSheet`, `ReelMusicAvatar`, `FloatingHeartOverlay`, `ReelActionButton`, `ReelUserInfoOverlay`, `ReelBottomControls`, `ReelOverlayGestureLayer`, `ProgressTrackBar`, `ReelProgressTimeLabels`, `ScrubThumbnailPreview`, `CacheIndexStorage`, `CacheEvictor`, `AnalyticsSummary`, `AnalyticsCalculations`, `AnalyticsDeviceInfoCollector`).
- `ReelActions` and `ReelOverlay` are now `StatelessWidget`s; animation state moved into the dedicated child widgets.
- README rewritten in English with a 2.x → 3.0.0 migration guide.

---

## 2.3.3

### Bug fixes
- **Streaming video stalled after 1–2 seconds with no recovery.** libavformat doesn't reconnect on transient HTTP errors or keep-alive close by default. A set of streaming tunables is now applied before `player.open()`: `demuxer-lavf-o=reconnect=1,reconnect_streamed=1,reconnect_on_network_error=1,reconnect_delay_max=2`, `network-timeout=30`, `hwdec=auto-safe`, `force-seekable=yes`, `cache=yes,cache-secs=10`, `demuxer-readahead-secs=20`. See [media-kit/media-kit#959](https://github.com/media-kit/media-kit/issues/959).

---

## 2.3.2

### Bug fixes
- **Video stalled 1–2 seconds after start in Android release builds.** `media_kit_video`'s `Video` widget rendered only after the first decoded frame; before that the tree held a `SizedBox.shrink()`. The libmpv surface texture is created with the widget, so in AOT release builds the player could initialize before Flutter inserted `Video` into the tree, leaving libmpv without a render sink. The fix keeps `Video` in the tree from the first build and hides the thumbnail on the first frame. See [media-kit/media-kit#909](https://github.com/media-kit/media-kit/issues/909).

---

## 2.3.1

Follow-up to the thumbnail cache from 2.3.0: prefetch adjacent thumbnails in parallel with video preload, host-side fallback URL hook, and cache aliasing between two URLs of the same resource.

### Bug fixes
- **Adjacent reel thumbnails were not prefetched.** In 2.3.0 the `CacheManager` was initialized, but `_preloadAdjacentVideos` only fed the decoder; thumbnails fetched on `CachedThumbnail` mount, so users saw the fallback placeholder during the network round-trip. `_PreloadManagerMixin` now fires `CacheManager.downloadAndCache` for thumbnails in the window `[currentIndex − thumbnailPreloadBehind; currentIndex + thumbnailPreloadAhead]` (defaults `+5/-2`).
- **No host-side recovery for thumbnail failures.** `CachedThumbnail` silently fell into the `fallback` widget on network/decode errors. Added `ReelConfig.thumbnailProxyUrlBuilder` (`String? Function(ReelModel)`) and `ReelConfig.thumbnailLoadTimeout` (default 3 s): when the primary URL doesn't deliver a frame in time or fails, `CachedThumbnail` retries with the builder URL. The builder receives `ReelModel` so hosts can derive the URL from `reel.id`.
- **Re-opening a viewed reel went back to the network.** If the primary fetch went through `thumbnailProxyUrlBuilder`, the cache index stored only under the fallback key. The next mount hit a miss on the primary URL. After a successful fallback fetch, `CachedThumbnail` now calls `CacheManager.linkCachedUrl(primary, fallback)` to register an alias entry that points at the same `filePath`. The next mount returns the cached image synchronously.

### New API
- **`ReelConfig.thumbnailProxyUrlBuilder`** — `String? Function(ReelModel reel)?`, default `null`. Returning `null` keeps the primary URL.
- **`ReelConfig.thumbnailLoadTimeout`** — `Duration`, default `3s`. No effect when `thumbnailProxyUrlBuilder` is unset.
- **`PreloadConfig.thumbnailPreloadAhead`** / **`thumbnailPreloadBehind`** — `int`, defaults `5` / `2`. `0/0` disables thumbnail prefetch.
- **`CacheManager.linkCachedUrl(aliasUrl, existingUrl)`** — adds a second cache index entry pointing at the same `filePath`. The file is not copied.

### Breaking changes
- **`CachedThumbnail` constructor**: `url: String` replaced by `reel: ReelModel` so the widget can hand the model to `proxyUrlBuilder`. Update direct uses of `CachedThumbnail(url:, fallback:)` to `CachedThumbnail(reel:, fallback:)`. Internal callers (`reel_video_player`, `reel_error_overlay`) are already updated.

---

## 2.3.0

### New features
- **`ReelConfig.httpClient`** — optional `Dio?` forwarded to `CacheManager.initialize()`. Lets hosts share their HTTP stack (e.g. `NativeAdapter` + `CronetEngine`) with thumbnail / video prefetch, including connection pool, TLS session cache, and interceptors.
- **`ReelConfig.errorDialogBuilder`** — customize the full-screen error popup. The builder receives `ReelModel`, `errorMessage`, and `onRetry` / `onCancel` callbacks.
- **`ReelConfig.bufferingBuilder`** — custom buffering indicator instead of the default spinner.
- **New public widgets** — `ReelErrorOverlay` and `ReelBufferingIndicator` extracted from `reel_overlay.dart` as reusable building blocks; the builders above call them or host UI.
- **`ReelConfig.thumbnailFallbackBuilder`** — placeholder widget when `thumbnailUrl` is missing or fails. Receives `ReelModel` so hosts can render a content-specific placeholder.
- **Thumbnails go through `CacheManager`.** A new internal `CachedThumbnail` widget replaces `Image.network` in `ReelVideoPlayer`. Thumbnails now share the host `Dio` and the disk LRU.
- **Configurable tap targets without changing visuals.** Five new fields in `ReelConfig`: `actionMinTapTargetSize` (default `44`), `actionIconSize` (`28`), `likeButtonSize` (`32`), `actionSpacing` (`16`), `hashtagMinTapTargetSize` (`0`). The min-tap-target sizes set the hit area via `Container(constraints:, alignment: center)` + `HitTestBehavior.opaque` without resizing the icon/text.

### Bug fixes
- **`CacheManager` initialization.** Fixed a latent bug: `_dio` / `_config` were `late` but never assigned, and `_isInitialized` was a `final bool = false`. Every `downloadAndCache` call was effectively a no-op (errors swallowed by `Future.microtask`). `CacheManager.instance.initialize()` is now called from `ReelController.initialize()` with parameters from `ReelConfig`, is idempotent, and sets `_isInitialized` correctly.
- **Validation order in `ReelController.initialize`.** Empty `reels` list validation moved before `MediaKit.ensureInitialized()`, so `SnapReels(reels: [])` no longer requires libmpv on the host.
- **Black `Video` no longer covers the thumbnail.** Until the first decoded frame, `ReelVideoPlayer` keeps `Video` hidden (subscribed to `player.stream.width`). Previously media_kit rendered a solid black background over the thumbnail during buffering and after errors.
- **`Buffering…` no longer renders on top of the error dialog.** The overlay uses `if/else if`: when `hasError == true` the buffering indicator is not shown.

### Dependencies
- Removed `share_plus` (declared in `pubspec.yaml` but unused).
- `wakelock_plus` ^1.5.1 → ^1.6.0 (transitively pulls `win32 ^6.0.0` and `package_info_plus ^10`).
- `device_info_plus` ^12.4.0 → ^13.0.0 (consumer API unchanged).
- Environment raised to `Dart ^3.10.0`, `Flutter >=3.38.1`.

### Maintenance
- Added `cache_manager_test.dart` covering `initialize()` idempotency and absence of `LateInitializationError`.
- `CachedThumbnail.errorBuilder` updated for the `unnecessary_underscores` lint added in Dart ≥3.10.

---

## 2.2.0

### New features
- **`ReelConfig.showHashtags`** — controls whether hashtag chips are rendered under the caption. Defaults to `true` (backward compatible).

### Bug fixes
- **SafeArea in the more menu** — `_showMoreOptions()` bottom sheet is now wrapped in `SafeArea(top: false)`. The bottom menu items no longer hide behind the gesture navigation bar on devices like Samsung A54.

### Maintenance
- Bumped `connectivity_plus` ^7.1.1, `lottie` ^3.3.3, `lints` ^6.1.0.

---

## 2.1.3

### Bug fixes
- **"No active player with ID" crash.** When a pre-initialized `ReelController` was passed to `SnapReels`, the widget called `initialize()` again. The double init triggered `_resetPool()` mid-preload and surfaced as `StateError: Bad state: No active player with ID 1` from media_kit. The widget now skips re-initialization when the controller is already initialized.
- **Guard in `_preloadVideo` and `_initializeCurrentVideo`** — empty-pool and disposed checks added before any Player call, preventing races during teardown.

### Maintenance
- Replaced deprecated `flutter_lints` with `lints: ^5.1.1`.
- Bumped `connectivity_plus` ^7.1.0, `device_info_plus` ^12.4.0, `share_plus` ^12.0.2, `mockito` ^5.6.4, `build_runner` ^2.13.1.

---

## 2.1.2

### New features
- **`ReelConfig.contentBottomPadding`** — bottom inset for overlay content (user info, action stack). Use to lift content above a tab bar.
- **`showProgressIndicator` now works.** The field existed in the config but wasn't honored by the overlay. When `false`, the progress bar is hidden and content shifts down into the freed space.

---

## 2.1.1

### Performance
- **Adaptive pool size.** Player pool size is derived from device class: low → 2, medium → 3, high → 4. High-end devices (Android SDK 31+, iPhone 11+) preload up to 2 videos ahead.

---

## 2.1.0

### ⚠️ Breaking changes
- **Migrated to `media_kit`.** Replaces `video_player` with `media_kit` + `media_kit_video` + `media_kit_libs_video`. Apps must call `MediaKit.ensureInitialized()` before use (called automatically from `ReelController.initialize()`).
- **Doesn't work on the Android emulator** — media_kit doesn't support texture rendering on the emulator. Test on real devices only.

### Performance
- **Player pool (3 slots).** Replaces per-swipe create/dispose with a fixed pool of 3 `Player`s. Each swipe calls `player.open()` on an existing Player so the hardware decoder is reused.
- **Slot recycling.** On swipe, the furthest slot is recycled for the next preload — no native resource dispose/recreate.

### Architecture
- **`reel_controller.dart` decomposition** — 770 lines split into 5 part files: `_reel_state_mixin.dart`, `_video_lifecycle_mixin.dart`, `_preload_manager_mixin.dart`, `_playback_mixin.dart`, plus the thin orchestrator `reel_controller.dart`.

### Bug fixes
- **`_isVideoInitializing` race.** Cancelled inits (serial mismatch) no longer clear `_isVideoInitializing` in `finally`, fixing a bug where videos didn't load after 4–5 fast swipes.
- **Re-initialization race.** The pool is created once; repeated `initialize()` calls run `_resetPool()` (stop + clear assignments) instead of dispose/recreate, removing the "Player has been disposed" error.

### Maintenance
- Removed `video_player` dependency.
- Removed hardcoded `User-Agent` from `cache_manager.dart`.
- `streaming_service.dart` reduced to `resolveStreamingUrl()` (format selection only).
- `reel_progress_indicator.dart` switched from `ValueListenableBuilder<VideoPlayerValue>` to `Obx` over `currentPosition` / `totalDuration`.
- `reel_overlay.dart` — direct `VideoPlayerController` access removed in favor of Rx getters.

---

## 2.0.0

### ⚠️ Breaking changes
- **`AwesomeReels` renamed to `SnapReels`.** Replace all `AwesomeReels(...)` usages with `SnapReels(...)`.

### Deprecations
- `StreamingConfig.enableAdaptiveBitrate` marked `@Deprecated` (no effect, to be removed in v3.0.0).

### Performance
- **SHA-256 cache keys.** Cache keys are now SHA-256 of the URL instead of `url.hashCode`. Removes collisions and platform non-determinism on web.
- **URL normalization.** CDN tokens (`token`, `sig`, `expires`, `auth`, etc.) are stripped before hashing, so the same asset behind different signed URLs is cached once.
- **Memory pressure handling.** On system memory-pressure signals all preloaded controllers are disposed and the in-memory cache cleared. Prevents OOM-kill on 2–3 GB devices.
- **Adaptive preload.** On low-end devices (Android SDK < 28, iPhone < 11) `preloadAhead` drops to 1 and `preloadBehind` to 0, saving ~2 hardware decoders.
- **Preload prioritization.** `next` is awaited first; `prev` is fire-and-forget (80 % of scrolls go down).
- **Debounced preload.** Fast scrolling skips intermediate-page preload via a 200 ms debounce.
- **Serial-based init cancellation.** Each `onPageChanged` assigns a unique serial; superseded inits are cancelled and their controllers disposed. Fixes the bug where 4–5 rapid swipes left the player on a thumbnail-only state.

### Maintenance
- Added `crypto: ^3.0.6` dependency for SHA-256.
- `reel_config.dart` split: `CacheConfig`/`PreloadConfig` → `cache_config.dart`, `StreamingConfig` → `streaming_config.dart`, `VideoPlayerConfig` → `video_player_config.dart`, `ProgressIndicatorConfig` → `progress_config.dart`. Public API unchanged.
- `CacheItem` and `CacheStats` moved to `models/cache_item.dart`.
- Added `DeviceClassifier` (`utils/device_classifier.dart`) with `low / medium / high` classification.
- User-Agent changed from `AwesomeReels/1.0.0` to `SnapReels/1.3.0`.

---

## 1.2.0

### New Features
- `peekNext()` method on `ReelController` — animate a partial scroll to preview the next reel and snap back, useful for onboarding hints

## 1.1.0

### New Features
- Thumbnail preview: show `thumbnailUrl` as background image while video loads, replacing black screen with a smooth visual transition

## 1.0.0

### Fork & Rename
- Forked from [flutter_awesome_reels](https://github.com/wailashraf71/flutter_awesome_reels) by wailashraf71
- Published as `snap_reels` — maintained independently

### New Features
- `appendReels()` method on `ReelController` — append new reels without reinitializing the controller
- `onReportTap`, `onBlockTap`, `onCopyLinkTap` callbacks in `ReelConfig` with customizable labels (`reportLabel`, `blockLabel`, `copyLinkLabel`)
- `showCommentButton` parameter in `ReelConfig` — conditionally show/hide comment button

### Bug Fixes
- Fixed hardware video decoder exhaustion: dispose far-away preloaded `VideoPlayerController`s during scroll, keeping max 3 alive (previous, current, next)

### Maintenance
- Updated `share_plus` to ^12.0.0, `connectivity_plus` to ^7.0.0, `device_info_plus` to ^12.0.0, `wakelock_plus` to ^1.4.0
- Replaced deprecated `activeColor` with `activeThumbColor` in example app
- Fixed string interpolation in `ReelModel.toString()`

## 0.0.5

### 🎨 Example App Redesign
- Modern blue-gradient theme for Home and Playground screens
- New gradient feature cards, decorative orbs, and improved typography
- Refreshed buttons and section cards with professional look-and-feel

### 🔧 Core Playback Improvements
- Ensure only a single video plays at a time when switching reels
- Pause and detach previous controller on page change and controller switch
- Preloaded controllers are initialized paused to prevent background audio
- Pause off-screen reels via visibility detection

### 🐛 Fixes
- Mitigated black-screen-with-audio by guarding rendering until valid video size
- Cleaned up controller listeners on dispose/switch
- Replaced deprecated Color.withOpacity with Color.withValues

## 0.0.4

* Updated README.md to reflect new features and usage examples

## 0.0.3

### ⚠️ Breaking Changes
* **Multi-Format Video Support**: Plugin now supports HLS, MPEG-DASH, and MP4 video sources. This may require changes to your video URLs and backend delivery.
* **New Event Callbacks**: Added `onPress` and `onLongPress` event callbacks for advanced interaction handling. Update your widget usage to handle these events if needed.


### 🎯 Major Progress Bar Overhaul
* **Perfect Seeking Logic**: Complete redesign of video seeking functionality
  - Tap anywhere on progress bar for instant seeking
  - Smooth drag-to-seek with real-time preview
  - Release-to-seek mechanism for better user control
  - Maintains playback state correctly (pause during drag, resume after)

* **Enhanced Draggable Thumb**: Professional circular progress indicator
  - Animated circular dot that grows during interaction
  - Proper positioning using LayoutBuilder for accuracy
  - Visual feedback with shadows, borders, and smooth animations
  - 60px hit area for much easier touch interaction

* **Live Thumbnail Preview**: Instagram/TikTok-style seeking preview
  - Shows preview window above progress bar during drag
  - Displays current time position in real-time
  - Smart positioning to stay within screen bounds
  - Elegant animations with scale and opacity effects

* **Production-Ready Video Controller**: Robust video management system
  - Index-based controller tracking instead of unreliable ID-based system
  - Preloading and caching for instant video transitions
  - Enhanced error handling with retry logic
  - Optimized memory management and disposal

### 🎨 UI/UX Improvements
* **Better Visual Design**: Light grey progress bar background for improved visibility
* **Responsive Touch Areas**: Increased hit areas with `HitTestBehavior.opaque` for better responsiveness
* **Smooth Animations**: Multiple animation controllers for professional feel
* **Performance Optimizations**: Efficient `ValueListenableBuilder` and `LayoutBuilder` usage

### 🚀 Crash Prevention & Stability
* **Removed All Loading Indicators**: Eliminated stuck "loading..." states
* **Robust Error Recovery**: Comprehensive error handling prevents crashes
* **Controller Lifecycle Management**: Proper initialization and disposal
* **Video State Tracking**: Accurate playback state management

### 🔧 Technical Improvements
* **Flutter Analyze Clean**: Fixed all critical errors and warnings
* **Memory Optimizations**: Efficient animation controller management
* **Gesture Detection**: Enhanced touch responsiveness and interaction
* **Code Quality**: Improved error handling and state management

### 🗑️ Removed
* **Loading Indicators**: Removed all loading widgets that caused UI blocks
* **Deprecated Dependencies**: Updated to use `withValues()` instead of deprecated `withOpacity()`
* **Complex Progress Classes**: Simplified to essential, optimized components

### 🐛 Bug Fixes
* Fixed thumb not moving during progress bar interaction
* Resolved thumbnail preview not showing during seek
* Improved drag sensitivity and touch responsiveness
* Fixed video controller initialization timing issues
* Corrected progress calculation and positioning bugs

## 0.0.2

### 🚀 New Features
* **Long-press Controls**: Added long-press to pause/play functionality with proper state tracking
* **Intelligent Retry System**: Enhanced video loading with exponential backoff and automatic cache clearing on failures
* **Configuration Enhancements**: Added new ReelConfig options:
  - `bookmarkInMoreMenu` - Move bookmark button to more menu (default: true)
  - `downloadInMoreMenu` - Move download button to more menu (default: true) 
  - `followButtonColor` - Configurable follow button color (default: white)
  - `followingButtonColor` - Color when user is following (default: white70)
* **Improved UI Organization**: Better button placement with configurable more menu options
* **Enhanced Comment System**: Redesigned comment bottom sheet with improved UI and keyboard handling
* **Live Preview Playground**: Added mini reels player in playground screen for real-time configuration testing

### 🔧 Improvements
* **Follow Button Styling**: Updated to use configurable colors instead of fixed accent color
* **Error Handling**: Better retry logic with cache management for failed video loads
* **Comment Interface**: Removed external dialog dependency, improved native comment experience
* **Code Organization**: Cleaned up duplicate imports and optimized widget structure

### 🗑️ Removed
* **Premium Features**: Removed premium-only features to maintain open-source nature
* **External Dependencies**: Reduced reliance on external dialog packages

### 🐛 Bug Fixes
* Fixed loading overlay persistence issues
* Improved video state management during long-press interactions
* Better handling of video controller lifecycle

## 0.0.1

* Initial release: TikTok/Instagram-style vertical video reels widget with caching, analytics, and rich interactions.

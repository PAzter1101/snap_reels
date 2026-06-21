# Snap Reels

Flutter package for building Instagram Reels / TikTok-style vertical video feeds with advanced streaming support (HLS, DASH, MP4).

> Fork of [flutter_awesome_reels](https://github.com/wailashraf71/flutter_awesome_reels) by wailashraf71; developed independently.

## Features

### Video streaming
- **HLS** — adaptive streaming, preferred on iOS
- **DASH** — high-quality streaming, preferred on Android
- **MP4** — universal fallback
- **Auto format selection** — by platform and network conditions
- **DRM** — custom HTTP headers for authorization

### Performance
- **Player pool** — 2 / 3 / 4 `media_kit` `Player`s sized to the device class. Decoders are reused across swipes via `player.open()` instead of create/dispose cycles.
- **Adaptive preload** — preload is reduced automatically on low-end devices.
- **Memory pressure** — non-active players are stopped when the platform signals memory pressure.
- **SHA-256 cache** — CDN tokens are stripped from the key so the same asset isn't cached multiple times.
- **Debounced preload** — fast swipes skip intermediate preload windows.

### UI / UX
- Instagram-style interface with familiar gestures.
- Configurable progress indicator with drag-to-seek and thumbnail preview.
- Shimmer placeholder while the first frame loads.
- Play/pause animation, double-tap like, long-press pause.
- Custom error and loading widgets.

### Packaging
- **Flutter plugin** — `android/consumer-rules.pro` ships the media_kit / libmpv ProGuard keep rules; R8 release builds work without host-side configuration.

## Installation

```yaml
dependencies:
  snap_reels: ^3.2.0
```

### Requirements
- Flutter ≥ 3.0
- Android 5.0+, iOS 12+, macOS 10.14+, Linux, Windows, Web

> **⚠️ Android emulator is not supported.** On a real Android device media_kit uses libmpv through JNI + hardware MediaCodec; the emulator's `goldfish` codec path doesn't deliver a usable decoder, so playback stays on a black screen. The other platforms (iOS / macOS / Linux / Windows / Web) work in VMs and browsers because they use libmpv as a native binary directly or HTML5 `<video>` on web, without the MediaCodec abstraction. Test on a real Android device (USB or [wireless debugging](https://developer.android.com/studio/run/device#wireless)).

## Quick start

```dart
import 'package:flutter/material.dart';
import 'package:snap_reels/snap_reels.dart';

class MyReelsPage extends StatefulWidget {
  @override
  State<MyReelsPage> createState() => _MyReelsPageState();
}

class _MyReelsPageState extends State<MyReelsPage> {
  late ReelController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ReelController();
    _controller.initialize(
      reels: [
        ReelModel(
          id: '1',
          videoSource: VideoSource(url: 'https://example.com/video.mp4'),
          user: const ReelUser(id: 'u1', username: 'alice'),
          likesCount: 120,
          commentsCount: 15,
          sharesCount: 5,
          duration: const Duration(seconds: 30),
        ),
      ],
      config: const ReelConfig(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SnapReels(
        reels: _controller.reels,
        controller: _controller,
        config: const ReelConfig(
          actions: ReelActionsConfig(showDownloadButton: false),
        ),
        onReelChanged: (index) => debugPrint('Reel: $index'),
        onReelLiked: (reel) => debugPrint('Liked: ${reel.id}'),
        onVideoError: (reel, error) => debugPrint('Error: $error'),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
```

## Multi-format streaming

```dart
final reel = ReelModel(
  id: 'multi_1',
  videoSource: VideoSource(
    url: 'https://example.com/video.m3u8',
    format: VideoFormat.hls,
    alternativeSources: {
      VideoFormat.dash: 'https://example.com/video.mpd',
      VideoFormat.mp4: 'https://example.com/video.mp4',
    },
  ),
  thumbnailUrl: 'https://example.com/thumb.jpg',
  duration: const Duration(minutes: 3),
  user: const ReelUser(id: 'user1', username: 'creator'),
  caption: 'Video with fallback formats',
);

final config = ReelConfig(
  enableCaching: true,
  cacheConfig: CacheConfig(
    maxCacheSize: 500 * 1024 * 1024, // 500MB
    cacheDuration: Duration(days: 7),
  ),
  preloadConfig: PreloadConfig(
    preloadAhead: 2,
    preloadBehind: 1,
    adaptivePreload: true,
  ),
);
```

## Configuration

### ReelConfig

Fields are grouped into sub-configs:

| Field | Type | Description |
|-------|------|-------------|
| `styling` | `ReelStylingConfig` | Colors (`backgroundColor`, `accentColor`, `textColor`, …), shimmer, caption, padding |
| `actions` | `ReelActionsConfig` | Button visibility / sizes (`showFollowButton`, `actionMinTapTargetSize`, …), more-menu (`reportLabel`, `customActions`, …) |
| `builders` | `ReelOverlayBuildersConfig` | UI overrides: `errorWidgetBuilder`, `loadingWidgetBuilder`, `bufferingBuilder`, `thumbnailFallbackBuilder`, `thumbnailProxyUrlBuilder` |
| `callbacks` | `ReelInteractionCallbacks` | Side-effect callbacks: `onCommentTap`, `onShareTap`, `onHashtagTap`, `onPlay`, `onPause`, `onSeek`, … |
| `progressIndicatorConfig` | `ProgressIndicatorConfig` | Progress bar styling |
| `videoPlayerConfig` | `VideoPlayerConfig` | Player behavior + `streamingConfig` |
| `preloadConfig` | `PreloadConfig` | Preload parameters |
| `cacheConfig` | `CacheConfig?` | Cache parameters (`null` = defaults) |

Remaining top-level fields: `httpClient`, `showProgressIndicator`, `showControlsOverlay`, `enableCaching`, `enableAnalytics`, `enablePullToRefresh`, `onRefresh`, `enableInfiniteScroll`, `onLoadMore`, `loadMoreThreshold`, `keepScreenAwake`, `autoPlay`, `loop`, `volume`, `progressBarPadding`.

### PreloadConfig

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| `preloadAhead` | `int` | `2` | How many videos to preload ahead |
| `preloadBehind` | `int` | `1` | How many videos to keep behind |
| `adaptivePreload` | `bool` | `true` | Reduce preload on low-end devices |
| `preloadOnWiFiOnly` | `bool` | `false` | Preload only on Wi-Fi |

### StreamingConfig

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| `preferredFormat` | `PreferredStreamingFormat` | `auto` | Preferred format |
| `enableCaching` | `bool` | `true` | Cache streams |
| `drmHeaders` | `Map<String,String>?` | `null` | HTTP headers for DRM / auth |

## Migration

### 2.x → 3.0.0

**1. ReelConfig: top-level fields grouped into sub-configs.** All colors / button visibility / sizes / builders / callbacks moved under `styling` / `actions` / `builders` / `callbacks`. Mapping:

| Old `ReelConfig` field | New location |
|---|---|
| `backgroundColor`, `accentColor`, `textColor`, `progressColor`, `followButtonColor`, `followingButtonColor`, `showShimmerWhileLoading`, `shimmerConfig`, `maxCaptionLines`, `showHashtags`, `contentBottomPadding` | `styling: ReelStylingConfig(...)` |
| `showFollowButton`, `showBookmarkButton`, `showDownloadButton`, `showMoreButton`, `showCommentButton`, `showBottomControls`, `bookmarkInMoreMenu`, `downloadInMoreMenu`, `actionMinTapTargetSize`, `actionIconSize`, `likeButtonSize`, `actionSpacing`, `hashtagMinTapTargetSize`, `customActions`, `reportLabel`, `blockLabel`, `copyLinkLabel` | `actions: ReelActionsConfig(...)` |
| `errorWidgetBuilder`, `loadingWidgetBuilder`, `errorDialogBuilder`, `bufferingBuilder`, `thumbnailFallbackBuilder`, `thumbnailProxyUrlBuilder`, `thumbnailLoadTimeout` | `builders: ReelOverlayBuildersConfig(...)` |
| `onCommentTap`, `onShareTap`, `onDownloadTap`, `onHashtagTap`, `onReportTap`, `onBlockTap`, `onCopyLinkTap`, `onPlay`, `onPause`, `onSeek` | `callbacks: ReelInteractionCallbacks(...)` |

Example:

```dart
// Before
ReelConfig(
  accentColor: Colors.red,
  showDownloadButton: false,
  bufferingBuilder: (_) => MyBufferingWidget(),
  onShareTap: (reel) => share(reel),
)

// After
ReelConfig(
  styling: ReelStylingConfig(accentColor: Colors.red),
  actions: ReelActionsConfig(showDownloadButton: false),
  builders: ReelOverlayBuildersConfig(
    bufferingBuilder: (_) => MyBufferingWidget(),
  ),
  callbacks: ReelInteractionCallbacks(
    onShareTap: (reel) => share(reel),
  ),
)
```

**2. Video frame size: `Size` → `VideoSize`.** Renamed to avoid a clash with Flutter's `dart:ui.Size`. If you used `VideoSource(dimensions: Size(1920, 1080))`, replace with `VideoSize(1920, 1080)`.

**3. Analytics bool parameters are now named.** Per VGA `avoid_positional_boolean_parameters`:

```dart
// Before
AnalyticsService().trackLike(reelId, position, true);
AnalyticsService().trackFollow(reelId, position, true);

// After
AnalyticsService().trackLike(reelId, position, isLiked: true);
AnalyticsService().trackFollow(reelId, position, isFollowing: true);
```

**4. ReelController API cleanup.** Removed no-op stubs `toggleLike`, `incrementShare`, `downloadReel`, `blockUser`, `followUser`, and the `refresh()` override (the host now receives events via callbacks / `onRefresh`). Removed the unwired `ReelConfig.preloadRange` field — configure preload via `preloadConfig: PreloadConfig(preloadAhead, preloadBehind)`.

**5. ReelController.close() for guaranteed cleanup.** `dispose()` is synchronous (Flutter limitation) and now best-effort fires `close()`. To deterministically release native resources (libmpv) before reallocating a controller, call `await controller.close()` explicitly before `dispose()`.

**6. Android plugin packaging.** The package is now a Flutter plugin with `android/consumer-rules.pro`. Host apps no longer need to hand-copy media_kit / libmpv ProGuard keep rules — they are merged automatically via `consumerProguardFiles`. Drop the duplicates from your own `proguard-rules.pro`.

---

### 2.0.0 → 2.1.0

**1. Dependencies**: `video_player` was replaced by `media_kit`. If your app imports `video_player` directly, that's untouched — the packages are independent.

**2. Emulator**: video playback only works on real Android devices. UI and feed navigation work on the emulator (thumbnails render).

**3. API**: the public API of `ReelController`, `SnapReels`, `ReelConfig`, `ReelModel` is unchanged. Transparent upgrade.

### 1.x → 2.0.0

Replace `AwesomeReels` with `SnapReels`:

```dart
// Before
AwesomeReels(reels: reels, controller: ctrl, config: config)

// After
SnapReels(reels: reels, controller: ctrl, config: config)
```

Remove `enableAdaptiveBitrate` from `StreamingConfig` (deprecated, no-op).

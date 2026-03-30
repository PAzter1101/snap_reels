# Snap Reels

A powerful and feature-rich Flutter package for creating Instagram/TikTok-like video reels with advanced streaming support including HLS, DASH, and MP4 formats.

> Fork of [flutter_awesome_reels](https://github.com/wailashraf71/flutter_awesome_reels) by wailashraf71, maintained independently.

![Snap Reels Preview](preview.png)

## Features

### 🎥 Video Streaming Support
- **HLS (HTTP Live Streaming)** — adaptive streaming, excellent iOS support
- **DASH (Dynamic Adaptive Streaming)** — high-quality streaming, broad compatibility
- **MP4** — standard format with universal support
- **Auto-format selection** — intelligent format selection based on platform and network conditions
- **Fallback to MP4** — automatic fallback if primary format fails

### 📱 Platform Optimized
- **iOS**: optimized for HLS streaming
- **Android**: optimized for DASH streaming
- **Hardware acceleration** enabled by default

### ⚡ Performance Features
- **Intelligent caching** with configurable cache size and duration, SHA-256 cache keys with CDN-token normalization
- **Adaptive preload** — on low-end devices preload is automatically reduced to prevent OOM
- **Memory pressure handling** — disposes preloaded controllers on system memory warning
- **Fast scroll protection** — serial-based init cancellation prevents stale controller from overriding current video
- **Preload prioritization** — next video preloads first (await), previous is fire-and-forget

### 🎨 UI/UX Features
- **Instagram-like interface** with familiar gestures
- **Customizable progress indicators**
- **Shimmer loading effects**
- **Error handling** with retry functionality
- **Play/pause animations**
- **Double-tap to like** with heart animation
- **Long press to pause**

### 🔧 Advanced Configuration
- **Streaming quality control** (bitrate limits, resolution)
- **DRM support** via custom HTTP headers
- **Network timeout and retry configuration**
- **Custom error and loading widgets**

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  snap_reels: ^2.0.0
```

Then run:

```bash
flutter pub get
```

## Quick Start

### Basic Usage

```dart
import 'package:flutter/material.dart';
import 'package:snap_reels/snap_reels.dart';

class MyReelsPage extends StatefulWidget {
  @override
  _MyReelsPageState createState() => _MyReelsPageState();
}

class _MyReelsPageState extends State<MyReelsPage> {
  late ReelController _controller;

  @override
  void initState() {
    super.initState();
    final reels = [
      ReelModel(
        id: '1',
        videoSource: VideoSource(
          url: 'https://example.com/video.mp4',
        ),
        user: const ReelUser(
          id: 'u1',
          username: 'alice',
          displayName: 'Alice',
        ),
        likesCount: 120,
        commentsCount: 15,
        sharesCount: 5,
        duration: const Duration(seconds: 30),
      ),
    ];
    _controller = ReelController();
    _controller.initialize(reels: reels, config: ReelConfig());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SnapReels(
        reels: _controller.reels,
        controller: _controller,
        config: ReelConfig(
          showDownloadButton: false,
          enablePullToRefresh: true,
        ),
        onReelChanged: (index) {
          debugPrint('Reel changed to index: $index');
        },
        onReelLiked: (reel) {
          debugPrint('${reel.isLiked ? 'Liked' : 'Unliked'} ${reel.user?.displayName}');
        },
        onReelShared: (reel) {
          debugPrint('Shared ${reel.user?.displayName}');
        },
        onReelCommented: (reel) {
          // Show comment dialog or navigate to comments page
        },
        onUserFollowed: (user) {
          debugPrint('${user.isFollowing ? 'Following' : 'Unfollowed'} ${user.displayName}');
        },
        onVideoCompleted: (reel) {
          debugPrint('Video completed: ${reel.id}');
        },
        onVideoError: (reel, error) {
          debugPrint('Error playing video: $error');
        },
        onPress: (reel) {
          debugPrint('Pressed: ${reel.id}');
        },
        onLongPress: (reel) {
          debugPrint('Long pressed: ${reel.id}');
        },
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

### Advanced Streaming Configuration

```dart
// Multi-format reel with fallback support
final multiFormatReel = ReelModel(
  id: 'multi_1',
  videoSource: VideoSource(
    format: VideoFormat.hls,
    urls: {
      VideoFormat.hls: 'https://example.com/video.m3u8',
      VideoFormat.dash: 'https://example.com/video.mpd',
      VideoFormat.mp4: 'https://example.com/video.mp4',
    },
  ),
  thumbnailUrl: 'https://example.com/thumb.jpg',
  duration: const Duration(minutes: 3),
  user: const ReelUser(
    id: 'user1',
    username: 'creator',
    profilePictureUrl: 'https://example.com/avatar.jpg',
  ),
  caption: 'Multi-format video with fallback support',
);

// Advanced streaming configuration
final streamingConfig = StreamingConfig(
  preferredFormat: PreferredStreamingFormat.hls,
  enableLowLatency: false,
  maxBitrate: 5000000, // 5 Mbps
  minBitrate: 500000,  // 500 Kbps
  fallbackToMp4: true,
  networkTimeout: 30,    // seconds
  retryAttempts: 3,
  enableDrm: false,
);

final config = ReelConfig(
  enableCaching: true,
  cacheConfig: CacheConfig(
    maxCacheSize: 500 * 1024 * 1024, // 500MB
    cacheDuration: Duration(days: 7),
  ),
  videoPlayerConfig: VideoPlayerConfig(
    enableHardwareAcceleration: true,
    enablePictureInPicture: true,
    streamingConfig: streamingConfig,
  ),
  preloadConfig: PreloadConfig(
    preloadAhead: 2,
    preloadBehind: 1,
    adaptivePreload: true, // reduce preload on low-end devices automatically
  ),
);
```

## Streaming Formats

### HLS (HTTP Live Streaming)
- **Best for**: iOS devices, adaptive streaming
- **File extension**: `.m3u8`
- **Platform support**: excellent on iOS, good on Android/Web

```dart
ReelModel.hls(
  id: 'hls_video',
  hlsUrl: 'https://example.com/playlist.m3u8',
  // ... other properties
);
```

### DASH (Dynamic Adaptive Streaming)
- **Best for**: Android devices, high-quality streaming
- **File extension**: `.mpd`
- **Platform support**: excellent on Android, good on Web

```dart
ReelModel.dash(
  id: 'dash_video',
  dashUrl: 'https://example.com/manifest.mpd',
  // ... other properties
);
```

### MP4 (Standard Video)
- **Best for**: universal compatibility
- **File extension**: `.mp4`
- **Platform support**: universal

```dart
ReelModel.mp4(
  id: 'mp4_video',
  mp4Url: 'https://example.com/video.mp4',
  // ... other properties
);
```

## Configuration Reference

### ReelConfig

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `enableCaching` | `bool` | `true` | Enable video caching |
| `cacheConfig` | `CacheConfig` | `CacheConfig()` | Cache configuration |
| `preloadConfig` | `PreloadConfig` | `PreloadConfig()` | Preloading settings |
| `videoPlayerConfig` | `VideoPlayerConfig` | `VideoPlayerConfig()` | Video player configuration |
| `enablePullToRefresh` | `bool` | `false` | Pull-to-refresh on reel list |
| `showDownloadButton` | `bool` | `false` | Show download button |

### PreloadConfig

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `preloadAhead` | `int` | `2` | Videos to preload forward |
| `preloadBehind` | `int` | `1` | Videos to keep preloaded behind |
| `maxPreloaded` | `int` | `5` | Max simultaneous preloaded controllers |
| `adaptivePreload` | `bool` | `true` | Auto-reduce on low-end devices |
| `preloadOnWiFiOnly` | `bool` | `false` | Restrict preload to WiFi |

### StreamingConfig

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `preferredFormat` | `PreferredStreamingFormat` | `auto` | Preferred format |
| `enableLowLatency` | `bool` | `false` | Low latency HLS mode |
| `maxBitrate` | `int?` | `null` | Max bitrate in bps |
| `minBitrate` | `int?` | `null` | Min bitrate in bps |
| `fallbackToMp4` | `bool` | `true` | Fallback to MP4 on error |
| `networkTimeout` | `int` | `30` | Timeout in seconds |
| `retryAttempts` | `int` | `3` | Retry count on failure |
| `enableDrm` | `bool` | `false` | Enable DRM via headers |
| `drmHeaders` | `Map<String,String>?` | `null` | Custom HTTP headers (for DRM/auth) |

---

## Migration Guide (1.x → 2.0.0)

### 1. Переименование виджета

Замените `AwesomeReels` на `SnapReels` во всех файлах:

```dart
// До (1.x)
AwesomeReels(
  reels: _controller.reels,
  controller: _controller,
  config: ReelConfig(),
)

// После (2.0.0)
SnapReels(
  reels: _controller.reels,
  controller: _controller,
  config: ReelConfig(),
)
```

### 2. Удаление устаревшего параметра

`enableAdaptiveBitrate` помечен как `@Deprecated` и не имеет эффекта. Просто удалите его:

```dart
// До (1.x)
StreamingConfig(
  preferredFormat: PreferredStreamingFormat.hls,
  enableAdaptiveBitrate: true,   // <-- удалите эту строку
)

// После (2.0.0)
StreamingConfig(
  preferredFormat: PreferredStreamingFormat.hls,
)
```

### 3. Ничего больше не нужно менять

Все остальные API обратно совместимы. Публичные классы и методы (`ReelController`, `ReelModel`, `ReelConfig`, `VideoSource`, etc.) не изменились.

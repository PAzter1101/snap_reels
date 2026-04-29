# Snap Reels

Flutter-пакет для создания вертикальных видеолент в стиле Instagram Reels / TikTok с продвинутой поддержкой стриминга (HLS, DASH, MP4).

> Fork [flutter_awesome_reels](https://github.com/wailashraf71/flutter_awesome_reels) от wailashraf71, развивается независимо.

## Возможности

### Видео-стриминг
- **HLS** — адаптивный стриминг, оптимален для iOS
- **DASH** — высококачественный стриминг, оптимален для Android
- **MP4** — универсальный формат
- **Автовыбор формата** — по платформе и состоянию сети
- **DRM** — кастомные HTTP-заголовки для авторизации

### Производительность
- **Player Pool** — фиксированный пул из 3 `Player`'ов (media_kit). При свайпе декодер переиспользуется через `player.open()`, без create/dispose цикла
- **Адаптивный preload** — на слабых устройствах preload автоматически снижается
- **Memory pressure** — при нехватке памяти неактивные Player'ы останавливаются
- **SHA-256 кеш** — нормализация CDN-токенов, без дублей в кеше
- **Debounced preload** — при быстром скролле промежуточные preload'ы пропускаются

### UI/UX
- Интерфейс в стиле Instagram с привычными жестами
- Настраиваемый progress indicator с drag-to-seek и превью
- Shimmer-эффект при загрузке
- Play/pause анимация, double-tap лайк, long press пауза
- Кастомные виджеты ошибок и загрузки

## Установка

```yaml
dependencies:
  snap_reels: ^2.3.2
```

### Требования
- Flutter ≥ 3.0
- Android 5.0+ (реальное устройство)
- iOS 12+

> **⚠️ Android-эмулятор не поддерживается** — media_kit использует hardware-декодеры через libmpv, которые не работают на эмуляторе. Тестируйте на реальном устройстве (USB или [wireless debugging](https://developer.android.com/studio/run/device#wireless)).

## Быстрый старт

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
        config: const ReelConfig(showDownloadButton: false),
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

## Многоформатный стриминг

```dart
final reel = ReelModel(
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
  user: const ReelUser(id: 'user1', username: 'creator'),
  caption: 'Видео с fallback-форматами',
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

## Конфигурация

### ReelConfig

| Свойство | Тип | По умолчанию | Описание |
|----------|-----|-------------|----------|
| `enableCaching` | `bool` | `true` | Кеширование видео на диск |
| `cacheConfig` | `CacheConfig` | `CacheConfig()` | Настройки кеша |
| `preloadConfig` | `PreloadConfig` | `PreloadConfig()` | Настройки preload |
| `autoPlay` | `bool` | `true` | Автозапуск при появлении на экране |
| `showDownloadButton` | `bool` | `true` | Кнопка скачивания |
| `showHashtags` | `bool` | `true` | Хештеги под описанием |
| `enablePullToRefresh` | `bool` | `false` | Pull-to-refresh |

### PreloadConfig

| Свойство | Тип | По умолчанию | Описание |
|----------|-----|-------------|----------|
| `preloadAhead` | `int` | `2` | Сколько видео preload'ить вперёд |
| `preloadBehind` | `int` | `1` | Сколько видео держать позади |
| `adaptivePreload` | `bool` | `true` | Снижать preload на слабых устройствах |
| `preloadOnWiFiOnly` | `bool` | `false` | Preload только по WiFi |

### StreamingConfig

| Свойство | Тип | По умолчанию | Описание |
|----------|-----|-------------|----------|
| `preferredFormat` | `PreferredStreamingFormat` | `auto` | Предпочтительный формат |
| `enableCaching` | `bool` | `true` | Кеширование стримов |
| `drmHeaders` | `Map<String,String>?` | `null` | HTTP-заголовки для DRM/auth |

## Миграция

### 2.0.0 → 2.1.0

**1. Зависимости**: `video_player` заменён на `media_kit`. Если ваше приложение импортирует `video_player` напрямую — это не затрагивается, пакеты независимы.

**2. Эмулятор**: видеовоспроизведение работает только на реальных Android-устройствах. UI и навигация по ленте работают на эмуляторе (thumbnail отображаются).

**3. API**: публичный API `ReelController`, `SnapReels`, `ReelConfig`, `ReelModel` не изменился. Обновление прозрачное.

### 1.x → 2.0.0

Замените `AwesomeReels` на `SnapReels`:

```dart
// До
AwesomeReels(reels: reels, controller: ctrl, config: config)

// После
SnapReels(reels: reels, controller: ctrl, config: config)
```

Удалите `enableAdaptiveBitrate` из `StreamingConfig` (deprecated, без эффекта).

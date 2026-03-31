## 2.1.0

### ⚠️ Breaking Changes
- **Миграция на media_kit** — `video_player` заменён на `media_kit` + `media_kit_video` + `media_kit_libs_video`. Пакет `video_player` больше не используется. Приложение должно вызвать `MediaKit.ensureInitialized()` до использования (вызывается автоматически в `ReelController.initialize()`).
- **Не работает на Android-эмуляторе** — media_kit не поддерживает рендеринг текстур на эмуляторе. Тестирование — только на реальных устройствах.

### Performance
- **Player Pool (3 слота)** — вместо create/dispose цикла на каждый свайп теперь используется фиксированный пул из 3 `Player`'ов (prev/current/next). При переключении видео вызывается `player.open()` на существующем Player'е — hardware-декодер переиспользуется без пересоздания. Устраняет исчерпание пула декодеров и GC-давление при быстром скролле.
- **Slot recycling** — при свайпе самый дальний слот автоматически переиспользуется для preload следующего видео. Без dispose/recreate нативных ресурсов.

### Architecture
- **Декомпозиция reel_controller.dart** — 770 строк разбиты на 5 part-файлов:
  - `_reel_state_mixin.dart` — реактивное состояние и геттеры
  - `_video_lifecycle_mixin.dart` — пул Player'ов, slot assignment, stream-подписки
  - `_preload_manager_mixin.dart` — preload через slot recycling
  - `_playback_mixin.dart` — play/pause/volume/seek
  - `reel_controller.dart` — тонкий оркестратор

### Bug Fixes
- **Фикс гонки `_isVideoInitializing`** — отменённые инициализации (serial mismatch) больше не сбрасывают `_isVideoInitializing` в `finally`, что исправляет баг с незагрузкой видео при быстром свайпе через 4-5 страниц.
- **Фикс race condition при реинициализации** — пул создаётся один раз, при повторных `initialize()` выполняется `_resetPool()` (stop + clear assignments) вместо dispose/recreate, исключая ошибку "Player has been disposed".

### Maintenance
- Убран `video_player` из зависимостей.
- Убран хардкод `User-Agent` из `cache_manager.dart`.
- Убраны `VideoPlayerController`-методы из `cache_manager.dart` и `streaming_service.dart` — пул управляет Player'ами самостоятельно.
- `streaming_service.dart` упрощён до `resolveStreamingUrl()` — только выбор формата (HLS/DASH/MP4), без создания контроллеров.
- `reel_progress_indicator.dart` переведён с `ValueListenableBuilder<VideoPlayerValue>` на `Obx` с `currentPosition`/`totalDuration`.
- `reel_overlay.dart` — убраны прямые обращения к `VideoPlayerController`, используются Rx-геттеры.

---

## 2.0.0

### ⚠️ Breaking Changes
- **`AwesomeReels` переименован в `SnapReels`** — главный виджет теперь называется `SnapReels`. Замените все вхождения `AwesomeReels(...)` на `SnapReels(...)` в вашем коде.

### Deprecations
- `StreamingConfig.enableAdaptiveBitrate` помечен `@Deprecated` — параметр не имел эффекта и будет удалён в v3.0.0. Просто уберите его из кода.

### Performance
- **SHA-256 cache keys**: хэш кэша теперь вычисляется через SHA-256 вместо `url.hashCode`. Устраняет коллизии и недетерминированность на web-платформе.
- **URL normalization**: CDN-токены (`token`, `sig`, `expires`, `auth` и др.) вырезаются перед хэшированием — одно видео с разными токенами авторизации больше не дублируется в кэше.
- **Memory pressure handling**: при системном сигнале нехватки памяти все preloaded контроллеры диспоузятся, memory-кэш очищается. Предотвращает OOM-kill на устройствах с 2–3 GB RAM.
- **Adaptive preload**: на слабых устройствах (Android SDK < 28, iPhone < 11 поколения) preloadAhead автоматически снижается до 1, preloadBehind до 0 — экономия ~2 hw-декодеров.
- **Preload prioritization**: `next` preload выполняется первым (`await`), `prev` — fire-and-forget, так как 80% скроллов идут вниз.
- **Debounced preload**: при быстром скролле preload промежуточных страниц пропускается (debounce 200 мс) — нет лишних init/dispose циклов.
- **Serial-based init cancellation**: каждый `onPageChanged` присваивает уникальный serial; если до конца инициализации страница сменилась снова — инициализация отменяется и контроллер диспоузится. Устраняет баг: после 4-5 быстрых свайпов видео не воспроизводилось, показывался только thumbnail.

### Maintenance
- Добавлена зависимость `crypto: ^3.0.6` для SHA-256.
- Файл `reel_config.dart` декомпозирован: `CacheConfig`/`PreloadConfig` → `cache_config.dart`, `StreamingConfig` → `streaming_config.dart`, `VideoPlayerConfig` → `video_player_config.dart`, `ProgressIndicatorConfig` → `progress_config.dart`. Публичное API не изменилось.
- `CacheItem` и `CacheStats` вынесены в `models/cache_item.dart`.
- Добавлен `DeviceClassifier` (`utils/device_classifier.dart`) с классификацией устройств: `low / medium / high`.
- User-Agent изменён с `AwesomeReels/1.0.0` на `SnapReels/1.3.0`.

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

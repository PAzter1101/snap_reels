# Roadmap

Планы по оптимизации и развитию snap_reels.

## Выполнено (v1.3.0)

- **Нормализация cache key** — SHA-256 вместо `hashCode`, CDN-токены убираются перед хэшированием
- **Deprecate `enableAdaptiveBitrate`** — помечен `@Deprecated`, noop-код удалён
- **Приоритизация preload** — next видео грузится первым (await), prev — в фоне
- **Memory pressure handling** — `didHaveMemoryPressure()` диспозит preloaded контроллеры и чистит memory-кэш
- **Адаптивный preload** — `DeviceClassifier` определяет класс устройства, на слабых снижает preloadAhead до 1
- **Декомпозиция reel_config.dart** — 682 строки разбиты на 5 файлов (cache_config, progress_config, streaming_config, video_player_config)
- **Вынос cache_item.dart** — `CacheItem` и `CacheStats` в отдельном файле

## В работе

### Декомпозиция reel_controller.dart
747 строк. Планируется разбить на controller + video_lifecycle_mixin + preload_manager + playback_mixin. Требует осторожного mixin-рефакторинга из-за общего состояния.

### Пул видео-контроллеров
`VideoPlayerController` не поддерживает смену source — полноценный пул невозможен. Исследовать альтернативные подходы к минимизации GC-давления при быстром скролле.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:audioplayers/audioplayers.dart';

/// 1. Klasa trzymająca stan audio (reaktywna dla UI)
class AudioState {
  final bool isMuted;
  final double bgmVolume;
  final double sfxVolume;

  const AudioState({
    this.isMuted = false,
    this.bgmVolume = 0.5,
    this.sfxVolume = 1.0,
  });

  AudioState copyWith({
    bool? isMuted,
    double? bgmVolume,
    double? sfxVolume,
  }) {
    return AudioState(
      isMuted: isMuted ?? this.isMuted,
      bgmVolume: bgmVolume ?? this.bgmVolume,
      sfxVolume: sfxVolume ?? this.sfxVolume,
    );
  }
}

/// 2. Klasa zarządzająca logiką audio
class AudioManager extends Notifier<AudioState> {
  late final AudioPlayer _bgmPlayer;
  AppLifecycleListener? _lifecycleListener; 
  
  @override
  AudioState build() {
    // Inicjalizacja odtwarzacza przy tworzeniu providera
    _bgmPlayer = AudioPlayer();
    _bgmPlayer.setReleaseMode(ReleaseMode.loop); // Muzyka w tle zapętlona

     _lifecycleListener = AppLifecycleListener(
      onStateChange: _handleAppLifecycle,
    );

    // Sprzątanie pamięci, gdyby provider został zniszczony
    ref.onDispose(() {
      _bgmPlayer.stop();
      _bgmPlayer.dispose();
    });

    // Zwracamy początkowy stan
    return const AudioState();
  }

  /// Odtwarzanie muzyki w tle
  Future<void> playBGM(String fileName) async {
    await _bgmPlayer.play(
      AssetSource(fileName),
      volume: state.isMuted ? 0.0 : state.bgmVolume,
    );
  }

    void _handleAppLifecycle(AppLifecycleState state) {
    if (state == AppLifecycleState.paused || state == AppLifecycleState.hidden) {
      // Aplikacja schowana w tle -> pauzujemy muzykę
      _bgmPlayer.pause();
    } else if (state == AppLifecycleState.resumed) {
      // Użytkownik wrócił do gry -> wznawiamy muzykę
      // (Będzie grać tylko z taką głośnością, jaka była ustawiona przed zminimalizowaniem)
      _bgmPlayer.resume();
    }
  }

  Future<void> stopBGM() async => await _bgmPlayer.stop();
  Future<void> pauseBGM() async => await _bgmPlayer.pause();
  Future<void> resumeBGM() async => await _bgmPlayer.resume();

  /// Odtwarzanie efektów (SFX)
  Future<void> playSFX(String fileName) async {
    if (state.isMuted) return;

    final sfxPlayer = AudioPlayer();
    await sfxPlayer.play(AssetSource(fileName), volume: state.sfxVolume);

    sfxPlayer.onPlayerComplete.listen((_) {
      sfxPlayer.dispose(); // Zwalniamy zasoby po odegraniu dźwięku
    });
  }

  /// Przełączanie wyciszenia
  void toggleMute() {
    final newMutedState = !state.isMuted;
    
    // Aktualizujemy stan, by UI mogło zareagować
    state = state.copyWith(isMuted: newMutedState);

    // Wyciszamy lub przywracamy głośność w fizycznym odtwarzaczu
    if (newMutedState) {
      _bgmPlayer.setVolume(0.0);
    } else {
      _bgmPlayer.setVolume(state.bgmVolume);
    }
  }

  void setBgmVolume(double volume) {
    final clampedVolume = volume.clamp(0.0, 1.0);
    state = state.copyWith(bgmVolume: clampedVolume);
    
    if (!state.isMuted) {
      _bgmPlayer.setVolume(clampedVolume);
    }
  }

  void setSfxVolume(double volume) {
    state = state.copyWith(sfxVolume: volume.clamp(0.0, 1.0));
  }
}

/// 3. Globalny Provider, z którego będziesz korzystać w całej aplikacji
final audioManagerProvider = NotifierProvider<AudioManager, AudioState>(() {
  return AudioManager();
});
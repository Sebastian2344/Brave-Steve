import 'package:brave_steve/modules/settings/menagment/settings_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:audioplayers/audioplayers.dart';

/// Klasa zarządzająca logiką audio
class AudioManager extends Notifier<void> {
  late final AudioPlayer _bgmPlayer;
  AppLifecycleListener? lifecycleListener;

  @override
  void build() {
    // Inicjalizacja odtwarzacza przy tworzeniu providera
    _bgmPlayer = AudioPlayer(playerId: 'BGM');
    _bgmPlayer.setReleaseMode(ReleaseMode.loop); // Muzyka w tle zapętlona
    _bgmPlayer.setPlayerMode(PlayerMode.mediaPlayer);
    _bgmPlayer.setAudioContext(AudioContext(
        android: AudioContextAndroid(
            contentType: AndroidContentType.music,
            audioFocus: AndroidAudioFocus.gain)));

    lifecycleListener = AppLifecycleListener(
      onStateChange: _handleAppLifecycle,
    );

    // Sprzątanie pamięci, gdyby provider został zniszczony
    ref.onDispose(() {
      _bgmPlayer.stop();
      _bgmPlayer.dispose();
      lifecycleListener?.dispose();
    });
  }

  /// Odtwarzanie muzyki w tle
  Future<void> playBGM(String fileName) async {
    await _bgmPlayer.play(
      AssetSource(fileName),
      volume: ref.read(settingsProvider).isMusicMuted
          ? 0.0
          : ref.read(settingsProvider).volumeMusic,
    );
  }

  void _handleAppLifecycle(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.hidden) {
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
  Future<void> startBMG() async => await playBGM('sounds/gigachad_music.mp3');

  /// Przełączanie wyciszenia
  void toggleMute() {
    ref.read(settingsProvider.notifier).toggleMusicMute();
    final newMutedState = ref
        .read(settingsProvider)
        .isMusicMuted; // Pobieramy aktualny stan wyciszenia z SettingsController

    // Wyciszamy lub przywracamy głośność w fizycznym odtwarzaczu
    if (newMutedState) {
      _bgmPlayer.setVolume(0.0);
    } else {
      _bgmPlayer.setVolume(ref.read(settingsProvider).volumeMusic);
    }
  }

  void setBgmVolume(double volume) {
    final clampedVolume = volume.clamp(0.0, 1.0);

    if (!ref.read(settingsProvider).isMusicMuted) {
      ref.read(settingsProvider.notifier).setMusicVolume(clampedVolume);
      _bgmPlayer.setVolume(clampedVolume);
    }
  }
}

/// 3. Globalny Provider, z którego będziesz korzystać w całej aplikacji
final audioManagerProvider = NotifierProvider<AudioManager, void>(
  AudioManager.new,
);

import 'package:audioplayers/audioplayers.dart';
import 'package:brave_steve/modules/settings/menagment/settings_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SoundController extends Notifier<void> {
    late final AudioPlayer _sfxPlayer;
    final Map<String, Source> _audioCache = {};

  @override
  void build() {
    _sfxPlayer = AudioPlayer(playerId: 'SFX');
    _sfxPlayer.setPlayerMode(PlayerMode.lowLatency);
    _sfxPlayer.setAudioContext(AudioContext(
        android: AudioContextAndroid(
            contentType: AndroidContentType.sonification,
            audioFocus: AndroidAudioFocus.none)));

    final soundFiles = [
      'sounds/level_up.mp3',
      'sounds/button_click.mp3',
      'sounds/sword_hit.mp3',
      'sounds/death.mp3',
      'sounds/clearence.mp3',
      'sounds/weakness.mp3',
      'sounds/upgrade_item.mp3',
      'sounds/take_off.mp3',
      'sounds/wear_item.mp3',
      'sounds/merge.mp3'
    ];

    // PRELOADING: Tworzymy obiekty Source raz i trzymamy w pamięci
    for (var fileName in soundFiles) {
      _audioCache[fileName] = AssetSource(fileName);
    }

    ref.onDispose(() {
      _sfxPlayer.stop();
      _sfxPlayer.dispose();
    });
  }

  bool _canPlaySound() {
    return !ref.read(settingsProvider).isSoundEffectsMuted;
  }

  Future<void> _playSFX(String fileName) async {
    final settings = ref.read(settingsProvider);
    if (settings.isSoundEffectsMuted) return;
    final source = _audioCache[fileName];
    if (source == null) return;
    if (_sfxPlayer.state == PlayerState.playing) {
      await _sfxPlayer.stop(); 
    }
    await _sfxPlayer.play(
      source,
      volume: ref.read(settingsProvider).isSoundEffectsMuted ? 0.0 : ref.read(settingsProvider).volumeSoundEffects,
    );
  }

  // Udostępniamy metody do UI:
  void playLevelUp() {
    if (_canPlaySound()) _playSFX('sounds/level_up.mp3');
  }

  void playDamage() {
    if (_canPlaySound()) _playSFX('sounds/sword_hit.mp3');
  }

  void playDeath() {
    if (_canPlaySound())  _playSFX('sounds/death.mp3');
  }

  void playWeakness() {
    if (_canPlaySound()) _playSFX('sounds/weakness.mp3');
  }

  void playClearence() {
    if (_canPlaySound()) _playSFX('sounds/clearence.mp3');
  }

  void playMerge() {
    if (_canPlaySound()) _playSFX('sounds/merge.mp3');
  }

  void playWearItem() {
    if (_canPlaySound()) _playSFX('sounds/wear_item.mp3');
  }

  void playTakeOff() {
    if (_canPlaySound()) _playSFX('sounds/take_off.mp3');
  }

  void playUpgradeItem() {
    if (_canPlaySound()) _playSFX('sounds/upgrade_item.mp3');
  }

  void playButtonClick() {
    if (_canPlaySound()) _playSFX('sounds/button_click.mp3');
  }

  void setVolume(double volume) {
    final clampedVolume = volume.clamp(0.0, 1.0);
    
    if (!ref.read(settingsProvider).isMusicMuted) {
      ref.read(settingsProvider.notifier).setSoundEffectsVolume(clampedVolume);
      _sfxPlayer.setVolume(clampedVolume);
    }
  }

  void toggleMute() {
    ref.read(settingsProvider.notifier).toggleSoundEffectsMute();
    final newMutedState = ref.read(settingsProvider).isSoundEffectsMuted;
    // Po przełączeniu stanu wyciszenia, aktualizujemy głośność w serwisie
    if (newMutedState) {
      _sfxPlayer.setVolume(0.0);
    } else {
      _sfxPlayer.setVolume(ref.read(settingsProvider).volumeSoundEffects);
    }
  }
}

// 3. Provider Controllera do użycia w widgetach
final soundManagerProvider = NotifierProvider<SoundController, void>(
  SoundController.new,
);

import 'package:brave_steve/core/di/providers.dart';
import 'package:brave_steve/modules/settings/menagment/settings_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SoundController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {
    // Inicjalizujemy ładowanie dźwięków od razu przy stworzeniu Controllera
    // Będzie to działać asynchronicznie w tle.
    await ref.read(soundServiceProvider).loadAllSounds();
    // Zwracamy początkowy stan
  }

  // Przykładowa logika: Jeśli chcesz mieć globalne wyciszenie dźwięków,
  // możesz to sprawdzić tutaj, zanim wywołasz metodę z serwisu.
  bool _canPlaySound() {
    return !ref.read(settingsProvider).isSoundEffectsMuted;
  }

  // Udostępniamy metody do UI:
  void playLevelUp() {
    if (_canPlaySound()) ref.read(soundServiceProvider).playLevelUp();
  }

  void playDamage() {
    if (_canPlaySound()) ref.read(soundServiceProvider).playDamage();
  }

  void playDeath() {
    if (_canPlaySound()) ref.read(soundServiceProvider).playDeath();
  }

  void playWeakness() {
    if (_canPlaySound()) ref.read(soundServiceProvider).playWeakness();
  }

  void playClearence() {
    if (_canPlaySound()) ref.read(soundServiceProvider).playClearence();
  }

  void playMerge() {
    if (_canPlaySound()) ref.read(soundServiceProvider).playMerge();
  }

  void playWearItem() {
    if (_canPlaySound()) ref.read(soundServiceProvider).playWearItem();
  }

  void playTakeOff() {
    if (_canPlaySound()) ref.read(soundServiceProvider).playTakeOff();
  }

  void playUpgradeItem() {
    if (_canPlaySound()) ref.read(soundServiceProvider).playUpgradeItem();
  }

  void playButtonClick() {
    if (_canPlaySound()) ref.read(soundServiceProvider).playButtonClick();
  }

  void setVolume(double volume) {
    ref.read(settingsProvider.notifier).setSoundEffectsVolume(volume);
    ref.read(soundServiceProvider).setVolume(volume);
  }

  void toggleMute() {
    ref.read(settingsProvider.notifier).toggleSoundEffectsMute();
    final newMutedState = ref.read(settingsProvider).isSoundEffectsMuted;
    // Po przełączeniu stanu wyciszenia, aktualizujemy głośność w serwisie
    if (newMutedState) {
      ref.read(soundServiceProvider).setVolume(0.0);
    } else {
      // Przywracamy głośność do ostatnio ustawionej wartości (lub domyślnej)
      ref.read(soundServiceProvider).setVolume(ref.read(settingsProvider).volumeSoundEffects);
    }
  }
}

// 3. Provider Controllera do użycia w widgetach
final soundManagerProvider = AsyncNotifierProvider<SoundController, void>(
  SoundController.new,
);

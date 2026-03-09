import 'package:brave_steve/game/data_layer/repo/sounds_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SoundController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {
    // Inicjalizujemy ładowanie dźwięków od razu przy stworzeniu Controllera
    // Będzie to działać asynchronicznie w tle.
    await ref.read(soundServiceProvider).loadAllSounds();
  }

  // Przykładowa logika: Jeśli chcesz mieć globalne wyciszenie dźwięków,
  // możesz to sprawdzić tutaj, zanim wywołasz metodę z serwisu.
  bool _canPlaySound() {
    // Tu mógłbyś odczytywać np. stan z settingsProvider
    // return !ref.read(settingsProvider).isMuted;
    return true; 
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
}

// 3. Provider Controllera do użycia w widgetach
final soundManagerProvider = AsyncNotifierProvider<SoundController, void>(
  SoundController.new,
);

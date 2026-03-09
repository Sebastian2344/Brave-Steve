import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soundpool/soundpool.dart';

class SoundService {
  Soundpool? _pool;

  // Twoje zmienne przetrzymujące ID dźwięków w pamięci
  int? _levelUpSoundId;
  int? _damageSoundId;
  int? _deathSoundId;
  int? _weaknessSoundId;
  int? _clearenceSoundId;
  int? _mergeSoundId;
  int? _wearItemSoundId;
  int? _takeOffSoundId;
  int? _upgradeItemSoundId;
  int? _buttonClickSoundId;

  SoundService() {
    _pool = Soundpool.fromOptions(
      options: const SoundpoolOptions(streamType: StreamType.notification),
    );
  }

  /// Główna metoda do załadowania wszystkich dźwięków (np. przy starcie aplikacji)
  Future<void> loadAllSounds() async {
    // Uwaga: Zmień ścieżki "assets/sounds/..." na takie, jakie masz w projekcie
    _levelUpSoundId = await _loadSoundAsset("assets/sounds/level_up.mp3");
    _damageSoundId = await _loadSoundAsset("assets/sounds/sword_hit.mp3");
    _deathSoundId = await _loadSoundAsset("assets/sounds/death.mp3");
    _weaknessSoundId = await _loadSoundAsset("assets/sounds/weakness.mp3");
    _clearenceSoundId = await _loadSoundAsset("assets/sounds/clearence.mp3");
    //_mergeSoundId = await _loadSoundAsset("assets/sounds/merge.mp3");
    //_wearItemSoundId = await _loadSoundAsset("assets/sounds/wear_item.mp3");
    //_takeOffSoundId = await _loadSoundAsset("assets/sounds/take_off.mp3");
    _upgradeItemSoundId = await _loadSoundAsset("assets/sounds/upgrade_item.mp3");
    _buttonClickSoundId = await _loadSoundAsset("assets/sounds/button_click.mp3");
  }

  /// Prywatny helper: Ładuje dźwięk z podanej ścieżki i zwraca jego ID
  Future<int?> _loadSoundAsset(String path) async {
    try {
      final ByteData soundData = await rootBundle.load(path);
      return await _pool?.load(soundData);
    } catch (e) {
      return null;
    }
  }

  /// Prywatny helper: Odtwarza dźwięk, jeśli ten został poprawnie załadowany
  Future<void> _playSound(int? soundId) async {
    if (soundId != null) {
      await _pool?.play(soundId);
    }
  }

  // PUBLICZNE METODY ODTWARZAJĄCE (dostępne dla Riverpoda)
  Future<void> playLevelUp() => _playSound(_levelUpSoundId);
  Future<void> playDamage() => _playSound(_damageSoundId);
  Future<void> playDeath() => _playSound(_deathSoundId);
  Future<void> playWeakness() => _playSound(_weaknessSoundId);
  Future<void> playClearence() => _playSound(_clearenceSoundId);
  Future<void> playMerge() => _playSound(_mergeSoundId);
  Future<void> playWearItem() => _playSound(_wearItemSoundId);
  Future<void> playTakeOff() => _playSound(_takeOffSoundId);
  Future<void> playUpgradeItem() => _playSound(_upgradeItemSoundId);
  Future<void> playButtonClick() => _playSound(_buttonClickSoundId);

  // Zwalnianie zasobów z pamięci RAM
  void dispose() {
    _pool?.release();
  }
}

final soundServiceProvider = Provider<SoundService>((ref) {
  final service = SoundService();
  ref.onDispose(() => service.dispose());
  return service;
});
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsState extends Equatable {
  final bool isMusicMuted;
  final bool isSoundEffectsMuted;
  final double volumeMusic;
  final double volumeSoundEffects;

  const SettingsState(this.isMusicMuted, this.isSoundEffectsMuted, this.volumeMusic, this.volumeSoundEffects);

  SettingsState copyWith({
    bool? isMusicMuted,
    bool? isSoundEffectsMuted,
    double? volumeMusic,
    double? volumeSoundEffects,
  }) {
    return SettingsState(
      isMusicMuted ?? this.isMusicMuted,
      isSoundEffectsMuted ?? this.isSoundEffectsMuted,
      volumeMusic ?? this.volumeMusic,
      volumeSoundEffects ?? this.volumeSoundEffects,
    );
  }

  @override
  List<Object?> get props => [isMusicMuted, isSoundEffectsMuted, volumeMusic, volumeSoundEffects];
}

class SettingsController extends Notifier<SettingsState> {
  @override
  SettingsState build() {
      return const SettingsState(false, false, 0.25, 0.5); // Domyślne ustawienia
  }
  
  void toggleMusicMute() {
    state = state.copyWith(isMusicMuted: !state.isMusicMuted);
  }

  void toggleSoundEffectsMute() {
    state = state.copyWith(isSoundEffectsMuted: !state.isSoundEffectsMuted);
  }

  void setMusicVolume(double volume) {
    state = state.copyWith(volumeMusic: volume);
  }

  void setSoundEffectsVolume(double volume) {
    state = state.copyWith(volumeSoundEffects: volume);
  }
}

final settingsProvider = NotifierProvider<SettingsController, SettingsState>(() {
  return SettingsController();
});
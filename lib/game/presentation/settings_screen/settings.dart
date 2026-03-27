import 'package:brave_steve/game/state_menegment/music_state.dart';
import 'package:brave_steve/game/state_menegment/settings_state.dart';
import 'package:brave_steve/game/state_menegment/sound_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ustawienia',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            const Text(
              'Dźwięk i wibracje',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 24),
            
            // Karta ustawień Muzyki
            Consumer(
              builder: (context, ref, child) {
                final audioState = ref.watch(settingsProvider); // Odsłuchujemy zmiany stanu SoundControllera
                return _buildSoundControlCard(
                  title: 'Muzyka w tle',
                  icon: Icons.music_note_rounded,
                  volume: audioState.volumeMusic, // Tutaj podłączysz stan z AudioManagera
                  isMuted: audioState.isMusicMuted, // Tutaj podłączysz stan z AudioManagera
                  onVolumeChanged: (value) {
                    ref.read(audioManagerProvider.notifier).setBgmVolume(value); // Tutaj wywołasz metodę z AudioManagera do ustawiania głośności
                  },
                  onMuteToggle: () {
                    ref.read(audioManagerProvider.notifier).toggleMute(); // Tutaj wywołasz metodę z AudioManagera do przełączania wyciszenia
                  },
                  context: context, // Przekazujemy kontekst do karty, by mogła dostosować kolory
                );
              },
            ),
            
            const SizedBox(height: 20),
            
            // Karta ustawień Efektów
            Consumer(
              builder: (context, ref, child) {
                final soundState = ref.watch(settingsProvider); // Odsłuchujemy zmiany stanu SoundControllera
                return _buildSoundControlCard(
                  title: 'Efekty dźwiękowe',
                  icon: Icons.gamepad_rounded,
                  volume: soundState.volumeSoundEffects, // Tutaj podłączysz stan z SoundControllera
                  isMuted: soundState.isSoundEffectsMuted, // Tutaj podłączysz stan z SoundControllera
                  onVolumeChanged: (value) {
                    ref.read(soundManagerProvider.notifier).setVolume(value);
                  },
                  onMuteToggle: () {
                    ref.read(soundManagerProvider.notifier).toggleMute();
                  },
                  context: context, // Przekazujemy kontekst do karty, by mogła dostosować kolory
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Uniwersalny Widget reprezentujący pojedynczą kartę (ładny design)
  Widget _buildSoundControlCard({
    required String title,
    required IconData icon,
    required double volume,
    required bool isMuted,
    required ValueChanged<double> onVolumeChanged,
    required VoidCallback onMuteToggle,
    required BuildContext context,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    
    // Zmiana koloru w zależności od tego czy jest wyciszone
    final activeColor = isMuted ? Colors.grey : colorScheme.primary;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow:[
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children:[
          // Górna sekcja z Ikoną, Tytułem i Przyciskiem Mute
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children:[
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isMuted 
                          ? Colors.grey.withOpacity(0.2) 
                          : colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      icon, 
                      color: isMuted 
                          ? Colors.grey.shade700 
                          : colorScheme.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: onMuteToggle,
                icon: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, anim) => RotationTransition(
                    turns: child.key == const ValueKey('icon1') 
                        ? Tween<double>(begin: 1, end: 1).animate(anim) 
                        : Tween<double>(begin: 0.75, end: 1).animate(anim),
                    child: ScaleTransition(scale: anim, child: child),
                  ),
                  child: Icon(
                    isMuted ? Icons.volume_off_rounded : Icons.volume_up_rounded,
                    key: ValueKey(isMuted),
                    color: isMuted ? colorScheme.error : colorScheme.primary,
                    size: 30,
                  ),
                ),
                tooltip: isMuted ? 'Wyłącz wyciszenie' : 'Wycisz',
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Dolna sekcja z suwakiem (Slider) i procentami
          Row(
            children:[
              Icon(
                Icons.volume_mute_rounded,
                color: Colors.grey.shade400,
                size: 20,
              ),
              Expanded(
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: activeColor,
                    inactiveTrackColor: activeColor.withOpacity(0.2),
                    thumbColor: activeColor,
                    overlayColor: activeColor.withOpacity(0.15),
                    trackHeight: 6.0,
                    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
                    overlayShape: const RoundSliderOverlayShape(overlayRadius: 24),
                  ),
                  child: Slider(
                    value: volume,
                    onChanged: onVolumeChanged,
                  ),
                ),
              ),
              SizedBox(
                width: 50,
                child: Text(
                  isMuted ? 'Mute' : '${(volume * 100).toInt()}%',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isMuted ? colorScheme.error : colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
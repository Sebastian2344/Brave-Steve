import 'package:brave_steve/game/state_menegment/music_state.dart';
import 'package:brave_steve/game/state_menegment/settings_state.dart';
import 'package:brave_steve/game/state_menegment/sound_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade500,
      appBar: AppBar(
        title: Text(
          'settings_screen.settings'.tr(),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.brown.shade900,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            Text(
              'settings_screen.sound_and_vibration'.tr(),
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
                  title: 'settings_screen.background_music'.tr(),
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
                  title: 'settings_screen.sound_effects'.tr(),
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

            const SizedBox(height: 20),
            Text(
              'settings_screen.language'.tr(),
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 24),

           _buildLanguageTile(context: context, title: 'PL', flagEmoji: '🇵🇱', locale: const Locale('pl'), currentLocale: context.locale),
           const SizedBox(height: 12),
           _buildLanguageTile(context: context, title: 'EN', flagEmoji: '🇬🇧', locale: const Locale('en'), currentLocale: context.locale)
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
    //final colorScheme = Theme.of(context).colorScheme;
    
    // Zmiana koloru w zależności od tego czy jest wyciszone
    final activeColor = isMuted ? Colors.grey.shade400 : Colors.white;

    return Container(
      decoration: BoxDecoration(
        color: Colors.brown.shade900,
        borderRadius: BorderRadius.circular(24),
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
                          ? Colors.grey.withAlpha(51) 
                          : Colors.brown.shade800, // Ciemniejszy odcień, gdy nie jest wyciszone
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      icon, 
                      color: isMuted 
                          ? Colors.grey.shade400
                          : Colors.white,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
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
                    color: isMuted ? Colors.red.shade300 : Colors.green.shade200,
                    size: 30,
                  ),
                ),
                tooltip: isMuted ? 'settings_screen.unmute'.tr() : 'settings_screen.mute'.tr(),
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
                    inactiveTrackColor: activeColor.withAlpha(51),
                    thumbColor: activeColor,
                    overlayColor: activeColor.withAlpha(38),
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
                width: 75,
                child: Text(
                  isMuted ? 'settings_screen.muted'.tr() : '${(volume * 100).toInt()}%',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isMuted ? Colors.grey.shade400 : Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageTile({
    required BuildContext context,
    required String title,
    required String flagEmoji,
    required Locale locale,
    required Locale currentLocale,
  }) {
    // Sprawdzamy, czy ten kafel to aktualnie wybrany język
    final isSelected = currentLocale == locale;

    return ListTile(
      // Zaokrąglenie w środku kafelka dla ładnego efektu fali przy kliknięciu (InkWell)
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      tileColor: Colors.brown.shade900,
      
      // Flaga po lewej stronie
      leading: Text(
        flagEmoji,
        style: const TextStyle(fontSize: 26),
      ),
      
      // Nazwa języka - pogrubiona, jeśli jest wybrana
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          color: isSelected ? Colors.white : Colors.grey.shade300,
        ),
      ),
      
      // Ptaszek (checkmark) po prawej stronie, jeśli język jest wybrany
      trailing: isSelected
          ? Icon(Icons.check_circle, color: Colors.green.shade200, size: 26)
          : null, // Puste miejsce, jeśli nie jest wybrany
          
      onTap: () {
        // Zmiana języka
        context.setLocale(locale);
      },
    );
  }
}
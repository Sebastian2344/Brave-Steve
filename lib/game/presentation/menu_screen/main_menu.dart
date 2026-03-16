import 'dart:io';

import 'package:brave_steve/game/presentation/introduction_screen/introduction.dart';
import 'package:brave_steve/game/state_menegment/music_state.dart';
import 'package:brave_steve/game/state_menegment/sound_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../state_menegment/game_state.dart';
import 'main_menu_buttons_widget.dart';
import '../saves_screen/show_saves.dart';

class MainMenu extends ConsumerWidget {
  const MainMenu({super.key});

  final Color color = const Color.fromARGB(255, 70, 50, 42);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final soundManager = ref.watch(soundManagerProvider);
    ref.watch(audioManagerProvider);
    ref.read(audioManagerProvider.notifier).playBGM(  
      'sounds/gigachad_music.mp3',
    );
    double fontSize = MediaQuery.of(context).textScaler.scale(18.0);
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: MediaQuery.of(context).size.height * 0.15,
            backgroundColor: Colors.grey,
            centerTitle: true,
            title: Text('Odważny rycerz (nazwa do zmiany)',
                style: TextStyle(
                    fontSize: MediaQuery.of(context).textScaler.scale(50.0),
                    color: const Color.fromARGB(255, 57, 44, 30),
                    fontWeight: FontWeight.bold))),
        body: SizedBox(
          height: MediaQuery.of(context).size.height * 0.85,
          width: MediaQuery.of(context).size.width,
          child: soundManager.when(
            data: (data) {
              return Stack(
                fit: StackFit.expand,
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'assets/images/Breave_Steave.png',
                    fit: BoxFit.fill,
                  ),
                  Column(
                    children: [
                      MainMenuButtons(
                          color: color,
                          function: () async {
                            ref.read(soundManagerProvider.notifier).playButtonClick();
                            await ref
                                .read(myStateProvider.notifier)
                                .openGameDB();
                            if (context.mounted) {
                              Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) {
                                return IntroductionScreen(
                                  isNewGame: true,
                                );
                              }));
                            }
                          },
                          text: "Rozpocznij Nową Grę",
                          fontSize: fontSize),
                      MainMenuButtons(
                          color: color,
                          function: () async {
                            ref.read(soundManagerProvider.notifier).playButtonClick();
                            await ref
                                .read(myStateProvider.notifier)
                                .openGameDB();
                            if (context.mounted) {
                              Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) {
                                return const ShowSaves();
                              }));
                            }
                          },
                          text: "Kontynuuj Grę",
                          fontSize: fontSize + 2),
                      MainMenuButtons(
                        color: color,
                        function: () {
                          ref.read(soundManagerProvider.notifier).playButtonClick();
                          ref.read(audioManagerProvider.notifier).stopBGM();
                          Navigator.pop(context);
                          exit(0);
                        },
                        text: "Wyjście",
                        fontSize: fontSize + 2,
                      )
                    ],
                  ),
                ],
              );
            },
            loading: () => Container(
              color: Colors.brown.shade700,
              width: MediaQuery.of(context).size.width,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: Colors.white,),
                  SizedBox(height: 20),
                  Text('Ładowanie zasobów...', style: TextStyle(color: Colors.white, fontSize: 20)),
                ],
              ),
            ),
            error: (error, stack) =>
                Center(child: Text('Błąd ładowania zasobów: $error')),
          ),
        ));
  }
}

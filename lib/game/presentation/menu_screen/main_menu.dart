import 'dart:io';

import 'package:brave_steve/game/presentation/introduction_screen/introduction.dart';
import 'package:brave_steve/game/presentation/settings_screen/settings.dart';
import 'package:brave_steve/game/state_menegment/music_state.dart';
import 'package:brave_steve/game/state_menegment/sound_state.dart';
import 'package:easy_localization/easy_localization.dart';
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
    double fontSize = MediaQuery.of(context).textScaler.scale(18.0);
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: MediaQuery.of(context).size.height * 0.15,
            backgroundColor: Colors.grey,
            centerTitle: true,
            title: Text('main_menu.game_title'.tr(context: context),
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
                          text: "main_menu.play".tr(context: context),
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
                          text: "main_menu.load".tr(context: context),
                          fontSize: fontSize + 2),
                      MainMenuButtons(
                        color: color,
                        function: () {
                          ref.read(soundManagerProvider.notifier).playButtonClick();
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) {
                              return const SettingsScreen();
                            }),
                          );
                        },
                        text: "main_menu.settings".tr(context: context),
                        fontSize: fontSize + 2,
                      ),
                      MainMenuButtons(
                        color: color,
                        function: () {
                          ref.read(soundManagerProvider.notifier).playButtonClick();
                          ref.read(audioManagerProvider.notifier).stopBGM();
                          Navigator.pop(context);
                          exit(0);
                        },
                        text: "main_menu.exit".tr(context: context),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: Colors.white,),
                  SizedBox(height: 20),
                  Text('main_menu.loading'.tr(context: context), style: TextStyle(color: Colors.white, fontSize: 20)),
                ],
              ),
            ),
            error: (error, stack) =>
                Center(child: Text('Błąd ładowania zasobów: $error')),
          ),
        ));
  }
}

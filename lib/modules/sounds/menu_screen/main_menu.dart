import 'dart:io';

import 'package:brave_steve/modules/game/presentation/introduction_screen/introduction.dart';
import 'package:brave_steve/modules/settings/settings_screen/settings.dart';
import 'package:brave_steve/modules/sounds/menagment/music_state.dart';
import 'package:brave_steve/modules/sounds/menagment/sound_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'main_menu_buttons_widget.dart';
import '../../save_game/saves_screen/show_saves.dart';

class MainMenu extends ConsumerStatefulWidget {
  const MainMenu({super.key});

  static const Color color = Color.fromARGB(255, 70, 50, 42);

  @override
  ConsumerState<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends ConsumerState<MainMenu> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
       ref
          .read(audioManagerProvider.notifier)
          .playBGM('sounds/gigachad_music.mp3');
    });
  }

  @override
  Widget build(BuildContext context) {
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
        child: Stack(
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
                    color: MainMenu.color,
                    function: () {
                      ref.read(soundManagerProvider.notifier).playButtonClick();
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return IntroductionScreen(
                          isNewGame: true,
                        );
                      }));
                    },
                    text: "main_menu.play".tr(context: context),
                    fontSize: fontSize),
                MainMenuButtons(
                    color: MainMenu.color,
                    function: () async {
                      ref.read(soundManagerProvider.notifier).playButtonClick();
                      if (!context.mounted) return;
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return const ShowSaves();
                      }));
                    },
                    text: "main_menu.load".tr(context: context),
                    fontSize: fontSize + 2),
                MainMenuButtons(
                  color: MainMenu.color,
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
                  color: MainMenu.color,
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
        ),
      ),
    );
  }
}

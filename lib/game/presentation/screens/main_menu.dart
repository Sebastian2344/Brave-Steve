import 'dart:io';

import 'package:brave_steve/game/presentation/screens/introduction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../state_menegment/riverpod/game_state.dart';
import '../widgets/main_menu_buttons.dart';
import 'show_saves.dart';

class MainMenu extends ConsumerWidget {
  const MainMenu({super.key});

  final Color color = const Color.fromARGB(255, 70, 50, 42);
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
     double fontSize = MediaQuery.of(context).textScaler.scale(18.0);
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: MediaQuery.of(context).size.height * 0.15,
          backgroundColor: Colors.grey,
          centerTitle: true,
          title: Text('Brave Steve',
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
                    color: color,
                    function: () async {
                      await ref.read(myStateProvider.notifier).openGameDB();
                      if (context.mounted) {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) {
                          return const IntroductionScreen(
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
                      await ref.read(myStateProvider.notifier).openGameDB();
                      if (context.mounted) {
                        Navigator.of(context).pushReplacement(
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
                    Navigator.pop(context);
                    exit(0);
                  },
                  text: "Wyjście",
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
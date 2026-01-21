import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../state_menegment/game_state.dart';
import 'game_over_dialog.dart';
import 'win_or_lose_dialog.dart';

class ActionInGame extends ConsumerStatefulWidget {
  const ActionInGame({
    super.key,
    required this.isNewGame,
    required this.keySave,
    required this.keyEq,
  });

  final bool isNewGame;
  final GlobalKey keySave;
  final GlobalKey keyEq;

  @override
  ConsumerState<ActionInGame> createState() => _ActionInGameState();
}

class _ActionInGameState extends ConsumerState<ActionInGame> {
  final GlobalKey _keyAtak = GlobalKey();
  final GlobalKey _keySuperAtak = GlobalKey();
  final GlobalKey _keyOslabienie = GlobalKey();
  final GlobalKey _keyOczyszczenie = GlobalKey();

  @override
  void initState() {
    super.initState();
    if (widget.isNewGame) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        // POPRAWKA: Używamy ShowCaseWidget.of(context).startShowCase
        // To jest standardowa metoda, która przyjmuje listę [].
        ShowCaseWidget.of(context).startShowCase([
          widget.keySave,       // 1. Dyskietka
          widget.keyEq,         // 2. Ludzik
          _keyAtak,             // 3. Atak
          _keySuperAtak,        // 4. SuperAtak
          _keyOslabienie,       // 5. Osłabienie
          _keyOczyszczenie,     // 6. Oczyszczenie
        ]);
      });
    }
  }

  void dialogWindow(Enum a, BuildContext context) {
    Stan.koniecGry == a
        ? showDialog(barrierDismissible: false, context: context, builder: (context) => const GameOver())
        : Stan.wygrana == a
        ? showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => const WinOrLose(win: true))
        : Stan.przegrana == a
        ? showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => const WinOrLose(win: false))
        : null;
  }

  @override
  Widget build(BuildContext context) {
    final buttonIgnore = ref.watch(myStateProvider.select(  
          (g) => g.buttonIgnore,
    ));
    final gameMetods = ref.read(myStateProvider.notifier);
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final double fontSize = mediaQueryData.textScaler.scale(16.0);
    final widthButton = mediaQueryData.size.width * 0.4;
    final heightButton = mediaQueryData.size.height * 0.07;

    return Expanded(
      child: ColoredBox(
        color: const Color.fromARGB(255, 109, 107, 106),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ButtonWidget(
                  globalKey: _keyAtak,
                  description: 'Zadaje obrażenia takie jakie są w statystykach',
                  fontSize: fontSize,
                  buttonIgnore: buttonIgnore[0],
                  battle: () async {
                    final Enum a = await gameMetods.battle(
                      superAtack: false, cleary: false, weakOnEnemy: false,
                    );
                    if (context.mounted) {
                      a == Stan.wygrana
                          ? gameMetods.winnerOrLoser(true)
                          : a == Stan.przegrana
                          ? gameMetods.winnerOrLoser(false)
                          : null;
                      dialogWindow(a, context);
                    }
                  },
                  manaCost: '(+1 many)',
                  textButton: 'Atak',
                  color: const Color.fromARGB(255, 18, 50, 228),
                  width: widthButton,
                  height: heightButton,
                ),
                ButtonWidget(
                  globalKey: _keySuperAtak,
                  description: 'Zadaje obrażenia 2 razy większe od tych co są w statystykach',
                  fontSize: fontSize,
                  buttonIgnore: buttonIgnore[1],
                  battle: () async {
                    final Enum a = await gameMetods.battle(
                      superAtack: true, cleary: false, weakOnEnemy: false,
                    );
                    if (context.mounted) {
                      a == Stan.wygrana
                          ? gameMetods.winnerOrLoser(true)
                          : a == Stan.przegrana
                          ? gameMetods.winnerOrLoser(false)
                          : null;
                      dialogWindow(a, context);
                    }
                  },
                  manaCost: '(4 many)',
                  textButton: 'SuperAtak',
                  color: const Color.fromARGB(255, 12, 205, 18),
                  width: widthButton,
                  height: heightButton,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ButtonWidget(
                  globalKey: _keyOslabienie,
                  description: 'Obniża atak przeciwnika o 30 procent',
                  fontSize: fontSize,
                  buttonIgnore: buttonIgnore[2],
                  battle: () async {
                    final Enum a = await gameMetods.battle(
                      superAtack: false, cleary: false, weakOnEnemy: true,
                    );
                    if (context.mounted) {
                      a == Stan.wygrana
                          ? gameMetods.winnerOrLoser(true)
                          : a == Stan.przegrana
                          ? gameMetods.winnerOrLoser(false)
                          : null;
                      dialogWindow(a, context);
                    }
                  },
                  manaCost: '(4 many)',
                  textButton: 'Osłabienie',
                  color: const Color.fromARGB(255, 105, 18, 228),
                  width: widthButton,
                  height: heightButton,
                ),
                ButtonWidget(
                  globalKey: _keyOczyszczenie,
                  description: 'Zdejmuje efekt osłabienia',
                  fontSize: fontSize - 1,
                  buttonIgnore: buttonIgnore[3],
                  battle: () async {
                    final Enum a = await gameMetods.battle(
                      superAtack: false, cleary: true, weakOnEnemy: false,
                    );
                    if (context.mounted) {
                      a == Stan.wygrana
                          ? gameMetods.winnerOrLoser(true)
                          : a == Stan.przegrana
                          ? gameMetods.winnerOrLoser(false)
                          : null;
                      dialogWindow(a, context);
                    }
                  },
                  manaCost: '(3 many)',
                  textButton: 'Oczyszczenie',
                  color: const Color.fromARGB(255, 12, 92, 205),
                  width: widthButton,
                  height: heightButton,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//=====================================ButtonWidget=============================================
class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.globalKey,
    required this.description,
    required this.fontSize,
    required this.buttonIgnore,
    required this.battle,
    required this.textButton,
    required this.color,
    required this.width,
    required this.height,
    required this.manaCost,
  });

  final GlobalKey globalKey;
  final String description;
  final double fontSize;
  final bool buttonIgnore;
  final VoidCallback battle;
  final String textButton;
  final Color color;
  final double width;
  final double height;
  final String manaCost;

  @override
  Widget build(BuildContext context) {
    return Showcase(
      key: globalKey,
      title: textButton,
      description: description,
      overlayColor: Colors.black.withValues(alpha: 0.7),
      targetBorderRadius: BorderRadius.circular(10),
      tooltipBackgroundColor: Colors.white,
      textColor: Colors.black,
      titleTextStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black
      ),
      descTextStyle: const TextStyle(
          fontSize: 14,
          color: Colors.black87
      ),

      child: IgnorePointer(
        ignoring: buttonIgnore,
        child: ElevatedButton(
          onPressed: battle,
          style: ElevatedButton.styleFrom(
              fixedSize: Size(width, height),
              textStyle: TextStyle(fontSize: fontSize),
              foregroundColor: Colors.white,
              backgroundColor: buttonIgnore ? Colors.grey : color),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(textButton),
              Text(manaCost),
            ],
          ),
        ),
      ),
    );
  }
}
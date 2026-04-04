import 'package:brave_steve/modules/eq/eq_screen/full_eq_dialog.dart';
import 'package:brave_steve/modules/game/state_menegment/action_button_state.dart';
import 'package:brave_steve/modules/eq/menagment/eq_state.dart';
import 'package:brave_steve/modules/counter_enemy_and_bioms/menagment/counter_enemy_state.dart';
import 'package:brave_steve/modules/money/menagment/money_state.dart';
import 'package:brave_steve/modules/sounds/menagment/sound_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../state_menegment/game_state.dart';
import 'game_over_dialog.dart';
import 'lose_dialog.dart';

class ActionInGame extends ConsumerStatefulWidget {
  const ActionInGame({
    super.key,
    required this.isNewGame,
    required this.keySave,
    required this.keyEq,
    required this.keyMerge
  });

  final bool isNewGame;
  final GlobalKey keySave;
  final GlobalKey keyEq;
  final GlobalKey keyMerge;

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
          widget.keySave, // 1. Dyskietka
          widget.keyEq, // 2. Ludzik
          widget.keyMerge, // 3. Łączenie
          _keyAtak, // 4. Atak
          _keySuperAtak, // 5. SuperAtak
          _keyOslabienie, // 6. Osłabienie
          _keyOczyszczenie, // 7. Oczyszczenie
        ]);
      });
    }
  }

  Future<void> dialogWindow(Enum a, BuildContext context, WidgetRef ref) async {
    final gameMetods = ref.read(myStateProvider.notifier);
    final eqMethods = ref.read(providerEQ.notifier);
    final moneyMethods = ref.read(moneyProvider.notifier);
    final mapMethods = ref.read(counterEnemyNotifierProvider.notifier);
    if (Stan.koniecGry == a) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => const GameOver());
    } else if (Stan.przegrana == a) {
      gameMetods.setStatsAfterLose();
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => const Lose());
    } else if (Stan.wygrana == a) {
      mapMethods.incrementEnemy();
      gameMetods.setStatsPlayerAndEnemyAfterWin();
      await moneyMethods.addmoney(50.0);
      eqMethods.randomItemDropToEQ(100);
      if (context.mounted && !eqMethods.isSpace()) {
        showDialog(
            context: context, builder: (context) => FullEqDialog(win: true));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
                Consumer(
                  builder: (context, ref, child) {
                    final atack = ref.watch(actionButtonIgnoreProvider.select((state) => state.atack));
                    return ButtonWidget(
                    globalKey: _keyAtak,
                    description: 'fight_screen.action_buttons.attack_description'.tr(context: context),
                    fontSize: fontSize,
                    buttonIgnore: atack,
                    battle: () async {
                      ref.read(soundManagerProvider.notifier).playButtonClick();
                      final Enum a = await gameMetods.battle(
                        superAtack: false,
                        cleary: false,
                        weakOnEnemy: false,
                      );
                      if (context.mounted) {
                        await dialogWindow(a, context, ref);
                      }
                    },
                    manaCost: 'fight_screen.action_buttons.attack_cost'.tr(args: ['+1'], context: context),
                    textButton: 'fight_screen.action_buttons.attack'.tr(context: context),
                    color: const Color.fromARGB(255, 18, 50, 228),
                    width: widthButton,
                    height: heightButton,
                  );
                  },
                ),
                Consumer(
                  builder: (context, ref, child) {
                    final superAtack = ref.watch(actionButtonIgnoreProvider.select((state) => state.superAtack));
                    return ButtonWidget(
                      globalKey: _keySuperAtak,
                      description:
                          'fight_screen.action_buttons.super_attack_description'.tr(context: context),
                      fontSize: fontSize,
                      buttonIgnore: superAtack,
                      battle: () async {
                        ref.read(soundManagerProvider.notifier).playButtonClick();
                        final Enum a = await gameMetods.battle(
                          superAtack: true,
                          cleary: false,
                          weakOnEnemy: false,
                        );
                        if (context.mounted) {
                          await dialogWindow(a, context, ref);
                        }
                      },
                      manaCost: 'fight_screen.action_buttons.super_attack_cost'.tr(args: ['4'], context: context),
                      textButton: 'fight_screen.action_buttons.super_attack'.tr(context: context),
                      color: const Color.fromARGB(255, 12, 205, 18),
                      width: widthButton,
                      height: heightButton,
                    );
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Consumer(
                  builder: (context, ref, child) {
                    final weakOnEnemy = ref.watch(actionButtonIgnoreProvider.select((state) => state.weakOnEnemy));
                    return ButtonWidget(
                      globalKey: _keyOslabienie,
                      description: 'fight_screen.action_buttons.weakness_description'.tr(context: context),
                      fontSize: fontSize,
                      buttonIgnore: weakOnEnemy,
                    battle: () async {
                      ref.read(soundManagerProvider.notifier).playButtonClick();
                      final Enum a = await gameMetods.battle(
                        superAtack: false,
                        cleary: false,
                        weakOnEnemy: true,
                      );
                      if (context.mounted) {
                        await dialogWindow(a, context, ref);
                      }
                    },
                    manaCost: 'fight_screen.action_buttons.weakness_cost'.tr(args: ['4'], context: context),
                    textButton: 'fight_screen.action_buttons.weakness'.tr(context: context),
                    color: const Color.fromARGB(255, 105, 18, 228),
                    width: widthButton,
                    height: heightButton,
                  );
                  },
                ),
                Consumer(
                  builder: (context, ref, child) {
                    final cleary = ref.watch(actionButtonIgnoreProvider.select((state) => state.cleary));
                    return ButtonWidget(
                      globalKey: _keyOczyszczenie,
                      description: 'fight_screen.action_buttons.clearance_description'.tr(context: context),
                      fontSize: fontSize - 1,
                      buttonIgnore: cleary,
                      battle: () async {
                        ref.read(soundManagerProvider.notifier).playButtonClick();
                        final Enum a = await gameMetods.battle(
                          superAtack: false,
                          cleary: true,
                          weakOnEnemy: false,
                        );
                        if (context.mounted) {
                          await dialogWindow(a, context, ref);
                        }
                      },
                      manaCost: 'fight_screen.action_buttons.clearance_cost'.tr(args: ['3'], context: context),
                      textButton: 'fight_screen.action_buttons.clearance'.tr(context: context),
                      color: const Color.fromARGB(255, 12, 92, 205),
                      width: widthButton,
                      height: heightButton,
                    );
                  },
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
          fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
      descTextStyle: const TextStyle(fontSize: 14, color: Colors.black87),
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

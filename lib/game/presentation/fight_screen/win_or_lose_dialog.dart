import 'package:brave_steve/game/presentation/eq_screen/full_eq_dialog.dart';
import 'package:brave_steve/game/state_menegment/game_state.dart';
import 'package:brave_steve/game/state_menegment/money_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../state_menegment/eq_state.dart';

class WinOrLose extends ConsumerWidget {
  const WinOrLose({super.key, required this.win});
  final bool win;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int numberSkillPoints = ref.watch(myStateProvider).skillPoints;
    final gameMetods = ref.read(myStateProvider.notifier);
    final eqMethods = ref.watch(providerEQ.notifier);
    final moneyMethods = ref.read(moneyProvider.notifier);

    return AlertDialog(
      titleTextStyle: const TextStyle(color: Colors.amber, fontSize: 24),
      contentTextStyle: const TextStyle(color: Colors.white, fontSize: 16),
      backgroundColor: const Color.fromARGB(255, 23, 12, 6),
      title: win ? const Text('Zwycięstwo') : const Text('Porażka'),
      content: win && gameMetods.isLevelUp()
          ? LvlupStats(
              numberSkillPoints: numberSkillPoints, gameMetods: gameMetods)
          : win
              ? const Text('Brawo pokonałeś przeciwnika! Pamiętaj że za każym razem jak kogoś pokonasz masz szansę na drop przedmiotu o ile posiadasz miejsce w ekwipunku.')
              : const Text('Przeciwnik Cię pokonał!'),
      actions: [
        CloseButton(
            numberSkillPoints: numberSkillPoints,
            gameMetods: gameMetods,
            eqMethods: eqMethods,
            win: win, moneyProvider: moneyMethods,)
      ],
    );
  }
}

class LvlupStats extends StatelessWidget {
  const LvlupStats(
      {super.key, required this.numberSkillPoints, required this.gameMetods});
  final int numberSkillPoints;
  final GameState gameMetods;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3,
      width: MediaQuery.of(context).size.width / 2,
      child: Column(children: [
        Text(
          '''Brawo pokonałeś przeciwnika! Kliknij w ikony aby rozdać punkty umiejętności: $numberSkillPoints''',
          textAlign: TextAlign.center,
        ),
        Center(
          child: Row(
            children: [
              IgnorePointer(
                  ignoring: numberSkillPoints <= 0,
                  child: IconButton(
                      onPressed: () {
                        gameMetods.chooseStats(0, 10);
                      },
                      icon: Icon(
                        Icons.add_circle,
                        color: numberSkillPoints > 0 ? Colors.red : Colors.grey,
                        size: 24,
                      ))),
              Text(
                'Życie',
                style: TextStyle(
                    color: numberSkillPoints > 0 ? Colors.red : Colors.grey,
                    fontSize: 22),
              ),
            ],
          ),
        ),
        Row(
          children: [
            IgnorePointer(
              ignoring: numberSkillPoints <= 0,
              child: IconButton(
                onPressed: () {
                  gameMetods.chooseStats(1, 0);
                },
                icon: Icon(
                  Icons.add_circle,
                  color: numberSkillPoints > 0 ? Colors.amber : Colors.grey,
                  size: 24,
                ),
              ),
            ),
            Text(
              'Atak',
              style: TextStyle(
                  color: numberSkillPoints > 0 ? Colors.amber : Colors.grey,
                  fontSize: 22),
            ),
          ],
        ),
      ]),
    );
  }
}

class CloseButton extends StatelessWidget {
  const CloseButton(
      {super.key,
      required this.numberSkillPoints,
      required this.gameMetods,
      required this.eqMethods,
      required this.win, required this.moneyProvider});
  final int numberSkillPoints;
  final GameState gameMetods;
  final EqStateMenagment eqMethods;
  final bool win;
  final CashRegisterNotifier moneyProvider;
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: numberSkillPoints > 0 && gameMetods.isLevelUp(),
      child: ElevatedButton(
          onPressed: () async {
            if (win){
              await moneyProvider.addmoney(50.0);
              gameMetods.isLevelUp() ? gameMetods.levelUp() : null; 
            }
            if (win && eqMethods.isSpace()) {
              eqMethods.randomItemDropToEQ(50);
            }
            if(context.mounted) Navigator.of(context).pop();
            if (!eqMethods.isSpace() && context.mounted){
              showDialog(
                  context: context,
                  builder: (context) => FullEqDialog(win: win));
            }   
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: numberSkillPoints > 0 && gameMetods.isLevelUp()
                  ? Colors.grey
                  : Colors.brown[700],
              foregroundColor: Colors.amber,
              side: const BorderSide(color: Color(0xFFC0C0C0))),
          child: win && gameMetods.isLevelUp()
              ? const Text('Hurra level up')
              : win
                  ? const Text('Graj dalej')
                  : const Text('Graj od nowa')),
    );
  }
}

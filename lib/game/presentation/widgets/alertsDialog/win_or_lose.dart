import 'package:brave_steve/game/state_menegment/riverpod/game_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WinOrLose extends ConsumerWidget {
  const WinOrLose({super.key, required this.win});
  final bool win;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int numberSkillPoints = ref.watch(myStateProvider).skillPoints;
    final gameMetods = ref.read(myStateProvider.notifier);
    return AlertDialog(
      titleTextStyle: const TextStyle(color: Colors.amber, fontSize: 24),
      contentTextStyle: const TextStyle(color: Colors.white, fontSize: 16),
      backgroundColor: const Color.fromARGB(255, 23, 12, 6),
      title: win ? const Text('Zwycięstwo') : const Text('Porażka'),
      content: win && gameMetods.isLevelUp()
          ? SizedBox(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width / 2,
              child: Column(children: [
                Text(
                    '''Brawo pokonałeś przeciwnika! Kliknij w ikony aby rozdać punkty umiejętności: $numberSkillPoints''',textAlign: TextAlign.center,),
                Center(
                  child: Row(
                    children: [
                      IgnorePointer(
                          ignoring: numberSkillPoints == 0,
                          child: IconButton(
                              onPressed: () {
                               gameMetods
                                    .chooseStats(0, 10, 0);
                              },
                              icon: const Icon(
                                Icons.favorite,
                                color: Colors.red,
                                size: 24,
                              ))),
                      const Text('Życie',
                          style: TextStyle(color: Colors.red, fontSize: 22))
                    ],
                  ),
                ),
                Row(
                  children: [
                    IgnorePointer(
                        ignoring: numberSkillPoints == 0,
                        child: IconButton(
                            onPressed: () {
                              gameMetods
                                  .chooseStats(1, 0, 0);
                            },
                            icon: const Icon(
                              Icons.add_circle,
                              color: Colors.grey,
                              size: 24,
                            ))),
                    const Text(
                      'Atak',
                      style: TextStyle(color: Colors.grey, fontSize: 22),
                    ),
                  ],
                ),
                Row(
                  children: [
                    IgnorePointer(
                        ignoring: numberSkillPoints == 0,
                        child: IconButton(
                            onPressed: () {
                              gameMetods
                                  .chooseStats(0, 0, 1);
                            },
                            icon: const Icon(
                              Icons.health_and_safety_sharp,
                              color: Colors.teal,
                              size: 24,
                            ))),
                    const Text("Redukcja obrażeń",
                        style: TextStyle(color: Colors.teal, fontSize: 22)),
                  ],
                ),
              ]),
            )
          : win
              ? const Text('Brawo pokonałeś przeciwnika!')
              : const Text('Przeciwnik Cię pokonał!'),
      actions: [
        IgnorePointer(
          ignoring: numberSkillPoints > 0 && gameMetods.isLevelUp(),
          child: ElevatedButton(
            onPressed: () {
              gameMetods.levelUp();
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
                backgroundColor:numberSkillPoints > 0 && gameMetods.isLevelUp()? Colors.grey : Colors.brown[700],
                foregroundColor: Colors.amber,
                side: const BorderSide(color: Color(0xFFC0C0C0))),
            child: win && gameMetods.isLevelUp()
                ? const Text('Hurra level up')
                : win
                    ? const Text('Graj dalej')
                    : const Text('Graj od nowa'),
          ),
        )
      ],
    );
  }
}

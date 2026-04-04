import 'package:brave_steve/modules/eq/menagment/eq_state.dart';
import 'package:brave_steve/modules/counter_enemy_and_bioms/menagment/counter_enemy_state.dart';
import 'package:brave_steve/modules/sounds/menagment/sound_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../state_menegment/game_state.dart';

class ExitToMenu extends ConsumerWidget {
  const ExitToMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {    
    return AlertDialog(
      titleTextStyle: const TextStyle(color: Colors.amber, fontSize: 24),
      contentTextStyle: const TextStyle(color: Colors.white, fontSize: 16),
      backgroundColor: const Color.fromARGB(255, 23, 12, 6),
      title: Text('fight_screen.exit_dialog.exit_to_menu'.tr(context: context)),
      content:
          Text('fight_screen.exit_dialog.exit_to_menu_confirmation'.tr(context: context)),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
                onPressed: () async {
                  ref.read(soundManagerProvider.notifier).playButtonClick();
                  ref.read(providerEQ.notifier).deleteItems();
                  ref.read(myStateProvider.notifier).gameOver();
                  ref.read(counterEnemyNotifierProvider.notifier).resetEnemyAndBoss();
                  if (context.mounted) {
                    Navigator.pop(context); 
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown[700],
                    foregroundColor: Colors.amber,
                    side: const BorderSide(color: Color(0xFFC0C0C0))),
                child: Text('fight_screen.exit_dialog.exit'.tr(context: context))),
            ElevatedButton(
                onPressed: () {
                  ref.read(soundManagerProvider.notifier).playButtonClick();
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown[700],
                    foregroundColor: Colors.amber,
                    side: const BorderSide(color: Color(0xFFC0C0C0))),
                child: Text('fight_screen.exit_dialog.stay'.tr(context: context))),
          ],
        ),
      ],
    );
  }
}

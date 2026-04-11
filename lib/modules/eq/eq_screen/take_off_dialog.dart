import 'package:brave_steve/modules/eq/eq_screen/stats_info_widget.dart';
import 'package:brave_steve/modules/eq/eq_screen/upgrade_button.dart';
import 'package:brave_steve/modules/eq/eq_screen/upgrade_info_widget.dart';
import 'package:brave_steve/modules/eq/menagment/eq_state.dart';
import 'package:brave_steve/modules/game/state_menegment/game_state.dart';
import 'package:brave_steve/modules/sounds/menagment/sound_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TakeOffDialog extends ConsumerWidget {
  const TakeOffDialog({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
          maxWidth: MediaQuery.of(context).size.width * 0.9,
        ),
        titleTextStyle: const TextStyle(color: Colors.amber, fontSize: 24),
        contentTextStyle: const TextStyle(color: Colors.white, fontSize: 16),
        backgroundColor: const Color.fromARGB(255, 23, 12, 6),
        title: const Text('Czy chcesz zdjąć przedmiot?'),
        content: Column(
          spacing: 8,
          children: [
            Consumer(builder: (context, ref, child) {
              final item = ref.watch(providerEQ)[id];
              return ShowItemInfo(itemPlace: item,);
            },),
            ShowUpgradeInfo(id: id),
            UpgradeButton(id: id)
          ],
        ),
        actions: [
          FilledButton(
              onPressed: () {
                ref.read(soundManagerProvider.notifier).playButtonClick();
                ref.read(providerEQ.notifier).rozebracsie(id);
                ref.read(myStateProvider.notifier).setStats();
                Navigator.of(context).pop();
              },
              child: const Text('Zdejmuję')),
          FilledButton(
              onPressed: () {
                ref.read(soundManagerProvider.notifier).playButtonClick();
                Navigator.of(context).pop();
              },
              child: const Text('Nie zdejmuję'))
        ],
      );
  }
}
import 'package:brave_steve/game/presentation/eq_screen/stats_info_widget.dart';
import 'package:brave_steve/game/presentation/eq_screen/upgrade_button.dart';
import 'package:brave_steve/game/presentation/eq_screen/upgrade_info_widget.dart';
import 'package:brave_steve/game/state_menegment/eq_state.dart';
import 'package:brave_steve/game/state_menegment/game_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PutOnDialog extends ConsumerWidget {
  const PutOnDialog({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height / 1.5,
          maxWidth: MediaQuery.of(context).size.width / 1.5,
        ),
        titleTextStyle: const TextStyle(color: Colors.amber, fontSize: 24),
        contentTextStyle: const TextStyle(color: Colors.white, fontSize: 16),
        backgroundColor: const Color.fromARGB(255, 23, 12, 6),
        title: const Text('Czy chcesz załozyć przedmiot?'),
        content: Column(
          spacing: 8,
          children: [
            ShowItemInfo(id: id),
            ShowUpgradeInfo(id: id),
            UpgradeButton(id: id)
          ],
        ),
        actions: [
          FilledButton(
              onPressed: () {
                ref.read(providerEQ.notifier).ubracsie(id);
                ref.read(myStateProvider.notifier).setStats(ref);
                Navigator.of(context).pop();
              },
              child: const Text('Zakładam')),
          FilledButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Nie zakładam')),
        ],
      );
  }
}
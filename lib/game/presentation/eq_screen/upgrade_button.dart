import 'package:brave_steve/game/state_menegment/eq_state.dart';
import 'package:brave_steve/game/state_menegment/game_state.dart';
import 'package:brave_steve/game/state_menegment/money_state.dart';
import 'package:brave_steve/game/state_menegment/sound_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpgradeButton extends ConsumerWidget {
  const UpgradeButton({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item = ref.watch(providerEQ)[id];
    bool isNotVisible = ref.read(providerEQ.notifier).isMaxLevel(id);
    double money = ref.watch(moneyProvider).value!.money;
    return !item.isEmpty && !isNotVisible
        ? IgnorePointer(
          ignoring: item.item.upgradePrice > money,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: item.item.upgradePrice > money ? Colors.grey : Colors.amber,),
              onPressed: () async {
                ref.read(soundManagerProvider.notifier).playUpgradeItem();
                await ref
                    .read(providerEQ.notifier)
                    .upgradeItem(id, money);
                ref.read(myStateProvider.notifier).setStats();
              },
              child: const Text('Ulepszam')),
        )
        : SizedBox();
  }
}
import 'package:brave_steve/game/state_menegment/eq_state.dart';
import 'package:brave_steve/game/state_menegment/game_state.dart';
import 'package:brave_steve/game/state_menegment/money_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpgradeButton extends ConsumerWidget {
  const UpgradeButton({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item = ref.watch(providerEQ).eqList[id];
    bool isNotVisible = ref.read(providerEQ.notifier).isMaxLevel(id);
    double money = ref.watch(moneyProvider).money;
    return !item.isEmpty && !isNotVisible
        ? IgnorePointer(
          ignoring: item.item.upgradePrice > money,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: item.item.upgradePrice > money ? Colors.grey : Colors.amber,),
              onPressed: () async {
                final bill = ref
                    .read(providerEQ.notifier)
                    .upgradeItem(id, money);
                ref.read(myStateProvider.notifier).setStats(ref);
                if (bill.$1) {
                  await ref
                      .read(moneyProvider.notifier)
                      .subtractmoney(bill.$2 ?? 0);
                } else if (bill.$2 == null && bill.$1 == false) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Nie masz wystarczającej ilości waluty.')));
                } else if (bill.$2 == null && bill.$1 == true) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content:
                          Text('Ulepszyłeś przedmiot na maksymalny poziom.')));
                }
              },
              child: const Text('Ulepszam')),
        )
        : SizedBox();
  }
}
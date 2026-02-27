import 'package:brave_steve/game/state_menegment/eq_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShowUpgradeInfo extends ConsumerWidget {
  const ShowUpgradeInfo({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item = ref.watch(providerEQ).eqList[id];
    final itemR = ref.read(providerEQ).eqList[id].item;
    final o = ref.read(providerEQ.notifier);
    final isMaxLevel = ref.read(providerEQ.notifier).isMaxLevel(id);
    return !item.isEmpty
        ? SingleChildScrollView(
            child: !isMaxLevel
                ? Column(
                    children: [
                      Text(
                          'Koszt ulepszenia: ${item.item.upgradePrice} waluty.'),
                      Row(
                        spacing: 5,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (item.item.attack != null)
                            Text(
                                'Atak: ${item.item.attack != null ? item.item.attack! : itemR.attack}'),
                          if (item.item.attack != null)
                            Text('+ ${o.attackStatsBoost()}',
                                style: const TextStyle(color: Colors.green)),
                        ],
                      ),
                      Row(
                        spacing: 5,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (item.item.armour != null)
                            Text(
                                'Pancerz: ${item.item.armour != null ? item.item.armour! : itemR.armour}'),
                          if (item.item.armour != null)
                            Text('+ ${o.armourStatsBoost()}',
                                style: const TextStyle(color: Colors.green)),
                        ],
                      ),
                    ],
                  )
                : const Center(child: Text('Maksymalny poziom ulepszenia')),
          )
        : SizedBox();
  }
}
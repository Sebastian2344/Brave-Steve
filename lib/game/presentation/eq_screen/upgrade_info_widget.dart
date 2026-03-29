import 'package:brave_steve/game/state_menegment/eq_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShowUpgradeInfo extends ConsumerWidget {
  const ShowUpgradeInfo({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item = ref.watch(providerEQ)[id];
    final itemR = ref.read(providerEQ)[id].item;
    final o = ref.read(providerEQ.notifier);
    final isMaxLevel = ref.read(providerEQ.notifier).isMaxLevel(id);
    return !item.isEmpty
        ? SingleChildScrollView(
            child: !isMaxLevel
                ? Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.monetization_on, color: Colors.orange[700]),
                          Text(' ${item.item.upgradePrice}'),
                        ],
                      ),
                      if (item.item.attack != null)
                      Row(
                        spacing: 5,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                            Icon(Icons.sports_mma_rounded, color: Colors.red[700]),
                            Text(
                                '${item.item.attack != null ? item.item.attack! : itemR.attack}'),
                            Text('+ ${o.attackStatsBoost()}',
                                style: const TextStyle(color: Colors.green)),
                        ],
                      ),
                      if (item.item.armour != null)
                      Row(
                        spacing: 5,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                            Icon(Icons.shield, color: Colors.blueGrey[700]),
                            Text(
                                '${item.item.armour != null ? item.item.armour! : itemR.armour}'),
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
import 'package:brave_steve/game/state_menegment/eq_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShowItemInfo extends ConsumerWidget {
  const ShowItemInfo({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item = ref.watch(providerEQ).eqList[id];

    return !item.isEmpty
        ? Column(
            children: [
              Text(item.item.name),
              Text('Poziom: ${item.item.itemLevel}'),
              Image.asset(item.item.image, cacheWidth: 150, cacheHeight: 150),
              Text(item.item.description),
              Text('Cena: ${item.item.price}'),
              Column(
                children: [
                  if (item.item.attack != null)
                    Text('Atak: ${item.item.attack}'),
                  if (item.item.armour != null)
                    Text('Pancerz: ${item.item.armour}'),
                ],
              )
            ],
          )
        : SizedBox();
  }
}
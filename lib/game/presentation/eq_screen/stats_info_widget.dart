import 'package:brave_steve/game/state_menegment/eq_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShowItemInfo extends ConsumerWidget {
  const ShowItemInfo({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemPlace = ref.watch(providerEQ).eqList[id];

    return !itemPlace.isEmpty
        ? Column(
            children: [
              Text(itemPlace.item.name),
              Text('Poziom: ${itemPlace.item.itemLevel}'),
              Image.asset(itemPlace.item.image, cacheWidth: 150, cacheHeight: 150),
              Text(itemPlace.item.description),
              Text('Cena: ${itemPlace.item.price}'),
              Column(
                children: [
                  if (itemPlace.item.attack != null)
                    Text('Atak: ${itemPlace.item.attack}'),
                  if (itemPlace.item.armour != null)
                    Text('Pancerz: ${itemPlace.item.armour}'),
                ],
              )
            ],
          )
        : SizedBox();
  }
}
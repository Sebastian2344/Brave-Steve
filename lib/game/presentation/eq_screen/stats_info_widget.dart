import 'package:brave_steve/game/state_menegment/eq_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShowItemInfo extends ConsumerWidget {
  const ShowItemInfo({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemPlace = ref.watch(providerEQ)[id];

    return !itemPlace.isEmpty
        ? Column(
            children: [           
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(itemPlace.item.name),
                  SizedBox(width: 10),
                  Icon(Icons.star, color: Colors.yellow[700]),
                  Text('${itemPlace.item.itemLevel}'),                 
                ],
              ),
              Image.asset(itemPlace.item.image, cacheWidth: 150, cacheHeight: 150),
              Text(itemPlace.item.description),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.monetization_on, color: Colors.orange[700]),
                  Text('${itemPlace.item.price}'),
                ],
              ),
              Column(
                children: [
                  if (itemPlace.item.attack != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.sports_mma_rounded, color: Colors.red[700]),
                        Text('${itemPlace.item.attack}'),
                      ],
                    ),
                  if (itemPlace.item.armour != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.shield, color: Colors.blueGrey[700]),
                        Text('${itemPlace.item.armour}'),
                      ],
                    ),
                ],
              )
            ],
          )
        : SizedBox();
  }
}
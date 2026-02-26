import 'package:brave_steve/game/state_menegment/money_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../state_menegment/eq_state.dart';
import '../../state_menegment/game_state.dart';

class AlertDialogW extends ConsumerWidget {
  const AlertDialogW({required this.id, super.key});
  final int id;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.read(providerEQ.notifier).czyPustePole(id) && id > 4
        ? AlertDialog(
            titleTextStyle: const TextStyle(color: Colors.amber, fontSize: 24),
            contentTextStyle:
                const TextStyle(color: Colors.white, fontSize: 16),
            backgroundColor: const Color.fromARGB(255, 23, 12, 6),
            title: const Text('Czy chcesz załozyć przedmiot?'),
            content: SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width / 2,
              child: Column(
                spacing: 3,
                children: [
                  ShowItemInfo(id: id),
                  ShowUpgradeInfo(id: id),
                  UpgradeButton(id: id)
                ],
              ),
            ),
            actions: [
              FilledButton(
                  onPressed: () {
                    ref
                        .read(myStateProvider.notifier)
                        .setStats(ref.read(providerEQ.notifier).ubracsie(id));
                    Navigator.of(context).pop();
                  },
                  child: const Text('Tak')),
              FilledButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Nie'))
            ],
          )
        : id <= 4
            ? AlertDialog(
                titleTextStyle:
                    const TextStyle(color: Colors.amber, fontSize: 24),
                contentTextStyle:
                    const TextStyle(color: Colors.white, fontSize: 16),
                backgroundColor: const Color.fromARGB(255, 23, 12, 6),
                title: const Text('Czy chcesz zdjąć przedmiot?'),
                content: SizedBox(
                    height: MediaQuery.of(context).size.height / 2,
                    child: ShowItemInfo(id: id)),
                actions: [
                  FilledButton(
                      onPressed: () {
                        ref.read(myStateProvider.notifier).setStats(
                            ref.read(providerEQ.notifier).rozebracsie(id));
                        Navigator.of(context).pop();
                      },
                      child: const Text('Tak')),
                  FilledButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Nie'))
                ],
              )
            : AlertDialog(
                title: const Text('Ostrzeżenie'),
                titleTextStyle:
                    const TextStyle(color: Colors.amber, fontSize: 24),
                contentTextStyle:
                    const TextStyle(color: Colors.white, fontSize: 16),
                backgroundColor: const Color.fromARGB(255, 23, 12, 6),
                content: SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                  child: Column(
                    spacing: 8,
                    children: [
                      const Text(
                          'Aby załorzyć poniższy przedmiot należy zdjąć założony.'),
                      ShowItemInfo(id: id),
                    ],
                  ),
                ),
                actions: [
                    FilledButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('ok')),
                  ]);
  }
}

class SellItemDialog extends ConsumerWidget {
  const SellItemDialog({super.key, required this.id});
  final int id;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      titleTextStyle: const TextStyle(color: Colors.amber, fontSize: 24),
      contentTextStyle: const TextStyle(color: Colors.white, fontSize: 16),
      backgroundColor: const Color.fromARGB(255, 23, 12, 6),
      title: const Text("Czy chcesz sprzedać przedmiot?"),
      content: SizedBox(
          height: MediaQuery.of(context).size.height / 2,
          child: ShowItemInfo(id: id)),
      actions: [
        ElevatedButton(
            onPressed: () {
              ref
                  .read(moneyProvider.notifier)
                  .addmoney(ref.read(providerEQ.notifier).getPrice(id));
              ref
                  .read(myStateProvider.notifier)
                  .setStats(ref.read(providerEQ.notifier).deleteItem(id));
              Navigator.of(context).pop();
            },
            child: const Text('Tak')),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Nie'))
      ],
    );
  }
}

class ShowItemInfo extends ConsumerWidget {
  const ShowItemInfo({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item = ref.watch(providerEQ)[id];

    return !item.isEmpty
        ? Column(
            spacing: 5,
            children: [
              Text(item.item.name),
              Text('Poziom: ${item.item.itemLevel}'),
              Image.asset(item.item.image, cacheWidth: 200, cacheHeight: 200),
              Text(item.item.description),
              Text('Cena: ${item.item.price}'),
              Column(
                spacing: 5,
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

class ShowUpgradeInfo extends ConsumerWidget {
  const ShowUpgradeInfo({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context, ref) {
    final item = ref.watch(providerEQ)[id];
    final itemR = ref.read(providerEQ)[id].item;
    final o = ref.read(providerEQ.notifier);
    final isMaxLevel = ref
        .read(providerEQ.notifier)
        .isMaxLevel(item.item.itemLevel, item.item.itemRarity);
    return !item.isEmpty
        ? SingleChildScrollView(
            child: !isMaxLevel
                ? Column(
                    spacing: 5,
                    children: [
                      const Text('Czy chcesz ulepszyć przedmiot?'),
                      Text(
                          'Koszt ulepszenia: ${item.item.upgradePrice} waluty.'),
                      const Text('Wartości statystyk po ulepszeniu:'),
                      if (item.item.attack != null)
                        Text(
                            'Atak: ${item.item.armour != null ? item.item.attack! + o.attackStatsBoost() : itemR.attack}'),
                      if (item.item.armour != null)
                        Text(
                            'Pancerz: ${item.item.armour != null ? item.item.armour! + o.armourStatsBoost() : itemR.armour}'),
                    ],
                  )
                : const Text('Osiągnięto poziom maksymalny przedmiotu.'),
          )
        : SizedBox();
  }
}

class UpgradeButton extends ConsumerWidget {
  const UpgradeButton({super.key,required this.id});

  final int id;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final item = ref.watch(providerEQ)[id];
    bool isNotVisible = ref.read(providerEQ.notifier).isMaxLevel(item.item.itemLevel, item.item.itemRarity);
    return !item.isEmpty && !isNotVisible? FilledButton(
        onPressed: () async {     
          final money = ref
              .read(providerEQ.notifier)
              .upgradeItem(id, ref.read(moneyProvider).money);
          if (money.$1) {
            await ref.read(moneyProvider.notifier).subtractmoney(money.$2 ?? 0);
          } else if (money.$2 == null && money.$1 == false) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Nie masz wystarczającej ilości waluty.')));
          } else if (money.$2 == null && money.$1 == true) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Ulepszyłeś przedmiot na maksymalny poziom.')));
          }
        },
        child: const Text('Ulepszam item')): SizedBox();
  }
}

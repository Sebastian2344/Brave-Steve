import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../state_menegment/eq_state.dart';
import '../../../state_menegment/game_state.dart';

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
            content: SizedBox(height: MediaQuery.of(context).size.height / 2,child: ref.read(providerEQ.notifier).showItemInfo(id)),
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
                content: SizedBox(height: MediaQuery.of(context).size.height / 2,child: ref.read(providerEQ.notifier).showItemInfo(id)),
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
                titleTextStyle:
                    const TextStyle(color: Colors.amber, fontSize: 24),
                contentTextStyle:
                    const TextStyle(color: Colors.white, fontSize: 16),
                backgroundColor: const Color.fromARGB(255, 23, 12, 6),
                content: const Text(
                    'Nie można założyć przedmiotu. Pole jest zajęte.'),
                actions: [
                    FilledButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('ok')),
                  ]);
  }
}

class DeleteItemDialog extends ConsumerWidget {
  const DeleteItemDialog({super.key, required this.id});
  final int id;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      titleTextStyle: const TextStyle(color: Colors.amber, fontSize: 24),
      contentTextStyle: const TextStyle(color: Colors.white, fontSize: 16),
      backgroundColor: const Color.fromARGB(255, 23, 12, 6),
      title: const Text("Chcesz usunąć przedmiot?"),
      actions: [
        ElevatedButton(
            onPressed: () {
              ref.read(providerEQ.notifier).deleteItem(id);
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

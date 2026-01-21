import 'package:brave_steve/game/state_menegment/eq_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../state_menegment/game_state.dart';
import '../menu_screen/main_menu.dart';

class ExitToMenu extends ConsumerWidget {
  const ExitToMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {    
    return AlertDialog(
      titleTextStyle: const TextStyle(color: Colors.amber, fontSize: 24),
      contentTextStyle: const TextStyle(color: Colors.white, fontSize: 16),
      backgroundColor: const Color.fromARGB(255, 23, 12, 6),
      title: const Text('Wyjście do menu'),
      content:
          const Text('Czy chcesz wyjść do menu? Gra nie zostanie zapisana.'),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
                onPressed: () async {
                  await ref.read(myStateProvider.notifier).closeGameDB();
                  ref.read(providerEQ.notifier).deleteItems();
                  if (context.mounted) {
                    Navigator.pop(context);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const MainMenu()));
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown[700],
                    foregroundColor: Colors.amber,
                    side: const BorderSide(color: Color(0xFFC0C0C0))),
                child: const Text('Wychodze')),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown[700],
                    foregroundColor: Colors.amber,
                    side: const BorderSide(color: Color(0xFFC0C0C0))),
                child: const Text('Anuluj'))
          ],
        ),
      ],
    );
  }
}

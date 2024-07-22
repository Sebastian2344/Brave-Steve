import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../state_menegment/game_state.dart';
import '../../screens/show_saves.dart';

class SaveGame extends ConsumerWidget {
  SaveGame({super.key});
  final TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(myStateProvider.notifier);
    return AlertDialog(
      titleTextStyle: const TextStyle(color: Colors.amber, fontSize: 24),
      contentTextStyle: const TextStyle(color: Colors.white, fontSize: 16),
      backgroundColor: const Color.fromARGB(255, 23, 12, 6),
      title: const Text('Podaj nazwę zapisu gry'),
      content: TextField(
        controller: textEditingController,
        style: const TextStyle(
          color: Colors.white,
        ),
        decoration: const InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: Colors.amber), // Kolor podkreślenia po wybraniu pola
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () async {
            textEditingController.text.isNotEmpty
                ? {
                    await game.saveGame(textEditingController.text, ref),
                    if (context.mounted)
                      {
                        Navigator.pop(context),
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const ShowSaves(),
                          ),
                        )
                      }
                  }
                : {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Zapis musi mieć nazwę'),
                      ),
                    ),
                    Future.delayed(const Duration(seconds: 2))
                  };
            textEditingController.clear();
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.brown[700],
              foregroundColor: Colors.white,
              side: const BorderSide(color: Colors.amber)),
          child: const Text('Zapisz'),
        )
      ],
    );
  }
}

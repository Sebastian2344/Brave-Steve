import 'package:brave_steve/modules/eq/eq_screen/eq.dart';
import 'package:brave_steve/modules/sounds/menagment/sound_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FullEqDialog extends ConsumerWidget {
  const FullEqDialog({super.key, required this.win});
  final bool win;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.8,
        maxWidth: MediaQuery.of(context).size.width * 0.95,
      ),
      titleTextStyle: const TextStyle(color: Colors.amber, fontSize: 24),
      contentTextStyle: const TextStyle(color: Colors.white, fontSize: 16),
      backgroundColor: const Color.fromARGB(255, 23, 12, 6),
      title: const Text('Ostrzeżenie'),
      content: const Text(
          '''Twój ekwipunek jest zapełniony!! Musisz zrobić miejsce w ekwipunku aby móc otrzymać przedmiot z dropu. Pamiętaj że możesz sprzedać przedmioty które masz w ekwipunku.'''),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown[700],
                    foregroundColor: Colors.amber,
                    side: const BorderSide(color: Color(0xFFC0C0C0))),
                onPressed: () {
                  ref.read(soundManagerProvider.notifier).playButtonClick();
                  Navigator.of(context).pop();
                  win
                      ? Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Equpment()))
                      : null;
                },
                child: const Text('Robie miejce')),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown[700],
                    foregroundColor: Colors.amber,
                    side: const BorderSide(color: Color(0xFFC0C0C0))),
                onPressed: () {
                  ref.read(soundManagerProvider.notifier).playButtonClick();
                  Navigator.of(context).pop();
                },
                child: const Text('Nie teraz')),
          ],
        ),
      ],
    );
  }
}

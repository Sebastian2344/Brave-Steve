import 'package:brave_steve/game/presentation/eq_screen/eq.dart';
import 'package:flutter/material.dart';

class FullEqDialog extends StatelessWidget {
  const FullEqDialog({super.key, required this.win});
  final bool win;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titleTextStyle: const TextStyle(color: Colors.amber, fontSize: 24),
      contentTextStyle: const TextStyle(color: Colors.white, fontSize: 16),
      backgroundColor: const Color.fromARGB(255, 23, 12, 6),
      title: const Text('Ostrzeżenie'),
      content: const Text(
          '''Twój ekwipunek jest zapełniony!! Musisz zrobić miejsce w ekwipunku aby móc otrzymać przedmiot z dropu. Pamiętaj że możesz sprzedać przedmioty które masz w ekwipunku.'''),
      actions: [
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              win
                  ? Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const Equpment()))
                  : null;
            },
            child: const Text('Robie miejsce w ekwipunku')),
             ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Nie teraz')),
      ],
    );
  }
}

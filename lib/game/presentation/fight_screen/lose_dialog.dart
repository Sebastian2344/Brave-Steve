import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Lose extends ConsumerWidget {
  const Lose({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      titleTextStyle: const TextStyle(color: Colors.amber, fontSize: 24),
      contentTextStyle: const TextStyle(color: Colors.white, fontSize: 16),
      backgroundColor: const Color.fromARGB(255, 23, 12, 6),
      title: const Text('Porażka'),
      content: const Text('Przeciwnik Cię pokonał!'),
      actions: [
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown[700],
                foregroundColor: Colors.amber,
                side: const BorderSide(color: Color(0xFFC0C0C0))),
            child: const Text('Graj od nowa')),
        ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Reklama niedostępna.'),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown[700],
                foregroundColor: Colors.amber,
                side: const BorderSide(color: Color(0xFFC0C0C0))),
            child: const Text('Reklama'))
      ],
    );
  }
}

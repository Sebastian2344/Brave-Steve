import 'package:brave_steve/modules/eq/eq_screen/stats_info_widget.dart';
import 'package:brave_steve/modules/eq/menagment/eq_state.dart';
import 'package:brave_steve/modules/game/state_menegment/game_state.dart';
import 'package:brave_steve/modules/sounds/menagment/sound_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SellItemDialog extends ConsumerWidget {
  const SellItemDialog({super.key, required this.id});
  final int id;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
          maxWidth: MediaQuery.of(context).size.width * 0.9,
        ),
      titleTextStyle: const TextStyle(color: Colors.amber, fontSize: 24),
      contentTextStyle: const TextStyle(color: Colors.white, fontSize: 16),
      backgroundColor: const Color.fromARGB(255, 23, 12, 6),
      title: const Text("Czy chcesz sprzedać przedmiot?"),
      content: Consumer(builder: (context, ref, child) {
              final item = ref.read(providerEQ)[id];
              return ShowItemInfo(itemPlace: item,);
            },),
      actions: [
        ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pop();  
              await ref.read(providerEQ.notifier).sellItem(id);
              ref.read(myStateProvider.notifier).setStats();
            },
            child: const Text('Tak')),
        ElevatedButton(
            onPressed: () {
              ref.read(soundManagerProvider.notifier).playButtonClick();
              Navigator.of(context).pop();
            },
            child: const Text('Nie'))
      ],
    );
  }
}
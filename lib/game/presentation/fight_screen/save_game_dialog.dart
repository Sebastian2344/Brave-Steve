import 'package:brave_steve/game/state_menegment/save_state.dart';
import 'package:brave_steve/game/state_menegment/sound_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../saves_screen/show_saves.dart';

class SaveGame extends ConsumerWidget {
  SaveGame({super.key});
  final TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      titleTextStyle: const TextStyle(color: Colors.amber, fontSize: 24),
      contentTextStyle: const TextStyle(color: Colors.white, fontSize: 16),
      backgroundColor: const Color.fromARGB(255, 23, 12, 6),
      title: Text('fight_screen.save_dialog.save_game_name'.tr(context: context)),
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
            ref.read(soundManagerProvider.notifier).playButtonClick();
            textEditingController.text.isNotEmpty
                ? {
                    await ref.read(saveStateProvider.notifier).saveGame(textEditingController.text),
                    if (context.mounted)
                      {
                        Navigator.pop(context),
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ShowSaves(),
                          ),
                        )
                      }
                  }
                : {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('fight_screen.save_dialog.save_requires_name'.tr(context: context)),
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
          child: Text('fight_screen.save_dialog.save'.tr(context: context)),
        )
      ],
    );
  }
}

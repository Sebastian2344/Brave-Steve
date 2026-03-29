import 'package:brave_steve/game/state_menegment/sound_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Lose extends ConsumerWidget {
  const Lose({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      titleTextStyle: const TextStyle(color: Colors.amber, fontSize: 24),
      contentTextStyle: const TextStyle(color: Colors.white, fontSize: 16),
      backgroundColor: const Color.fromARGB(255, 23, 12, 6),
      title: Text('fight_screen.lose_dialog.lose'.tr(context: context)),
      content: Text('fight_screen.lose_dialog.description'.tr(context: context)),
      actions: [
        ElevatedButton(
            onPressed: () {
              ref.read(soundManagerProvider.notifier).playButtonClick();
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown[700],
                foregroundColor: Colors.amber,
                side: const BorderSide(color: Color(0xFFC0C0C0))),
            child: Text('fight_screen.lose_dialog.try_again'.tr())),
        ElevatedButton(
            onPressed: () {
              ref.read(soundManagerProvider.notifier).playButtonClick();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('fight_screen.lose_dialog.ad_not_available'.tr()),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown[700],
                foregroundColor: Colors.amber,
                side: const BorderSide(color: Color(0xFFC0C0C0))),
            child: Text('fight_screen.lose_dialog.watch_ad'.tr(context: context))),
      ],
    );
  }
}

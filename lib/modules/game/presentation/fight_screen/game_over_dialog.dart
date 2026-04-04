import 'package:brave_steve/modules/eq/menagment/eq_state.dart';
import 'package:brave_steve/modules/counter_enemy_and_bioms/menagment/counter_enemy_state.dart';
import 'package:brave_steve/modules/sounds/menagment/sound_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../state_menegment/game_state.dart';

class GameOver extends ConsumerWidget {
  const GameOver({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return AlertDialog(
      titleTextStyle: const TextStyle(color:Colors.amber,fontSize: 24),
      contentTextStyle: const TextStyle(color:Colors.white,fontSize: 16),
      backgroundColor:const Color.fromARGB(255, 23, 12, 6),
          title: Text('fight_screen.game_over'.tr(context: context)),
          content: SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.height / 3.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('fight_screen.game_over_description'.tr(context: context)),
                GridView(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: 8,mainAxisSpacing: 8),children: [
                  SizedBox(height:MediaQuery.of(context).size.height / 10,width:MediaQuery.of(context).size.width / 5,child: Image.asset('assets/images/złoto.png')),
                  SizedBox(height:MediaQuery.of(context).size.height / 10,width:MediaQuery.of(context).size.width / 5,child: Image.asset('assets/images/złoto.png')),
                  SizedBox(height:MediaQuery.of(context).size.height / 10,width:MediaQuery.of(context).size.width / 5,child: Image.asset('assets/images/złoto.png')),
                  SizedBox(height:MediaQuery.of(context).size.height / 10,width:MediaQuery.of(context).size.width / 5,child: Image.asset('assets/images/złoto.png'))
                ],)
              ],
            ),
          ),
          actions: [
            ElevatedButton(
                onPressed: (){
                  ref.read(soundManagerProvider.notifier).playButtonClick();
                  ref.read(myStateProvider.notifier).gameOver();
                  ref.read(providerEQ.notifier).deleteItems();
                  ref.read(counterEnemyNotifierProvider.notifier).resetEnemyAndBoss();
                Navigator.of(context).pop();
                Navigator.of(context).popUntil((route) => route.isFirst);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.brown[700],foregroundColor: Colors.amber,side: const BorderSide(color: Color(0xFFC0C0C0))),
                child: Text('fight_screen.to_menu'.tr(context: context)))
          ],
        );
  }
}
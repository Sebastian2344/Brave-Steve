import 'package:brave_steve/game/state_menegment/eq_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../state_menegment/game_state.dart';
import '../menu_screen/main_menu.dart';

class GameOver extends ConsumerWidget {
  const GameOver({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return AlertDialog(
      titleTextStyle: const TextStyle(color:Colors.amber,fontSize: 24),
      contentTextStyle: const TextStyle(color:Colors.white,fontSize: 16),
      backgroundColor:const Color.fromARGB(255, 23, 12, 6),
          title: const Text('Koniec gry'),
          content: SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.height / 3.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Brawo ukończyłeś gre.Udało ci się pokonać złodzieja i odzyskać złoto.'),
                SizedBox(height:MediaQuery.of(context).size.height / 5,width:MediaQuery.of(context).size.width / 2.5,child: Image.asset('assets/images/złoto.png'))
              ],
            ),
          ),
          actions: [
            ElevatedButton(
                onPressed: (){
                  ref.read(myStateProvider.notifier).gameOver();
                  ref.read(providerEQ.notifier).deleteItems();
                  ref.read(myStateProvider.notifier).closeGameDB();
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const MainMenu()));
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.brown[700],foregroundColor: Colors.amber,side: const BorderSide(color: Color(0xFFC0C0C0))),
                child: const Text('Przejdź do menu'))
          ],
        );
  }
}
import 'package:brave_steve/game/presentation/eq_screen/eq.dart';
import 'package:brave_steve/game/presentation/fight_screen/exit_to_menu_dialog.dart';
import 'package:brave_steve/game/presentation/fight_screen/save_game_dialog.dart';
import 'package:brave_steve/game/presentation/fight_screen/battle_view_widget.dart';
import 'package:brave_steve/game/presentation/fight_screen/stats_view_widget.dart';
import 'package:brave_steve/game/presentation/money_widget.dart';
import 'package:brave_steve/game/state_menegment/game_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../data_layer/models/player_model/player_body.dart';
import 'action_buttons_view_widget.dart';

class FightScreen extends StatefulWidget {
  const FightScreen(this.isNewGame, {super.key});
  final bool isNewGame;

  @override
  State<FightScreen> createState() => _FightScreenState();
}

class _FightScreenState extends State<FightScreen> {
  // Klucze dla elementów paska
  final GlobalKey _keySave = GlobalKey();
  final GlobalKey _keyEq = GlobalKey();

  @override
  Widget build(BuildContext context) {
    //final myVars = ref.watch(myStateProvider);
    //final gameState = ref.watch(myStateProvider.notifier);
    final Size mediaQuerySize = MediaQuery.of(context).size;
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double fontSize = mediaQueryData.textScaler.scale(14.0);

    // POPRAWKA: 'builder' przyjmuje funkcję (context), a nie widget Builder.
    return ShowCaseWidget(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            foregroundColor: Colors.white,
            leadingWidth: MediaQuery.of(context).size.width / 4,
            leading: Row(
              children: [
                IconButton(
                  onPressed: () async {
                    showDialog(
                        context: context,
                        builder: (context) => const ExitToMenu());
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
                // === DYSKIETKA ZAPISU ===
                Showcase(
                  key: _keySave,
                  title: 'Zapisz grę',
                  description: 'Tutaj możesz zapisać postęp gry.',
                  overlayColor: Colors.black.withValues(alpha: 0.7),
                  targetBorderRadius: BorderRadius.circular(50),
                  tooltipBackgroundColor: Colors.white,
                  textColor: Colors.black,
                  titleTextStyle: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                  child: IconButton(
                    onPressed: () async {
                      showDialog(
                          context: context, builder: (context) => SaveGame());
                    },
                    icon: const Icon(Icons.save),
                  ),
                ),
              ],
            ),
            title: const Text('Brave Steve'),
            centerTitle: true,
            backgroundColor: const Color(0xFF301b0a),
            actions: [
              // === EKWIPUNEK / LUDZIK ===
              Showcase(
                  key: _keyEq,
                  title: 'Ekwipunek',
                  description: 'Sprawdź statystyki i ulepsz postać.',
                  overlayColor: Colors.black.withValues(alpha: 0.7),
                  targetBorderRadius: BorderRadius.circular(50),
                  tooltipBackgroundColor: Colors.white,
                  textColor: Colors.black,
                  titleTextStyle: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                  child: Consumer(
                    builder: (context, ref, child) {
                      ref.watch(myStateProvider);
                      return IconButton(
                          onPressed: () {
                            if (ref.read(myStateProvider.notifier).isEq()) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const Equpment()));
                            }
                          },
                          icon: Icon(
                            Icons.person,
                            color: ref.read(myStateProvider.notifier).isEq()
                                ? Colors.amber
                                : Colors.grey,
                          ));
                    },
                  ))
            ],
          ),
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(alignment: Alignment.topRight, children: [
              Column(
                children: [
                  Container(
                    height: mediaQuerySize.height / 3,
                    width: mediaQuerySize.width,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/LandScape.jpg'),
                      ),
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          BattleView(
                            image: PlayerBody.playerBody[0],
                            side: 'left',
                            fontSize: fontSize,
                            mediaQuerySize: mediaQuerySize,
                          ),
                          Consumer(
                            builder: (context, ref, child) {
                              final index = ref.watch(myStateProvider.select(
                                (gameState) => gameState.index,
                              ));

                              return Column(
                                children: [
                                  BattleView(
                                    image: PlayerBody.playerBody[index],
                                    side: 'right',
                                    fontSize: fontSize,
                                    mediaQuerySize: mediaQuerySize,
                                  ),
                                ],
                              );
                            },
                          ),
                        ]),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      StatsView(
                          side: 'left',
                          fontSize: fontSize,
                          mediaQuerySize: mediaQuerySize),
                      StatsView(
                          side: 'right',
                          fontSize: fontSize,
                          mediaQuerySize: mediaQuerySize)
                    ],
                  ),
                  // Przekazujemy klucze do dolnego widgetu
                  ActionInGame(
                    isNewGame: widget.isNewGame,
                    keySave: _keySave,
                    keyEq: _keyEq,
                  )
                ],
              ),
              const MoneyWidget()
            ]),
          ),
        );
      },
    );
  }
}

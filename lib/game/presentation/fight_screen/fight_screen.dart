import 'package:brave_steve/game/presentation/eq_screen/eq.dart';
import 'package:brave_steve/game/presentation/fight_screen/exit_to_menu_dialog.dart';
import 'package:brave_steve/game/presentation/fight_screen/save_game_dialog.dart';
import 'package:brave_steve/game/presentation/fight_screen/battle_view_widget.dart';
import 'package:brave_steve/game/presentation/fight_screen/stats_view_widget.dart';
import 'package:brave_steve/game/state_menegment/game_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../data_layer/models/player_model/player_body.dart';
import 'action_buttons_view_widget.dart';

class FightScreen extends ConsumerStatefulWidget {
  const FightScreen(this.isNewGame, {super.key});
  final bool isNewGame;

  @override
  ConsumerState<FightScreen> createState() => _FightScreenState();
}

class _FightScreenState extends ConsumerState<FightScreen> {
  // Klucze dla elementów paska
  final GlobalKey _keySave = GlobalKey();
  final GlobalKey _keyEq = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final myVars = ref.watch(myStateProvider);
    final gameState = ref.watch(myStateProvider.notifier);
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
                child: IconButton(
                    onPressed: () {
                      if (gameState.isEq()) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Equpment()));
                      }
                    },
                    icon: gameState.isEq()
                        ? const Icon(
                            Icons.boy_rounded,
                            color: Colors.amber,
                          )
                        : const Icon(
                            Icons.boy_rounded,
                            color: Colors.grey,
                          )),
              )
            ],
          ),
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        BattleView(
                          image: PlayerBody.playerBody[0],
                          side: 'left',
                          player: myVars.list[0],
                          fontSize: fontSize,
                          mediaQuerySize: mediaQuerySize,
                        ),
                        StatsView(
                            side: 'left',
                            player: myVars.list[0],
                            fontSize: fontSize,
                            mediaQuerySize: mediaQuerySize)
                      ],
                    ),
                    Column(
                      children: [
                        BattleView(
                          image: PlayerBody.playerBody[myVars.index],
                          side: 'right',
                          player: myVars.list[myVars.index],
                          fontSize: fontSize,
                          mediaQuerySize: mediaQuerySize,
                        ),
                        StatsView(
                            side: 'right',
                            player: myVars.list[myVars.index],
                            fontSize: fontSize,
                            mediaQuerySize: mediaQuerySize)
                      ],
                    ),
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
          ),
        );
      },
    );
  }
}

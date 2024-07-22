import 'package:brave_steve/game/presentation/screens/eq.dart';
import 'package:brave_steve/game/presentation/widgets/alertsDialog/exit_to_menu.dart';
import 'package:brave_steve/game/presentation/widgets/alertsDialog/save_game.dart';
import 'package:brave_steve/game/state_menegment/game_state.dart';
import 'package:flutter/material.dart';
import '../../data_layer/models/player_model/player_body.dart';
import '../widgets/action_buttons_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/player_view.dart';
import 'package:feature_discovery/feature_discovery.dart';

class GameView extends ConsumerWidget {
  const GameView(this.isNewGame, {super.key});
  final bool isNewGame;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myVars = ref.watch(myStateProvider);
    final gameState = ref.watch(myStateProvider.notifier);
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
                    context: context, builder: (context) => const ExitToMenu());
              },
              icon: const Icon(Icons.arrow_back),
            ),
            IconButton(
              onPressed: () async {
                showDialog(context: context, builder: (context) => SaveGame());
              },
              icon: const Icon(Icons.save),
            ),
          ],
        ),
        title: const Text('Brave Steve'),
        centerTitle: true,
        backgroundColor: const Color(0xFF301b0a),
        actions: [
          IconButton(
              onPressed: () {
                if(gameState.isEq()){
                   Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Equpment()));
                }
              },
              icon: gameState.isEq()? const Icon(Icons.boy_rounded,color: Colors.amber,):const Icon(Icons.boy_rounded,color: Colors.grey,))  
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
                PlayerView(
                    image: PlayerBody.playerBody[0],
                    player: myVars.list[0],
                    side: 'left'),
                PlayerView(
                    image: PlayerBody.playerBody[myVars.index],
                    player: myVars.list[myVars.index],
                    side: 'right')
              ],
            ),
            FeatureDiscovery(child: ActionInGame(isNewGame: isNewGame))
          ],
        ),
      ),
    );
  }
}

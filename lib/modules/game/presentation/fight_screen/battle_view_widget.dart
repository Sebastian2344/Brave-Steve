//----------------------------------------------BattleView------------------------------------------------
import 'package:brave_steve/modules/game/model/player_body.dart';
import 'package:brave_steve/modules/game/state_menegment/effects_state.dart';
import 'package:brave_steve/modules/game/state_menegment/game_state.dart';
import 'package:brave_steve/modules/counter_enemy_and_bioms/view/background_battle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BattleView extends StatelessWidget {
  const BattleView({
    super.key,
    required this.fontSize,
    required this.mediaQuerySize,
  });
  final double fontSize;
  final Size mediaQuerySize;

  @override
  Widget build(BuildContext context) {
    //tło walki z postaciami
    return Stack(
      children: [
        const BackgroundBattle(),
        //gracz
        Consumer(
          builder: (context, ref, child) {
            final move1 =
                ref.watch(myStateProvider.select((counter) => counter.move1));
            final heroEffect = ref.watch(effectsStateProvider
                .select((effect) => effect.isClearencePlayer));
            final heroEffect2 = ref.watch(effectsStateProvider
                .select((effect) => effect.isWeaknessPlayer));
            return AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              left: move1 ? mediaQuerySize.width / 2 / 5 : 0,
              child: heroEffect || heroEffect2
                  ? ColorFiltered(
                      colorFilter: ColorFilter.mode(
                          heroEffect ? Colors.lightBlue : Colors.red,
                          BlendMode.modulate),
                      child: Image.asset(
                        PlayerBody.playerBody[0][0],
                        width: mediaQuerySize.width /
                            2, //postac z efektem szerokość
                        height: mediaQuerySize.height /
                            3, //postac z efektem wysokość
                      ),
                    )
                  : Image.asset(
                      PlayerBody.playerBody[0][0],
                      width: mediaQuerySize.width / 2, //postac szerokrść
                      height: mediaQuerySize.height / 3, //postac wysokość
                    ),
            );
          },
        ),
        //przeciwnik
        Consumer(
          builder: (context, ref, child) {
            final move2 =
                ref.watch(myStateProvider.select((counter) => counter.move2));
            final heroEffect = ref.watch(effectsStateProvider
                .select((counter) => counter.isClearenceEnemy));
            final heroEffect2 = ref.watch(effectsStateProvider
                .select((counter) => counter.isWeaknessEnemy));
            final enemyIndex = ref
                .watch(myStateProvider.select((counter) => counter.enemyIndex));
            return AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              right: move2 ? mediaQuerySize.width / 2 / 5 : 0,
              child: heroEffect || heroEffect2
                  ? ColorFiltered(
                      colorFilter: ColorFilter.mode(
                          heroEffect ? Colors.lightBlue : Colors.red,
                          BlendMode.modulate),
                      child: Image.asset(
                        PlayerBody.playerBody[enemyIndex][0],
                        width: mediaQuerySize.width /
                            2, //postac z efektem szerokość
                        height: mediaQuerySize.height /
                            3, //postac z efektem wysokość
                      ),
                    )
                  : Image.asset(
                      PlayerBody.playerBody[enemyIndex][0],
                      width: mediaQuerySize.width / 2, //postac szerokrść
                      height: mediaQuerySize.height / 3, //postac wysokość
                    ),
            );
          },
        ),
      ],
    );
  }
}

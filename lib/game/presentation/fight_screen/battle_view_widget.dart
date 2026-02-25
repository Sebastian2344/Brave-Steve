//----------------------------------------------BattleView------------------------------------------------
import 'package:brave_steve/game/data_layer/models/player_model/player_body.dart';
import 'package:brave_steve/game/state_menegment/map_state.dart';
import 'package:brave_steve/game/state_menegment/game_state.dart';
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
    return Consumer(
      builder: (context, ref, child) {
        ref.watch(mapNotifierProvider.select((counter) => counter.boss));
        return Container(
            height: mediaQuerySize.height / 3,
            width: mediaQuerySize.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image:
                    AssetImage(ref.read(mapNotifierProvider.notifier).getMap()),
              ),
            ),
            child: child);
      },
      child:
          //postacie w walce
          Stack(
        children: [
          //gracz
          Consumer(
            builder: (context, ref, child) {
              final game = ref.watch(myStateProvider);
              return AnimatedPositioned(
                duration: const Duration(milliseconds: 500),
                left: game.move1 ? mediaQuerySize.width / 2 / 5 : 0,
                child: game.heroEffect[0] || game.heroEffect[2]
                    ? ColorFiltered(
                        colorFilter: ColorFilter.mode(
                            game.heroEffect[2] ? Colors.lightBlue : Colors.red,
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
              final game = ref.watch(myStateProvider);
              return AnimatedPositioned(
                duration: const Duration(milliseconds: 500),
                right: game.move2 ? mediaQuerySize.width / 2 / 5 : 0,
                child: game.heroEffect[1] || game.heroEffect[3]
                    ? ColorFiltered(
                        colorFilter: ColorFilter.mode(
                            game.heroEffect[3] ? Colors.lightBlue : Colors.red,
                            BlendMode.modulate),
                        child: Image.asset(
                          PlayerBody.playerBody[game.enemyIndex][0],
                          width: mediaQuerySize.width /
                              2, //postac z efektem szerokość
                          height: mediaQuerySize.height /
                              3, //postac z efektem wysokość
                        ),
                      )
                    : Image.asset(
                        PlayerBody.playerBody[game.enemyIndex][0],
                        width: mediaQuerySize.width / 2, //postac szerokrść
                        height: mediaQuerySize.height / 3, //postac wysokość
                      ),
              );
            },
          ),
        ],
      ),
    );
  }
}

//----------------------------------------------BattleView------------------------------------------------
import 'package:brave_steve/game/state_menegment/game_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BattleView extends StatelessWidget {
  const BattleView({
    super.key,
    required this.image,
    required this.side,
    required this.fontSize,
    required this.mediaQuerySize,
  });
  final List<String> image;
  final String side;
  final double fontSize;
  final Size mediaQuerySize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: mediaQuerySize.height / 3,
      width: mediaQuerySize.width / 2,
      child: Stack(fit: StackFit.expand, children: [
        Consumer(builder: (context, ref, child) {
      
          final game = ref.watch(myStateProvider);
          final player = ref.read(myStateProvider).list[side == 'left' ? 0 : ref.read(myStateProvider).index];
          return AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              left: side == 'left'
                  ? game.move1
                      ? mediaQuerySize.width / 2 / 5
                      : 0
                  : game.move2 && player.getName() != 'Skeleton'
                      ? 0
                      : mediaQuerySize.width / 2 / 5,
              top: player.getName() == 'Spider'
                  ? mediaQuerySize.height / 3 / 4
                  : mediaQuerySize.height / 3 / 7,
              child: side == 'left' && game.effect[0] ||
                      side == 'right' && game.effect[1] ||
                      side == 'left' && game.effect[2] ||
                      side == 'right' && game.effect[3]
                  ? ColorFiltered(
                      colorFilter: ColorFilter.mode(
                          side == 'left' && game.effect[2] ||
                                  side == 'right' && game.effect[3]
                              ? Colors.lightBlue
                              : Colors.red,
                          BlendMode.modulate),
                      child: Image.asset(
                        alignment: side == 'right'
                            ? Alignment.topRight
                            : Alignment.topLeft,
                        game.move2 ? image[1] : image[0],
                        width: mediaQuerySize.width /
                            2.25, //postac z efektem szerokość
                        height: mediaQuerySize.height /
                            2.25, //postac z efektem wysokość
                      ),
                    )
                  : Image.asset(
                      alignment: side == 'right'
                          ? Alignment.topRight
                          : Alignment.topLeft,
                      game.move2 ? image[1] : image[0],
                      width: mediaQuerySize.width / 2.25, //postac szerokrść
                      height: mediaQuerySize.height / 2.25, //postac wysokość
                    ));
        }),
        //player.getName() == 'Skeleton' && side == 'right'
         //   ? Consumer(builder: (context, ref, child) {
          //      final game = ref.watch(myStateProvider);
          //      return AnimatedPositioned(
            //        duration: const Duration(milliseconds: 500),
             //       left: game.arrowGo ? 0 : mediaQuerySize.width / 2 / 4,
            //        top: mediaQuerySize.height / 3 / 2,
             //       child: Visibility(
              //        visible: game.move2 && !game.effect[3],
               //       child: Transform.rotate(
              //            angle: 3.14,
              //            child: SizedBox(
                          //    width: mediaQuerySize.width * 0.1,
               //               height: mediaQuerySize.height * 0.05,
              //                child: Image.asset(image[2]))),
              //      ));
             // })
           // : const SizedBox()
      ]),
    );
  }
}

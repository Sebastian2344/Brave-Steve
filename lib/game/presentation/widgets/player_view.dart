import 'package:brave_steve/game/state_menegment/eq_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data_layer/models/player_model/player_model.dart';
import '../../state_menegment/game_state.dart';

class PlayerView extends ConsumerWidget {
  const PlayerView(
      {super.key,
      required this.image,
      required this.player,
      required this.side});
  final List<String> image;
  final String side;
  final PlayerModel player;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Size mediaQuerySize = MediaQuery.of(context).size;
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double fontSize = mediaQueryData.textScaler.scale(14.0);
    final game = ref.watch(myStateProvider);
    ref.watch(providerEQ);

    return Column(
      children: [
        BattleView(
            image: image,
            side: side,
            player: player,
            fontSize: fontSize,
            mediaQuerySize: mediaQuerySize,
            game: game),
        StatsView(
            side: side,
            player: player,
            fontSize: fontSize,
            mediaQuerySize: mediaQuerySize)
      ],
    );
  }
}

//----------------------------------------------BattleView------------------------------------------------
class BattleView extends StatelessWidget {
  const BattleView(
      {super.key,
      required this.image,
      required this.side,
      required this.player,
      required this.fontSize,
      required this.mediaQuerySize,
      required this.game});
  final List<String> image;
  final String side;
  final PlayerModel player;
  final double fontSize;
  final Size mediaQuerySize;
  final MyVars game;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(side == 'left'
                  ? 'assets/images/LandScape1.jpg'
                  : 'assets/images/LandScape2.jpg'),
              fit: BoxFit.cover)),
      height: mediaQuerySize.height / 3,
      width: mediaQuerySize.width / 2,
      child: Stack(children: [
        AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            left: side == 'left'
                ? game.move1
                    ? mediaQuerySize.width / 2 / 4
                    : 0
                : game.move2 && player.getName() != 'Skeleton'
                    ? 0
                    : mediaQuerySize.width / 2 / 4,
            top: player.getName() == 'Spider'
                ? mediaQuerySize.height / 3 / 4
                : mediaQuerySize.height / 3 / 7,
            child: side =='left' && game.effect[0] || side =='right' && game.effect[1] || side =='left' && game.effect[2] || side =='right' && game.effect[3]?ColorFiltered(
              colorFilter: ColorFilter.mode(
                side =='left' && game.effect[2] || side =='right' && game.effect[3]?Colors.lightBlue:
                       Colors.red,
                  BlendMode.modulate),
              child: Image.asset(
                game.move2 ? image[1] : image[0],
                width: mediaQuerySize.width * 0.35,
                height: mediaQuerySize.height * 0.3,
              ),
            ):Image.asset(
                game.move2 ? image[1] : image[0],
                width: mediaQuerySize.width * 0.35,
                height: mediaQuerySize.height * 0.3,
              )),
             player.getName() == 'Skeleton' && side == 'right'?
                 AnimatedPositioned(
                    duration: const Duration(milliseconds: 500),
                    left: game.arrowGo? 0 : mediaQuerySize.width / 2 / 4,
                    top: mediaQuerySize.height / 3 / 2,
                    child: Visibility(
                      visible: game.move2 && !game.effect[3],
                      child: Transform.rotate(
                          angle: 3.14,
                          child: SizedBox(
                              width: mediaQuerySize.width * 0.1,
                              height: mediaQuerySize.height * 0.05,
                              child: Image.asset(image[2]))),
                    ))
             : const SizedBox()
      ]),
    );
  }
}

//----------------------------------------------StatsView------------------------------------------------
class StatsView extends StatelessWidget {
  const StatsView(
      {super.key,
      required this.side,
      required this.player,
      required this.fontSize,
      required this.mediaQuerySize});
  final String side;
  final PlayerModel player;
  final double fontSize;
  final Size mediaQuerySize;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 23, 12, 6),
          border: Border(
            top: BorderSide(
                width: 8, style: BorderStyle.solid, color: Color(0xFFC0C0C0)),
            left: BorderSide(
                width: 4, style: BorderStyle.solid, color: Color(0xFFC0C0C0)),
            bottom: BorderSide(
                width: 8, style: BorderStyle.solid, color: Color(0xFFC0C0C0)),
            right: BorderSide(
                width: 4, style: BorderStyle.solid, color: Color(0xFFC0C0C0)),
          )),
      width: MediaQuery.of(context).size.width / 2,
      height: MediaQuery.of(context).size.height / 2.5,
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Text(
          player.getName(),
          style: TextStyle(color: Colors.amber, fontSize: fontSize + 2),
        ),
        Text(
          "Poziom ${player.getlvl()}",
          style: TextStyle(color: Colors.green, fontSize: fontSize),
        ),
        Text("Atak  ${player.showAttack()}",
            style: TextStyle(color: Colors.blueGrey, fontSize: fontSize)),
        Text(
          "Mana",
          style: TextStyle(
              color: const Color.fromARGB(255, 5, 46, 168), fontSize: fontSize),
        ),
        Stack(
          alignment: Alignment.centerLeft,
          children: [
            Container(
              width: mediaQuerySize.width / 2 * 0.9,
              height: mediaQuerySize.height / 3 / 10,
              color: const Color.fromARGB(55, 0, 0, 255),
            ),
            Container(
              width: player.showMana() > 10
                  ? mediaQuerySize.width / 2 * 0.9
                  : mediaQuerySize.width / 2 * 0.9 * (player.showMana() / 10),
              height: mediaQuerySize.height / 3 / 10,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 37, 62, 150),
                    Color.fromARGB(255, 23, 5, 188)
                  ],
                ),
              ),
            ),
            SizedBox(
              width: mediaQuerySize.width / 2 * 0.9,
              height: mediaQuerySize.height / 3 / 10,
              child: Center(
                child: Text(
                  '${player.showMana()} / 10',
                  style: TextStyle(fontSize: fontSize, color: Colors.white),
                ),
              ),
            )
          ],
        ),
        Text(
          "Życie",
          style: TextStyle(
              color: const Color.fromARGB(255, 168, 5, 5), fontSize: fontSize),
        ),
        Stack(
          alignment: Alignment.centerLeft,
          children: [
            Container(
              width: mediaQuerySize.width / 2 * 0.9,
              height: mediaQuerySize.height / 3 / 10,
              color: const Color.fromARGB(35, 255, 0, 0),
            ),
            Container(
              width: mediaQuerySize.width /
                  2 *
                  0.9 *
                  (player.showHp() / player.maxHpInfo()),
              height: mediaQuerySize.height / 3 / 10,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 151, 43, 35),
                    Color.fromARGB(255, 220, 21, 7)
                  ],
                ),
              ),
            ),
            SizedBox(
              width: mediaQuerySize.width / 2 * 0.9,
              height: mediaQuerySize.height / 3 / 10,
              child: Center(
                child: Text(
                  '${player.showHp()} / ${player.maxHpInfo()}',
                  style: TextStyle(fontSize: fontSize, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        Text(
          "Armour",
          style: TextStyle(
              color:const Color.fromARGB(255, 136, 137, 136), fontSize: fontSize),
        ),
        Stack(
          alignment: Alignment.centerLeft,
          children: [
            Container(
              width: mediaQuerySize.width / 2 * 0.9,
              height: mediaQuerySize.height / 3 / 10,
              color: const Color.fromARGB(34, 170, 173, 170),
            ),
            Container(
              width: mediaQuerySize.width /
                  2 *
                  0.9 *
                  (player.getArmour() / 40),
              height: mediaQuerySize.height / 3 / 10,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 99, 101, 99),
                    Color.fromARGB(255, 128, 130, 128)
                  ],
                ),
              ),
            ),
            SizedBox(
              width: mediaQuerySize.width / 2 * 0.9,
              height: mediaQuerySize.height / 3 / 10,
              child: Center(
                child: Text(
                  '${player.getArmour()} / 40.0',
                  style: TextStyle(fontSize: fontSize, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        Text(
          "Doświadczene",
          style: TextStyle(
              color: const Color.fromARGB(255, 5, 168, 21), fontSize: fontSize),
        ),
        Stack(
          alignment: Alignment.centerLeft,
          children: [
            Container(
              width: mediaQuerySize.width / 2 * 0.9,
              height: mediaQuerySize.height / 3 / 10,
              color: const Color.fromARGB(35, 0, 255, 0),
            ),
            Container(
              width: mediaQuerySize.width /
                  2 *
                  0.9 *
                  (player.showExp() / 100),
              height: mediaQuerySize.height / 3 / 10,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 35, 151, 58),
                    Color.fromARGB(255, 21, 220, 7)
                  ],
                ),
              ),
            ),
            SizedBox(
              width: mediaQuerySize.width / 2 * 0.9,
              height: mediaQuerySize.height / 3 / 10,
              child: Center(
                child: Text(
                  '${player.showExp()} / 100',
                  style: TextStyle(fontSize: fontSize, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}

//----------------------------------------------StatsView------------------------------------------------
import 'package:brave_steve/game/state_menegment/eq_state.dart';
import 'package:brave_steve/game/state_menegment/game_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StatsView extends StatelessWidget {
  const StatsView(
      {super.key,
      required this.side,
      required this.fontSize,
      required this.mediaQuerySize});
  final String side;
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
        ),
      ),
      width: MediaQuery.of(context).size.width / 2,
      height: MediaQuery.of(context).size.height / 2.5,
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Consumer(
          builder: (context, ref, child) {
            final name = ref.watch(myStateProvider.select(
              (gameState) => side == 'left'
                  ? gameState.list[0].getName()
                  : gameState.list[gameState.index].getName(),
            ));
            return Text(
              name,
              style: TextStyle(color: Colors.amber, fontSize: fontSize + 2),
            );
          },
        ),
        Consumer(
          builder: (context, ref, child) {
            final level = ref.watch(myStateProvider.select(
              (gameState) => side == 'left'
                  ? gameState.list[0].getlvl()
                  : gameState.list[gameState.index].getlvl(),
            ));
            return Text(
              "Poziom $level",
              style: TextStyle(color: Colors.green, fontSize: fontSize),
            );
          },
        ),
        Consumer(
          builder: (context, ref, child) {
            ref.watch(providerEQ);
            final attack = ref.watch(myStateProvider.select(
              (gameState) => side == 'left'
                  ? gameState.list[0].showAttack()
                  : gameState.list[gameState.index].showAttack(),
            ));
            return Text("Atak  $attack",
                style: TextStyle(color: Colors.blueGrey, fontSize: fontSize));
          },
        ),
        Text(
          "Mana",
          style: TextStyle(
              color: const Color.fromARGB(255, 5, 46, 168), fontSize: fontSize),
        ),
        ManaBar(
            fontSize: fontSize,
            mediaQuerySize: mediaQuerySize,
            side: side == 'left' ? true : false),
        Text(
          "Życie",
          style: TextStyle(
              color: const Color.fromARGB(255, 168, 5, 5), fontSize: fontSize),
        ),
        HealthBar(
            fontSize: fontSize,
            mediaQuerySize: mediaQuerySize,
            side: side == 'left' ? true : false),
        Text(
          "Armour",
          style: TextStyle(
              color: const Color.fromARGB(255, 136, 137, 136),
              fontSize: fontSize),
        ),
        ArmourBar(
            fontSize: fontSize,
            mediaQuerySize: mediaQuerySize,
            side: side == 'left' ? true : false),
        Text(
          "Doświadczene",
          style: TextStyle(
              color: const Color.fromARGB(255, 5, 168, 21), fontSize: fontSize),
        ),
        ExpBar(
            fontSize: fontSize,
            mediaQuerySize: mediaQuerySize,
            side: side == 'left' ? true : false)
      ]),
    );
  }
}

class HealthBar extends ConsumerWidget {
  const HealthBar(
      {super.key,
      required this.fontSize,
      required this.mediaQuerySize,
      required this.side});
  final double fontSize;
  final Size mediaQuerySize;
  final bool side;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(myStateProvider.select(
      (gameState) => side ? gameState.list[0].showHp() : gameState.list[gameState.index].showHp(),
    ));
    final player = ref.read(myStateProvider).list[side ? 0 : ref.read(myStateProvider).index];
    return Stack(
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
    );
  }
}

class ManaBar extends ConsumerWidget {
  const ManaBar(
      {super.key,
      required this.fontSize,
      required this.mediaQuerySize,
      required this.side});
  final double fontSize;
  final Size mediaQuerySize;
  final bool side;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(myStateProvider.select(
      (gameState) => side ? gameState.list[0].showMana() : gameState.list[gameState.index].showMana(),
    ));
    final player = ref.read(myStateProvider).list[side ? 0 : ref.read(myStateProvider).index];
    return Stack(
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
    );
  }
}

class ArmourBar extends ConsumerWidget {
  const ArmourBar(
      {super.key,
      required this.fontSize,
      required this.mediaQuerySize,
      required this.side});
  final double fontSize;
  final Size mediaQuerySize;
  final bool side;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(providerEQ);
    ref.watch(myStateProvider.select(
      (gameState) => side ? gameState.list[0].getArmour() : gameState.list[gameState.index].getArmour(),
    ));
    final player = ref.read(myStateProvider).list[side ? 0 : ref.read(myStateProvider).index];
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Container(
          width: mediaQuerySize.width / 2 * 0.9,
          height: mediaQuerySize.height / 3 / 10,
          color: const Color.fromARGB(34, 170, 173, 170),
        ),
        Container(
          width: mediaQuerySize.width / 2 * 0.9 * (player.getArmour() / 40),
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
    );
  }
}

class ExpBar extends ConsumerWidget {
  const ExpBar(
      {super.key,
      required this.fontSize,
      required this.mediaQuerySize,
      required this.side});
  final double fontSize;
  final Size mediaQuerySize;
  final bool side;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(myStateProvider.select(
      (gameState) => side ? gameState.list[0].showExp() : gameState.list[gameState.index].showExp(),
    ));
    final player = ref.read(myStateProvider).list[side ? 0 : ref.read(myStateProvider).index];
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Container(
          width: mediaQuerySize.width / 2 * 0.9,
          height: mediaQuerySize.height / 3 / 10,
          color: const Color.fromARGB(35, 0, 255, 0),
        ),
        Container(
          width: mediaQuerySize.width / 2 * 0.9 * (player.showExp() / 100),
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
    );
  }
}

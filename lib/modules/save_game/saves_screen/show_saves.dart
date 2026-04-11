import 'package:brave_steve/modules/save_game/menagment/save_state.dart';
import 'package:brave_steve/modules/sounds/menagment/sound_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../game/model/steve.dart';
import '../model/save_model.dart';
import '../../game/state_menegment/game_state.dart';

import '../../game/presentation/fight_screen/fight_screen.dart';

class ShowSaves extends ConsumerStatefulWidget {
  const ShowSaves({super.key});

  @override
  ConsumerState<ShowSaves> createState() => _ShowSavesState();
}

class _ShowSavesState extends ConsumerState<ShowSaves> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              ref.read(soundManagerProvider.notifier).playButtonClick();
              if (ref.read(myStateProvider).gameState ==
                  Stan.graNieRozpoczeta) {
                Navigator.of(context).pop();
              } else {
                Navigator.of(context).pop();
              }
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: Text(
            'saves_screen.saves'.tr(context: context),
            style: TextStyle(color: Colors.white),
          ),
          titleTextStyle: const TextStyle(fontSize: 26),
          centerTitle: true,
          backgroundColor: Colors.brown[900],
          foregroundColor: Colors.white,
        ),
        body: Consumer(
          builder: (context, ref, child) {
            List<SaveModel> listSaves = ref.watch(saveStateProvider);
            return listSaves.isEmpty
                ? Center(
                    child: Text(
                      'saves_screen.no_saves'.tr(context: context),
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                : ListView.builder(
                    itemCount: listSaves.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          contentPadding: const EdgeInsets.all(8),
                          textColor: Colors.white,
                          subtitleTextStyle: const TextStyle(fontSize: 14),
                          titleTextStyle: const TextStyle(fontSize: 20),
                          title: Center(child: Text(listSaves[index].name)),
                          tileColor: Colors.brown[800],
                          subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.35,
                                  child: Column(
                                    children: [
                                      Text(
                                        listSaves[index].list[0].getName(),
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      Table(columnWidths: const {
                                        0: FractionColumnWidth(4 / 5),
                                        1: FractionColumnWidth(4 / 5),
                                      }, children: [
                                        TableRow(children: [
                                          TableCell(
                                              child: Text('saves_screen.health'
                                                  .tr(context: context))),
                                          TableCell(
                                              child: Text(
                                                  '${listSaves[index].list[0].showHp()}'))
                                        ]),
                                        TableRow(children: [
                                          TableCell(
                                              child: Text('saves_screen.mana'
                                                  .tr(context: context))),
                                          TableCell(
                                              child: Text(
                                                  '${listSaves[index].list[0].showMana()}'))
                                        ]),
                                        TableRow(children: [
                                          TableCell(
                                              child: Text('saves_screen.attack'
                                                  .tr(context: context))),
                                          TableCell(
                                              child: Text(
                                                  '${listSaves[index].list[0].showAttack()}'))
                                        ]),
                                        TableRow(children: [
                                          TableCell(
                                              child: Text('saves_screen.level'
                                                  .tr(context: context))),
                                          TableCell(
                                              child: Text(
                                                  '${listSaves[index].list[0].getlvl()}'))
                                        ]),
                                        TableRow(
                                          children: [
                                            TableCell(
                                                child: Text(
                                                    'saves_screen.experience'
                                                        .tr(context: context))),
                                            TableCell(
                                                child: Text(
                                                    '${listSaves[index].list[0].showExp()}'))
                                          ],
                                        ),
                                      ]),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.35,
                                  child: Column(
                                    children: [
                                      Text(
                                        listSaves[index]
                                            .list[(listSaves[index].list[0]
                                                    as Steve)
                                                .getEnemyIndex()]
                                            .getName(),
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      Table(columnWidths: const {
                                        0: FractionColumnWidth(4 / 5),
                                        1: FractionColumnWidth(4 / 5),
                                      }, children: [
                                        TableRow(children: [
                                          TableCell(
                                              child: Text('saves_screen.health'
                                                  .tr(context: context))),
                                          TableCell(
                                              child: Text(
                                                  '${listSaves[index].list[(listSaves[index].list[0] as Steve).getEnemyIndex()].showHp()}'))
                                        ]),
                                        TableRow(children: [
                                          TableCell(
                                              child: Text('saves_screen.mana'
                                                  .tr(context: context))),
                                          TableCell(
                                              child: Text(
                                                  '${listSaves[index].list[(listSaves[index].list[0] as Steve).getEnemyIndex()].showMana()}'))
                                        ]),
                                        TableRow(children: [
                                          TableCell(
                                              child: Text('saves_screen.attack'
                                                  .tr(context: context))),
                                          TableCell(
                                              child: Text(
                                                  '${listSaves[index].list[(listSaves[index].list[0] as Steve).getEnemyIndex()].showAttack()}'))
                                        ]),
                                        TableRow(children: [
                                          TableCell(
                                              child: Text('saves_screen.level'
                                                  .tr(context: context))),
                                          TableCell(
                                              child: Text(
                                                  '${listSaves[index].list[(listSaves[index].list[0] as Steve).getEnemyIndex()].getlvl()}'))
                                        ]),
                                        TableRow(
                                          children: [
                                            TableCell(
                                                child: Text(
                                                    'saves_screen.experience'
                                                        .tr(context: context))),
                                            TableCell(
                                                child: Text(
                                                    '${listSaves[index].list[(listSaves[index].list[0] as Steve).getEnemyIndex()].showExp()}'))
                                          ],
                                        ),
                                      ]),
                                    ],
                                  ),
                                ),
                              ]),
                          trailing: CircleAvatar(
                            child: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                ref
                                    .read(saveStateProvider.notifier)
                                    .removeSave(index);
                                setState(() {
                                  listSaves.removeAt(index);
                                });
                              },
                            ),
                          ),
                          onTap: () {
                            ref
                                .read(saveStateProvider.notifier)
                                .loadSave(index);
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => const FightScreen(false),
                              ),
                              (route) => route.isFirst,
                            );
                          },
                        ),
                      );
                    },
                  );
          },
        ));
  }
}

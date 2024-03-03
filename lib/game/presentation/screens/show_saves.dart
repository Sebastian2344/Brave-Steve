import 'package:brave_steve/game/presentation/screens/main_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data_layer/models/save_model/save_model.dart';
import '../../state_menegment/riverpod/game_state.dart';

import 'game_view.dart';

class ShowSaves extends ConsumerStatefulWidget {
  const ShowSaves({super.key});

  @override
  ConsumerState<ShowSaves> createState() => _ShowSavesState();
}

class _ShowSavesState extends ConsumerState<ShowSaves> {
  late List<SaveModel> listSaves;

  @override
  Widget build(BuildContext context) {
    listSaves = ref.read(myStateProvider.notifier).returnListSaves();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () async {
            await ref.read(myStateProvider.notifier).closeGameDB();
            if (context.mounted) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const MainMenu(),
                ),
              );
            }
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          'Zapisy',
          style: TextStyle(color: Colors.white),
        ),
        titleTextStyle: const TextStyle(fontSize: 26),
        centerTitle: true,
        backgroundColor: Colors.brown[900],
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: listSaves.length,
        itemBuilder: (context, index) {
          if(listSaves.isEmpty){
            return const Center(child: Text('Brak zapisów',style: TextStyle(fontSize:20),));
          }else{
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
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: Column(
                        children: [
                          Text(
                            listSaves[index].list[0].name,
                            style: const TextStyle(fontSize: 16),
                          ),
                          Table(columnWidths: const {
                            0: FractionColumnWidth(4 / 5),
                            1: FractionColumnWidth(4 / 5),
                          }, children: [
                            TableRow(children: [
                              const TableCell(child: Text('Życie:')),
                              TableCell(
                                  child: Text(
                                      '${listSaves[index].list[0].showHp()}'))
                            ]),
                            TableRow(children: [
                              const TableCell(child: Text('Mana:')),
                              TableCell(
                                  child: Text(
                                      '${listSaves[index].list[0].showMana()}'))
                            ]),
                            TableRow(children: [
                              const TableCell(child: Text('Atak:')),
                              TableCell(
                                  child: Text(
                                      '${listSaves[index].list[0].showAttack()}'))
                            ]),
                            TableRow(children: [
                              const TableCell(child: Text('Poziom:')),
                              TableCell(
                                  child: Text(
                                      '${listSaves[index].list[0].getlvl()}'))
                            ]),
                            TableRow(
                              children: [
                                const TableCell(child: Text('Doświadczenie:')),
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
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: Column(
                        children: [
                          Text(
                            listSaves[index]
                                .list[listSaves[index].list[0].getEnemyIndex()]
                                .name,
                            style: const TextStyle(fontSize: 16),
                          ),
                          Table(columnWidths: const {
                            0: FractionColumnWidth(4 / 5),
                            1: FractionColumnWidth(4 / 5),
                          }, children: [
                            TableRow(children: [
                              const TableCell(child: Text('Życie:')),
                              TableCell(
                                  child: Text(
                                      '${listSaves[index].list[listSaves[index].list[0].getEnemyIndex()].showHp()}'))
                            ]),
                            TableRow(children: [
                              const TableCell(child: Text('Mana:')),
                              TableCell(
                                  child: Text(
                                      '${listSaves[index].list[listSaves[index].list[0].getEnemyIndex()].showMana()}'))
                            ]),
                            TableRow(children: [
                              const TableCell(child: Text('Atak:')),
                              TableCell(
                                  child: Text(
                                      '${listSaves[index].list[listSaves[index].list[0].getEnemyIndex()].showAttack()}'))
                            ]),
                            TableRow(children: [
                              const TableCell(child: Text('Poziom:')),
                              TableCell(
                                  child: Text(
                                      '${listSaves[index].list[listSaves[index].list[0].getEnemyIndex()].getlvl()}'))
                            ]),
                            TableRow(
                              children: [
                                const TableCell(child: Text('Doświadczenie:')),
                                TableCell(
                                    child: Text(
                                        '${listSaves[index].list[listSaves[index].list[0].getEnemyIndex()].showExp()}'))
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
                    ref.read(myStateProvider.notifier).removeSave(index);
                    setState(() {
                      listSaves.removeAt(index);
                    });
                  },
                ),
              ),
              onTap: () {
                ref.read(myStateProvider.notifier).loadGame(index);
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) {
                      return const GameView(false);
                    },
                  ),
                );
              },
            ),
          );
          }  
        },
      ),
    );
  }
}

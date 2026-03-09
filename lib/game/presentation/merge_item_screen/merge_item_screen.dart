import 'package:brave_steve/game/state_menegment/eq_state.dart';
import 'package:brave_steve/game/state_menegment/merge_item_state.dart';
import 'package:brave_steve/game/state_menegment/sound_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MergeItemScreen extends ConsumerWidget {
  const MergeItemScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: const Text('Scalanie przedmiotów'),
        centerTitle: true,
        backgroundColor: Colors.brown[900],
        foregroundColor: Colors.white,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              ref.read(soundManagerProvider.notifier).playButtonClick();
              ref.read(providerMergeItem.notifier).clear();
              Navigator.pop(context);
            }),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WindowMerge(id: 0),
              Text(
                ' + ',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              WindowMerge(id: 1),
              Text(
                ' = ',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              WindowMerge(id: 2),
            ],
          ),
          SizedBox(height: 100),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WindowEQToMerge(id: 5),
              WindowEQToMerge(id: 6),
              WindowEQToMerge(id: 7),
              WindowEQToMerge(id: 8),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WindowEQToMerge(id: 9),
              WindowEQToMerge(id: 10),
              WindowEQToMerge(id: 11),
              WindowEQToMerge(id: 12),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WindowEQToMerge(id: 13),
              WindowEQToMerge(id: 14),
              WindowEQToMerge(id: 15),
              WindowEQToMerge(id: 16),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WindowEQToMerge(id: 17),
              WindowEQToMerge(id: 18),
              WindowEQToMerge(id: 19),
              WindowEQToMerge(id: 20),
            ],
          ),
        ],
      ),
    );
  }
}

class WindowEQToMerge extends ConsumerWidget {
  const WindowEQToMerge({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double boxSize = screenWidth * 0.18;
    final double marginSize = screenWidth * 0.02;
    final isEmpty = ref.read(providerEQ).eqList[id].isEmpty;
    ref.watch(providerEQ).eqList[id];
    return InkWell(
      onTap: () {
        if (isEmpty) return;
        ref.read(soundManagerProvider.notifier).playButtonClick();
        ref.read(providerMergeItem.notifier).addMergeItem(id);
        if (ref.watch(providerMergeItem).length == 2) {
          ref.read(providerMergeItem.notifier).mergeItems();
        }
      },
      onLongPress: () {
        if (isEmpty) return;
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            constraints: BoxConstraints(
              maxWidth: screenWidth * 0.5,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Zamknij'),
              ),
            ],
            title: Text(ref.read(providerEQ).eqList[id].item.name),
            titleTextStyle: const TextStyle(color: Colors.amber, fontSize: 24),
            contentTextStyle:
                const TextStyle(color: Colors.white, fontSize: 16),
            backgroundColor: const Color.fromARGB(255, 23, 12, 6),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(ref.read(providerEQ).eqList[id].item.name),
                SizedBox(height:10),
                Image.asset(ref.read(providerEQ).eqList[id].item.image),
                SizedBox(height:10),
                Text(ref.read(providerEQ).eqList[id].item.description),
                if(ref.read(providerEQ).eqList[id].item.attack != null) Text('Atak: ${ref.read(providerEQ).eqList[id].item.attack}'),
                if(ref.read(providerEQ).eqList[id].item.armour != null)  Text('Pancerz: ${ref.read(providerEQ).eqList[id].item.armour}'),
                Text('Cena: ${ref.read(providerEQ).eqList[id].item.price}'),
              ],
            ),
          ),
        );
      },
      child: Container(
        width: boxSize,
        height: boxSize,
        margin: EdgeInsets.all(marginSize),
        decoration: BoxDecoration(
          color: isEmpty ? Colors.brown[800] : null,
          border: Border.all(
            color: const Color.fromARGB(255, 62, 39, 35),
            width: 2,
          ),
        ),
        // Jeśli jest puste, nie ma child. Jeśli pełne, pokazujemy obrazek.
        child: isEmpty
            ? null
            : Image.asset(
                ref.read(providerEQ).eqList[id].item.image,
                fit: BoxFit.fill,
              ),
      ),
    );
  }
}

class WindowMerge extends ConsumerWidget {
  const WindowMerge({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double boxSize = screenWidth * 0.18;
    final double marginSize = screenWidth * 0.02;
    final isEmpty = ref.read(providerMergeItem).length <= id;
    ref.watch(providerMergeItem);
    final image = isEmpty ? null : ref.read(providerMergeItem)[id].image;
    return InkWell(
      onTap: () {
        if (isEmpty) return;
        ref.read(soundManagerProvider.notifier).playButtonClick();
        if (id < 2) {
          ref.read(providerMergeItem.notifier).removeMergeItem(id);
        } else {
          ref.read(providerEQ.notifier).delete2Items();
          ref.read(providerEQ.notifier).addItemToEQ();
          ref.read(providerMergeItem.notifier).clear();
        }
      },
      onLongPress: () {
        isEmpty
            ? null
            : showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  constraints: BoxConstraints(
                    maxWidth: screenWidth * 0.5,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        ref.read(soundManagerProvider.notifier).playButtonClick();
                        Navigator.pop(context);
                      },
                      child: const Text('Zamknij'),
                    ),
                  ],
                  titleTextStyle:
                      const TextStyle(color: Colors.amber, fontSize: 24),
                  contentTextStyle:
                      const TextStyle(color: Colors.white, fontSize: 16),
                  backgroundColor: const Color.fromARGB(255, 23, 12, 6),
                  title: Text(ref.read(providerMergeItem)[id].name),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(ref.read(providerMergeItem)[id].name),
                      SizedBox(height:10),
                      Image.asset(ref.read(providerMergeItem)[id].image),
                      const SizedBox(height: 10),
                      Text(ref.read(providerMergeItem)[id].description),
                      if (ref.read(providerMergeItem)[id].attack != null)
                        Text('Atak: ${ref.read(providerMergeItem)[id].attack}'),
                      if (ref.read(providerMergeItem)[id].armour != null)
                        Text(
                            'Pancerz: ${ref.read(providerMergeItem)[id].armour}'),
                      Text('Cena: ${ref.read(providerMergeItem)[id].price}'),
                    ],
                  ),
                ),
              );
      },
      child: Container(
        width: boxSize,
        height: boxSize,
        margin: EdgeInsets.all(marginSize),
        decoration: BoxDecoration(
          color: isEmpty ? Colors.brown[800] : null,
          border: Border.all(
            color: const Color.fromARGB(255, 62, 39, 35),
            width: 2,
          ),
        ),
        // Jeśli jest puste, nie ma child. Jeśli pełne, pokazujemy obrazek.
        child: isEmpty
            ? null
            : Image.asset(
                image!,
                fit: BoxFit.fill,
              ),
      ),
    );
  }
}

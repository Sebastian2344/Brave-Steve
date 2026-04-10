import 'package:brave_steve/modules/prestige/prestige_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PrestigeScreen extends StatelessWidget {
  const PrestigeScreen({super.key, required this.level});
  final int level;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF301b0a),
        centerTitle: true,
        title: Text('Reset progresu postaci'),
      ),
      body: Center(
        child: Consumer(
          builder: (context, ref, child) {
            final p = ref.watch(prestigeNotifierProvider);
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Zgarnij punkty prestiżu ${(level/3).round()} w zamian za twój poziom $level'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: !p.isGivePoints
                          ? () {
                              ref
                                  .read(prestigeNotifierProvider.notifier)
                                  .givePoints(level);
                            }
                          : null,
                      child: Text('Zgarnij punkty prestiżu'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        ref
                            .read(prestigeNotifierProvider.notifier)
                            .resetPoints(level);
                      },
                      child: Text('Rozdaj jeszcze raz'),
                    ),
                  ],
                ),
                Text('Liczba punków do rozdania: ${p.points}'),
                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                  Text('atak'),
                  Text('${p.attack}'),
                  IconButton(
                      onPressed: () {
                        ref
                            .read(prestigeNotifierProvider.notifier)
                            .incrementAttack();
                      },
                      icon: Icon(Icons.add)),
                  Text('+1')
                ]),
                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                  Text('życie'),
                  Text('${p.health}'),
                  IconButton(
                      onPressed: () {
                        ref
                            .read(prestigeNotifierProvider.notifier)
                            .incrementHealth();
                      },
                      icon: Icon(Icons.add)),
                  Text('+10')
                ]),
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    ref.read(prestigeNotifierProvider.notifier).savePrestige();
                    Navigator.of(context).pop();
                  },
                  child: Text('Reset postaci'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

import 'package:brave_steve/modules/counter_enemy_and_bioms/menagment/counter_enemy_state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BackgroundBattle extends ConsumerWidget {
  const BackgroundBattle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaQuerySize = MediaQuery.of(context).size;
    ref.watch(counterEnemyNotifierProvider.select((counter) => counter.boss));
    return Container(
      height: mediaQuerySize.height / 3,
      width: mediaQuerySize.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(
              ref.read(counterEnemyNotifierProvider.notifier).getMap()),
        ),
      ),
    );
  }
}

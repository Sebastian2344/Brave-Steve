import 'package:brave_steve/game/data_layer/models/counterenemy_model/counter_enemy_model.dart';
import 'package:brave_steve/game/data_layer/repo/counter_enemy_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MapNotifier extends StateNotifier<CounterEnemyModel> {
  MapNotifier(this.counterEnemyRepo) : super(CounterEnemyModel(1,0));
  final CounterEnemyRepo counterEnemyRepo;

  void fromSave(int index){
    state = counterEnemyRepo.getCounterEnemyModel(index);
  }
  
  void incrementEnemy() {
    state = state.copywith(enemyCounter: state.enemyCounter + 1);
    if (state.enemyCounter == 100 || state.enemyCounter == 200 || state.enemyCounter == 300 || state.enemyCounter == 400) {
      state = state.copywith(boss: state.boss + 1);
    }
  }

  void resetEnemyAndBoss() {
    state = state.copywith(enemyCounter: 0, boss: 0);
  }

  String getMap() {
    if (state.boss == 0) {
      return 'assets/images/LandScape.jpg';
    } else if (state.boss == 1) {
      return 'assets/images/złoto.png';
    } else if (state.boss == 2) {
      return 'assets/images/map3.png';
    } else if (state.boss == 3) {
      return 'assets/images/map4.png';
    } else if (state.boss == 4) {
      return 'assets/images/map5.png';
    } else {
      return 'assets/images/map1.png'; // Domyślny obraz, jeśli boss jest poza zakresem
    }
  }
}

final mapNotifierProvider =
    StateNotifierProvider<MapNotifier, CounterEnemyModel>((ref) {
  return MapNotifier(ref.watch(counterEnemyRepoProvider));
});
import 'package:brave_steve/core/di/providers.dart';
import 'package:brave_steve/modules/counter_enemy_and_bioms/model/counter_enemy_model.dart';
import 'package:brave_steve/modules/counter_enemy_and_bioms/repo/counter_enemy_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CounterEnemyNotifier extends Notifier<CounterEnemyModel> {
  CounterEnemyRepo get counterEnemyRepo => ref.read(counterEnemyRepoProvider);

  @override
  build(){
    ref.watch(counterEnemyRepoProvider);
    return CounterEnemyModel(1,0);
  }

  void fromSave(int index){
    state = counterEnemyRepo.getCounterEnemyModel(index);
  }
  
  void incrementEnemy() {
    state = state.copywith(enemyCounter: state.enemyCounter + 1);
    if (isBoss()) {
      state = state.copywith(boss: state.boss + 1);
    }
  }

  void resetEnemyAndBoss() {
    state = state.copywith(enemyCounter: 0, boss: 0);
  }

  bool isBoss() {
    return state.enemyCounter == 100 || state.enemyCounter == 200 || state.enemyCounter == 300 || state.enemyCounter == 400;
  }

  String getMap() {
    if (state.enemyCounter <= 100) {
      return counterEnemyRepo.chooseVariantMap([
        'assets/images/bioms/biom1a.png',
        'assets/images/bioms/biom1b.png',
        'assets/images/bioms/biom1c.png',
      ],state.enemyCounter);
    } else if (state.enemyCounter <= 200) {
      return counterEnemyRepo.chooseVariantMap([
        'assets/images/bioms/biom2a.png',
        'assets/images/bioms/biom2b.png',
        'assets/images/bioms/biom2c.png',
      ],state.enemyCounter);
    } else if (state.enemyCounter <= 300) {
      return counterEnemyRepo.chooseVariantMap([
        'assets/images/bioms/biom3a.png',
        'assets/images/bioms/biom3b.png',
        'assets/images/bioms/biom3c.png',
      ],state.enemyCounter);
    } else if (state.enemyCounter <= 400) {
      return counterEnemyRepo.chooseVariantMap([
        'assets/images/bioms/biom4a.png',
        'assets/images/bioms/biom4b.png',
        'assets/images/bioms/biom4c.png',
      ],state.enemyCounter);
    } else {
      return 'assets/images/bioms/biom1a.png'; // Domyślny obraz, jeśli boss jest poza zakresem
    }
  }
}

final counterEnemyNotifierProvider =
    NotifierProvider<CounterEnemyNotifier, CounterEnemyModel>(() {
  return CounterEnemyNotifier();
});
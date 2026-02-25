import 'package:brave_steve/game/data_layer/models/counterenemy_model/counter_enemy_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'counter_enemy.g.dart';

@HiveType(typeId: 6)
class CounterEnemy {
  @HiveField(0)
  final int enemy;
  @HiveField(1)
  final int boss;

  const CounterEnemy({this.enemy = 0, this.boss = 0});

  CounterEnemyModel toCounterEnemyModel() {
    return CounterEnemyModel(enemy, boss);
  }

  static CounterEnemy toCounterEnemy(CounterEnemyModel model) {
    return CounterEnemy(enemy:model.enemyCounter, boss: model.boss);
  }
}
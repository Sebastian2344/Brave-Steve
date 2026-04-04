import 'package:brave_steve/core/modules/data_source/box.dart';
import 'package:brave_steve/modules/counter_enemy_and_bioms/model/counter_enemy_model.dart';

class CounterEnemyRepo {
  CounterEnemyRepo(this.dataSource);
  final DataBox dataSource;

  CounterEnemyModel getCounterEnemyModel(int index){
    return dataSource.getCounerEnemy(index).toCounterEnemyModel();
  }
}
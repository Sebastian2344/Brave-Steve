import 'package:brave_steve/game/data_layer/data_source/data_box/box.dart';
import 'package:brave_steve/game/data_layer/models/counterenemy_model/counter_enemy_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CounterEnemyRepo {
  CounterEnemyRepo(this.dataSource);
  final DataBox dataSource;

  CounterEnemyModel getCounterEnemyModel(int index){
    return dataSource.getCounerEnemy(index).toCounterEnemyModel();
  }
}

final counterEnemyRepoProvider = Provider((ref)=> CounterEnemyRepo( ref.watch(dataBoxProvider)));
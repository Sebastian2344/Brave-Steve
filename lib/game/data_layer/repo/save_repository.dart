import 'package:brave_steve/game/data_layer/data_source/counter_enemy/counter_enemy.dart';
import 'package:brave_steve/game/data_layer/data_source/data_box/box.dart';
import 'package:brave_steve/game/data_layer/data_source/eq/eq.dart';
import 'package:brave_steve/game/data_layer/data_source/player/player.dart';
import 'package:brave_steve/game/data_layer/data_source/save/save.dart';
import 'package:brave_steve/game/data_layer/models/counter_enemy_model/counter_enemy_model.dart';
import 'package:brave_steve/game/data_layer/models/eq_model/eq_model.dart';
import 'package:brave_steve/game/data_layer/models/player_model/player_model.dart';
import 'package:brave_steve/game/data_layer/models/save_model/save_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SaveRepository {
  final DataBox dataSource;
  const SaveRepository({required this.dataSource});

  Future<void> addSaveGame(List<PlayerModel> list,String name,List<ItemPlaceModel> itemPlace,CounterEnemyModel e,double expMultiply) async {
    await dataSource.addSaveGame(Player.toPlayer(list),name,ItemPlace.toItemPlace(itemPlace),CounterEnemy.toCounterEnemy(e),expMultiply);
  }

  List<SaveModel> returnListSaves(){
    List<Save> saveList = dataSource.returnList();
    return saveList.map((e) => e.toSaveModel()).toList();
  }

  void removeSave(int index){
    dataSource.removeSave(index);
  }
}

final saveRepositoryProvider = Provider<SaveRepository>((ref) => SaveRepository(dataSource: ref.watch(dataBoxProvider)));
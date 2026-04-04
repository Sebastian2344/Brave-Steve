import 'package:brave_steve/modules/counter_enemy_and_bioms/db_model/counter_enemy.dart';
import 'package:brave_steve/core/modules/data_source/box.dart';
import 'package:brave_steve/modules/eq/db_model/eq.dart';
import 'package:brave_steve/modules/game/db_model/player.dart';
import 'package:brave_steve/modules/save_game/db_model/save.dart';
import 'package:brave_steve/modules/counter_enemy_and_bioms/model/counter_enemy_model.dart';
import 'package:brave_steve/modules/eq/model/eq_model.dart';
import 'package:brave_steve/modules/game/model/player_model.dart';
import 'package:brave_steve/modules/save_game/model/save_model.dart';

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
import 'package:brave_steve/game/data_layer/data_source/counter_enemy/counter_enemy.dart';
import 'package:brave_steve/game/data_layer/data_source/data_box/box.dart';
import 'package:brave_steve/game/data_layer/models/counterenemy_model/counter_enemy_model.dart';
import 'package:brave_steve/game/data_layer/models/player_model/player_model.dart';
import 'package:brave_steve/game/data_layer/models/save_model/save_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data_source/eq/eq.dart';
import '../data_source/player/player.dart';
import '../models/eq_model/eq_model.dart';
import '../data_source/save/save.dart';

class RepositoryGame{
  final DataBox dataSource;
  const RepositoryGame({required this.dataSource});
  Future<List<PlayerModel>> listPlayerToListPlayerModel() async {
    final List<Player> players = await dataSource.putPlayers();
    List<PlayerModel> playersInModel = players.map((e) => e.toPlayerModel()).toList();
    return playersInModel;
  }

  List<PlayerModel> getPlayersfromDBasPlayerModelList(int index){
   final List<Player> players = dataSource.getPlayersfromDB(index);
   final List<PlayerModel> playersInModel = players.map((e) => e.toPlayerModel()).toList();
   return playersInModel;
  }

  List<PlayerModel> playersStartStatsasPlayerModelList(){
   return dataSource.playersStartStats.map((e) => e.toPlayerModel()).toList();
  }

  double loadExpMultiple(int index){
    return dataSource.loadExpMultiple(index);
  }

  Future<void> addSaveGame(List<PlayerModel> list,String name,List<ItemPlaceModel> itemPlace,CounterEnemyModel e,double expMultiply) async {
    await dataSource.addSaveGame(Player.toPlayer(list),name,ItemPlace.toItemPlace(itemPlace),CounterEnemy.toCounterEnemy(e),expMultiply);
  }

    Future<void> closeGameDB() async {
    await dataSource.closeDB();
  }

  Future<void> openGameDB() async {
    await dataSource.initThis();
  }

  List<SaveModel> returnListSaves(){
    List<Save> saveList = dataSource.returnList();
    return saveList.map((e) => e.toSaveModel()).toList();
  }

  void removeSave(int index){
    dataSource.removeSave(index);
  }
}

final repoProvider = Provider((ref) => RepositoryGame(dataSource: ref.watch(dataBoxProvider)));
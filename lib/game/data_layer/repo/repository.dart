import 'package:brave_steve/game/data_layer/data_source/box.dart';
import 'package:brave_steve/game/data_layer/models/player_model/player_model.dart';
import 'package:brave_steve/game/data_layer/models/save_model/save_model.dart';

import '../models/player/player.dart';
import '../models/save/save.dart';

class RepositoryGame{

  Future<List<PlayerModel>> listPlayerToListPlayerModel() async {
    return await PlayerBox.putPlayers().then((value) => value.map((e) => e.toPlayerModel()).toList());
  }

  List<PlayerModel> getPlayersfromDBasPlayerModelList(int index){
   return  PlayerBox.getPlayersfromDB(index).map((e) => e.toPlayerModel()).toList();
  }

  List<PlayerModel> playersStartStatsasPlayerModelList(){
   return PlayerBox.playersStartStats().map((e) => e.toPlayerModel()).toList();
  }

  Future<void> addSaveGame(List<PlayerModel> list,String name) async {
    await PlayerBox.addSaveGame(Player.toPlayer(list),name);
  }

    Future<void> closeGameDB() async {
    await PlayerBox.closeDB();
  }

  Future<void> openGameDB() async {
    await PlayerBox.initThis();
  }

  List<SaveModel> returnListSaves(){
    List<Save?> saveList = PlayerBox.returnList();
    return saveList.map((e) => e!.toSaveModel()).toList();
  }

  void removeSave(int index){
    PlayerBox.removeSave(index);
  }
  
}
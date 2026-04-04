import 'package:brave_steve/core/modules/data_source/box.dart';
import 'package:brave_steve/modules/game/model/player_model.dart';
import '../db_model/player.dart';

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
}
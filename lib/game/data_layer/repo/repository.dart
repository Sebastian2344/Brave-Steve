import 'package:brave_steve/game/data_layer/data_source/data_box/box.dart';
import 'package:brave_steve/game/data_layer/models/player_model/player_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data_source/player/player.dart';

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

    Future<void> closeGameDB() async {
    await dataSource.closeDB();
  }

  Future<void> openGameDB() async {
    await dataSource.initThis();
  }
}

final repoProvider = Provider((ref) => RepositoryGame(dataSource: ref.watch(dataBoxProvider)));
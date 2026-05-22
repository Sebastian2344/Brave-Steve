import 'package:brave_steve/core/modules/data_source/box.dart';
import 'package:brave_steve/modules/game/model/player_model.dart';
import 'package:brave_steve/modules/prestige/prestige_data.dart';
import '../db_model/player.dart';

class RepositoryGame{
  final DataBox dataSource;
  final PrestigeData prestigeData;
  const RepositoryGame({required this.dataSource, required this.prestigeData});

  List<PlayerModel> getPlayersfromDBasPlayerModelList(int index){
   final List<Player> players = dataSource.getPlayersfromDB(index);
   final List<PlayerModel> playersInModel = players.map((e) => e.toPlayerModel()).toList();
   return playersInModel;
  }

  List<PlayerModel> playersStartStatsasPlayerModelList(){
    List<PlayerModel> basePlayers = dataSource.playersStartStats.map((e) => e.toPlayerModel()).toList(); 

    // 2. Odczytujemy permanentne bonusy bezpośrednio z bazy Hive prestiżu
    // (jeśli baza jest pusta, domyślnie dajemy 0)
    final data = prestigeData.getData();
    final bonusAttack = data.attack;
    final bonusHealth = data.health;
    final bonusLucky = data.lucky;

    // 3. Aplikujemy bonusy prestiżu do głównego bohatera (pierwszego na liście)
    final hero = basePlayers[0];
    hero.setAttack = bonusAttack + hero.getMaxAttack();
    hero.setHp = bonusHealth + hero.showHp();
    hero.setMaxHp = hero.showHp();
    hero.setMaxAttack = bonusAttack + hero.getMaxAttack();
    hero.setLucky = bonusLucky + hero.showLucky();

   return basePlayers;
  }

  double loadExpMultiple(int index){
    return dataSource.loadExpMultiple(index);
  }
}
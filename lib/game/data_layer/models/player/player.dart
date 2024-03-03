import 'package:brave_steve/game/data_layer/models/player_model/player_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'player.g.dart';

@HiveType(typeId: 1)
class Player extends HiveObject{
  @HiveField(0)
  final String name;
  @HiveField(1)
  final double hp;
  @HiveField(2)
  final double maxHp;
  @HiveField(3)
  final double attack;
  @HiveField(4)
  final double mana;
  @HiveField(5)
  final double exp;
  @HiveField(6)
  final int lvl;
  @HiveField(7)
  final bool weak;
  @HiveField(8)
  final int? enemyIndex;
  @HiveField(9)
  final int damageReduction;

   Player({ required this.name,required this.hp, required this.maxHp, required this.attack, required this.mana, required this.exp, required this.lvl, required this.weak, this.enemyIndex, required this.damageReduction});

   static List<Player> toPlayer(List<PlayerModel> model){
    List <Player> playersList = [];
    int i = 0;
    while(playersList.length < model.length){
      playersList.add(Player(name:model[i].name,hp: model[i].showHp().toDouble(),maxHp: model[i].maxHpInfo().toDouble(),attack: model[i].showAttack().toDouble(),mana: model[i].showMana().toDouble(),exp: model[i].showExp().toDouble(),lvl: model[i].getlvl(),weak: model[i].isWeak(),enemyIndex: model[i].getEnemyIndex(),damageReduction: model[i].damageReduction()));
      i++;
    }
    return playersList;
  }

  PlayerModel toPlayerModel(){
  return PlayerModel(name, hp,maxHp, attack, mana, exp, lvl, weak, enemyIndex,damageReduction);
 }

}

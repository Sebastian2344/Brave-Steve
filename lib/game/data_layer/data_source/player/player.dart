import 'package:brave_steve/game/data_layer/models/player_model/enemy.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../models/player_model/player_model.dart';
import '../../models/player_model/steve.dart';
part 'player.g.dart';

@HiveType(typeId: 1)
class Player {
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
  final double armour;
  @HiveField(7)
  final double maxArmour;
  @HiveField(8)
  final int lvl;
  @HiveField(9)
  final bool weak;
  @HiveField(10)
  final int? enemyIndex;
  @HiveField(11)
  final double maxAttack;
  const Player({required this.name, required this.hp, required this.maxHp, required this.attack, required this.maxAttack,
      required this.mana, required this.exp, required this.armour,required this.maxArmour,required this.lvl, required this.weak,this.enemyIndex});

  static List<Player> toPlayer(List<PlayerModel> model) {
    List<Player> playersList = [];
    for(int i = 0; i < model.length; i++){
      playersList.add(Player(
          name: model[i].getName(),
          hp: model[i].showHp(),
          maxHp: model[i].maxHpInfo(),
          attack: model[i].showAttack(),
          maxAttack: model[i].getMaxAttack(),
          mana: model[i].showMana(),
          exp: model[i].showExp().toDouble(),
          armour: model[i].getArmour(),
          maxArmour: model[i].getArmour(),
          lvl: model[i].getlvl(), 
          weak: model[i].isWeak(),
          enemyIndex: model[i] == model.first? (model[i] as Steve).getEnemyIndex():null)
        );
    }
    return playersList;
  }

  PlayerModel toPlayerModel() {
    if(enemyIndex != null){
      return Steve(name, hp, maxHp, attack, maxAttack, mana, exp, armour, maxArmour, lvl, weak, enemyIndex);
    }else{
      return Enemy(name, hp, maxHp, attack, maxAttack, mana, exp, armour, maxArmour, lvl, weak);
    }    
  }
}

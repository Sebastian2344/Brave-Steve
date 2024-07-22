import 'package:brave_steve/game/data_layer/models/player_model/enemy.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../models/player_model/player_model.dart';
import '../../models/player_model/steve.dart';
part 'player.g.dart';

@HiveType(typeId: 1)
class Player extends HiveObject {
  @HiveField(0)
  final String _name;
  @HiveField(1)
  final double _hp;
  @HiveField(2)
  final double _maxHp;
  @HiveField(3)
  final double _attack;
  @HiveField(4)
  final double _mana;
  @HiveField(5)
  final double _exp;
  @HiveField(6)
  final double _armour;
  @HiveField(7)
  final double _maxArmour;
  @HiveField(8)
  final int _lvl;
  @HiveField(9)
  final bool _weak;
  @HiveField(10)
  final int? _enemyIndex;
  @HiveField(11)
  final double _maxAttack;
 Player(this._name, this._hp, this._maxHp, this._attack, this._maxAttack,
      this._mana, this._exp, this._armour,this._maxArmour,this._lvl, this._weak, 
      [this._enemyIndex]);

  static List<Player> toPlayer(List<PlayerModel> model) {
    List<Player> playersList = [];
    for(int i = 0; i < model.length; i++){
      playersList.add(Player(
          model[i].getName(),
          model[i].showHp(),
          model[i].maxHpInfo(),
          model[i].showAttack(),
          model[i].getMaxAttack(),
          model[i].showMana(),
          model[i].showExp().toDouble(),
          model[i].getArmour(),
          model[i].getArmour(),
          model[i].getlvl(), 
          model[i].isWeak(),
          model[i] == model.first? (model[i] as Steve).getEnemyIndex():null)
        );
    }
    return playersList;
  }

  PlayerModel toPlayerModel() {
    if(_enemyIndex != null){
      return Steve(_name, _hp, _maxHp, _attack, _maxAttack,_mana,_exp,_armour,_maxArmour,_lvl, _weak,_enemyIndex);
    }else{
      return Enemy(_name, _hp, _maxHp, _attack, _maxAttack, _mana, _exp,_armour,_maxArmour, _lvl,_weak);
    }    
  }
}

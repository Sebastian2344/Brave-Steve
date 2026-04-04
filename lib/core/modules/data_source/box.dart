import 'package:brave_steve/modules/counter_enemy_and_bioms/db_model/counter_enemy.dart';
import 'package:brave_steve/modules/eq/db_model/eq.dart';
import 'package:brave_steve/modules/game/db_model/player.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../modules/save_game/db_model/save.dart';

class DataBox {
  
  List<Player> get playersStartStats{
    return[
      Player(name:'Rycerz', hp: 200, maxHp: 200, attack: 150, maxAttack: 150, mana: 10, exp: 0, armour: 0, maxArmour: 0, lvl: 1, weak: false, enemyIndex: 1), // My hero has got enemyIndex
      Player(name:'Szczur', hp :180 ,maxHp :180 ,attack :14 ,maxAttack :14 ,mana :10 ,exp :0 ,armour :0 ,maxArmour :0 ,lvl :1 ,weak:false,), //enemy
      Player(name:'Nietoperz', hp :190 ,maxHp :190 ,attack :13 ,maxAttack :13 ,mana :10 ,exp :0 ,armour :0,maxArmour :0,lvl : 1, weak: false),//enemy
      Player(name:'Pies', hp :170 ,maxHp :170 ,attack :15 ,maxAttack :15 ,mana :10 ,exp :0 ,armour :0 ,maxArmour :0 ,lvl :1 ,weak:false,), //enemy
      Player(name:'Ghul', hp :170 ,maxHp :170 ,attack :15 ,maxAttack :15 ,mana :10 ,exp :0 ,armour :0 ,maxArmour :0 ,lvl :1 ,weak:false,), //enemy
      Player(name:'Duch', hp :170 ,maxHp :170 ,attack :15 ,maxAttack :15 ,mana :10 ,exp :0 ,armour :0 ,maxArmour :0 ,lvl :1 ,weak:false,), //enemy
      Player(name:'Kostucha', hp: 150, maxHp: 150, attack: 17, maxAttack: 17, mana: 10, exp: 0, armour: 0, maxArmour: 0, lvl: 1, weak: false,), //enemy hasnot enemy index
      Player(name:'Szkielet', hp: 160, maxHp: 160, attack: 16, maxAttack: 16, mana: 10, exp: 0, armour: 0, maxArmour: 0, lvl: 1 ,weak:false,), //enemy
      Player(name:'Zombie', hp :170 ,maxHp :170 ,attack :15 ,maxAttack :15 ,mana :10 ,exp :0 ,armour :0 ,maxArmour :0 ,lvl :1 ,weak:false,), //enemy
      Player(name:'Wampir', hp :170 ,maxHp :170 ,attack :15 ,maxAttack :15 ,mana :10 ,exp :0 ,armour :0 ,maxArmour :0 ,lvl :1 ,weak:false,), //enemy
      Player(name:'Nekromanta', hp :170 ,maxHp :170 ,attack :15 ,maxAttack :15 ,mana :10 ,exp :0 ,armour :0 ,maxArmour :0 ,lvl :1 ,weak:false,), //enemy
      Player(name:'Wilkołak', hp :170,maxHp :320,attack :18,maxAttack :18,mana :10,exp :0,armour :0,maxArmour :0,lvl : 1, weak: false),//enemy
      Player(name:'Smok', hp :180 ,maxHp :180 ,attack :17 ,maxAttack :17 ,mana :10 ,exp :0 ,armour :0,maxArmour: 0,lvl: 1, weak: false), //enemy
    ];
  }

  List<Player> getPlayersfromDB(int index) {
    List<Player> listPlayersToReturn = playersStartStats;
    Save? save = Hive.box<Save>('saveBox').getAt(index);
    listPlayersToReturn = save?.list ?? listPlayersToReturn;
    return listPlayersToReturn;
  }

  Future<List<Player>> putPlayers() async {
    List<Player> toSetState = playersStartStats;
    return toSetState;
  }

  Future<void> addSaveGame(
      List<Player> listPlayers, String name, List<ItemPlace> itemPlace,CounterEnemy enemy,double expMulti) async {
    await Hive.box<Save>('saveBox')
        .add(Save(list: listPlayers, name: name, itemPlace: itemPlace,enemyCounter: enemy,expMultiply:expMulti));
  }

  void removeSave(int index) async {
    await Hive.box<Save>('saveBox').deleteAt(index);
  }

  List<Save> returnList() {
    List<Save> saveList = Hive.box<Save>('saveBox').values.toList();
    return saveList;
  }

  List<ItemPlace> getItemPlacesFromDB(int index){
    return Hive.box<Save>('saveBox').values.elementAt(index).itemPlace;
  }

  CounterEnemy getCounerEnemy(int index){
    return Hive.box<Save>('saveBox').values.elementAt(index).enemyCounter;
  }

  double loadExpMultiple(int index){
    return Hive.box<Save>('saveBox').values.elementAt(index).expMultiply;
  }
}
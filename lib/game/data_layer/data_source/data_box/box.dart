import 'package:brave_steve/game/data_layer/data_source/counter_enemy/counter_enemy.dart';
import 'package:brave_steve/game/data_layer/data_source/eq/eq.dart';
import 'package:brave_steve/game/data_layer/data_source/player/player.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../save/save.dart';

class DataBox {
  late Box<Save> _boxData;

  Future<void> initThis() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(SaveAdapter());
      Hive.registerAdapter(PlayerAdapter());
      Hive.registerAdapter(ItemPlaceAdapter());
      Hive.registerAdapter(ItemAdapter());
      Hive.registerAdapter(FieldTypeAdapter());
      Hive.registerAdapter(ItemTypeAdapter());
      Hive.registerAdapter(CounterEnemyAdapter());
    }
    if (!Hive.isBoxOpen('saveBox')) {
      _boxData = await Hive.openBox<Save>('saveBox');
    }
  }
 
  List<Player> get playersStartStats{
    return[
      Player(name:'Rycerz', hp: 200, maxHp: 200, attack: 15, maxAttack: 15, mana: 10, exp: 0, armour: 0, maxArmour: 0, lvl: 1, weak: false, enemyIndex: 1), // My hero has got enemyIndex
      Player(name:'Kostucha', hp: 150, maxHp: 150, attack: 17, maxAttack: 17, mana: 10, exp: 0, armour: 0, maxArmour: 0, lvl: 1, weak: false,), //enemy hasnot enemy index
      Player(name:'Szkielet', hp: 160, maxHp: 160, attack: 16, maxAttack: 16, mana: 10, exp: 0, armour: 0, maxArmour: 0, lvl: 1 ,weak:false,), //enemy
      Player(name:'Wampir', hp :170 ,maxHp :170 ,attack :15 ,maxAttack :15 ,mana :10 ,exp :0 ,armour :0 ,maxArmour :0 ,lvl :1 ,weak:false,), //enemy
      Player(name:'Szczur', hp :180 ,maxHp :180 ,attack :14 ,maxAttack :14 ,mana :10 ,exp :0 ,armour :0 ,maxArmour :0 ,lvl :1 ,weak:false,), //enemy
      Player(name:'Nietoperz', hp :190 ,maxHp :190 ,attack :13 ,maxAttack :13 ,mana :10 ,exp :0 ,armour :0,maxArmour :0,lvl : 1, weak: false),
      Player(name:'Wilkołak', hp :320,maxHp :320,attack :23,maxAttack :23,mana :10,exp :0,armour :40,maxArmour :40,lvl : 5, weak: false),
      Player(name:'Smok', hp :450 ,maxHp :450 ,attack :35 ,maxAttack :35 ,mana :10 ,exp :0 ,armour :60,maxArmour: 60,lvl: 10, weak: false), //enemy
    ];
  }

  List<Player> getPlayersfromDB(int index) {
    List<Player> listPlayersToReturn = playersStartStats;
    Save? save = _boxData.getAt(index);
    listPlayersToReturn = save?.list ?? listPlayersToReturn;
    return listPlayersToReturn;
  }

  Future<List<Player>> putPlayers() async {
    List<Player> toSetState = playersStartStats;
    return toSetState;
  }

  Future<void> closeDB() async {
    await Hive.close();
  }

  Future<void> addSaveGame(
      List<Player> listPlayers, String name, List<ItemPlace> itemPlace,CounterEnemy enemy,double expMulti) async {
    await _boxData
        .add(Save(list: listPlayers, name: name, itemPlace: itemPlace,enemyCounter: enemy,expMultiply:expMulti));
  }

  void removeSave(int index) async {
    await _boxData.deleteAt(index);
  }

  List<Save> returnList() {
    List<Save> saveList = _boxData.values.toList();
    return saveList;
  }

  List<ItemPlace> getItemPlacesFromDB(int index){
    return _boxData.values.elementAt(index).itemPlace;
  }

  CounterEnemy getCounerEnemy(int index){
    return _boxData.values.elementAt(index).enemyCounter;
  }

  double loadExpMultiple(int index){
    return _boxData.values.elementAt(index).expMultiply;
  }
}

Provider<DataBox> dataBoxProvider = Provider((ref) => DataBox());
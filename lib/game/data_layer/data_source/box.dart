import 'package:hive_flutter/hive_flutter.dart';
import '../models/player/player.dart';
import '../models/save/save.dart';

class PlayerBox {
  static late Box<Save> _boxPlayer;
  static const int numbersPlayers = 6;

  static Future<void> initThis() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(SaveAdapter());
      Hive.registerAdapter(PlayerAdapter());
    }
    if(!Hive.isBoxOpen('saveBox')){
      _boxPlayer = await Hive.openBox<Save>('saveBox');
    }
  }
  static const List<String> playerNames = ['Steve','Zombie','Spider','Skeleton','Creeper','Pigman','Diamond Zombie']; 
  static List<Player> playersStartStats() {
    return [
      Player(name:playerNames[0],hp: 100,maxHp:100,attack:7,mana:10,exp:0,lvl: 1,weak: false,enemyIndex: 1,damageReduction: 0),// My hero
      Player(name:playerNames[1],hp: 100,maxHp:100,attack:7,mana:10,exp:0,lvl: 1,weak:false,enemyIndex:null,damageReduction:0),//enemy
      Player(name:playerNames[2],hp: 100,maxHp:100,attack:7,mana:10,exp:0,lvl: 1,weak:false,enemyIndex:null,damageReduction:0),//enemy
      Player(name:playerNames[3],hp: 100,maxHp:100,attack:7,mana:10,exp:0,lvl: 1,weak:false,enemyIndex:null,damageReduction:0),//enemy
      Player(name:playerNames[4],hp: 100,maxHp:100,attack:7,mana:10,exp:0,lvl: 1,weak:false,enemyIndex:null,damageReduction:0),//enemy
      Player(name:playerNames[5],hp: 220,maxHp:220,attack:17,mana:10,exp:0,lvl: 5,weak:false,enemyIndex:null,damageReduction:0),//enemy
      Player(name:playerNames[6],hp: 400,maxHp:400,attack:27,mana:10,exp:0, lvl:10,weak:false,enemyIndex:null,damageReduction:0),//enemy
    ];
  }

static List<Player> getPlayersfromDB(int index) {
  List<Player> listPlayersToReturn = playersStartStats();
  Save? save = _boxPlayer.getAt(index);
  listPlayersToReturn = save?.list?? listPlayersToReturn;
  return listPlayersToReturn;
}

  static Future<List<Player>> putPlayers() async {
    List<Player> toSetState = playersStartStats();
    return toSetState;
  }

  static Future<void> closeDB() async {
    await Hive.close();
  }

  static Future<void> addSaveGame(List<Player> listPlayers,String name) async {
   await _boxPlayer.add(Save(list: listPlayers,name: name));
  }

  static void removeSave(int index) async {
    await _boxPlayer.deleteAt(index);
  }

  static List<Save?> returnList(){
    List<Save?> saveList = _boxPlayer.values.toList();
    return saveList; 
  }
}

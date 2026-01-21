import 'package:brave_steve/game/data_layer/data_source/eq/eq.dart';
import 'package:brave_steve/game/data_layer/data_source/player/player.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../models/eq_model/eq_model.dart';
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
    }
    if (!Hive.isBoxOpen('saveBox')) {
      _boxData = await Hive.openBox<Save>('saveBox');
    }
  }
 
  List<Player> get playersStartStats{
    return[
      Player(name: 'Steve', hp: 200, maxHp: 200, attack: 140, maxAttack: 140, mana: 10, exp: 0, armour: 0, maxArmour: 0, lvl: 1, weak: false, enemyIndex: 1), // My hero has got enemyIndex
      Player(name:'Kostucha', hp: 150, maxHp: 150, attack: 17, maxAttack: 17, mana: 10, exp: 0, armour: 0, maxArmour: 0, lvl: 1, weak: false,), //enemy hasnot enemy index
      Player(name:'Szkielet', hp: 160, maxHp: 160, attack: 16, maxAttack: 16, mana: 10, exp: 0, armour: 0, maxArmour: 0, lvl: 1 ,weak:false,), //enemy
      Player(name:'Wampir', hp :170 ,maxHp :170 ,attack :15 ,maxAttack :15 ,mana :10 ,exp :0 ,armour :0 ,maxArmour :0 ,lvl :1 ,weak:false,), //enemy
      Player(name:'Szczur', hp :180 ,maxHp :180 ,attack :14 ,maxAttack :14 ,mana :10 ,exp :0 ,armour :0 ,maxArmour :0 ,lvl :1 ,weak:false,), //enemy
      Player(name:'Nietoperz', hp :190 ,maxHp :190 ,attack :13 ,maxAttack :13 ,mana :10 ,exp :0 ,armour :0,maxArmour :0,lvl : 1, weak: false),
      Player(name:'Wilkołak', hp :320,maxHp :320,attack :23,maxAttack :23,mana :10,exp :0,armour :40,maxArmour :40,lvl : 5, weak: false),
      Player(name:'Smok', hp :450 ,maxHp :450 ,attack :35 ,maxAttack :35 ,mana :10 ,exp :0 ,armour :60,maxArmour: 60,lvl: 10, weak: false), //enemy
    ];
  }
    
  static const List<List<ItemModel>> _listItems = [
    [
      ItemModel(
          name: 'Drewniany Miecz',
          description: 'Dodaje 4 do ataku',
          image: 'assets/images/wodden_sword.png',
          statValue: 4,
          classItem: ItemTypeModel.sword,
          price: 10),
      ItemModel(
          name: 'Kamienny Miecz',
          description: 'Dodaje 5 do ataku',
          image: 'assets/images/stone_sword.png',
          statValue: 5,
          classItem: ItemTypeModel.sword,
          price: 15),
      ItemModel(
          name: 'Żelazny miecz',
          description: 'Dodaje 6 do ataku',
          image: 'assets/images/iron_sword.png',
          statValue: 6,
          classItem: ItemTypeModel.sword,
          price: 20),
      ItemModel(
          name: 'Diamentowy Miecz',
          description: 'Dodaje 7 do ataku',
          image: 'assets/images/diamond_sword.png',
          statValue: 7,
          classItem: ItemTypeModel.sword,
          price: 25),
    ],
    [
      ItemModel(
          name: 'Skórzany Chełm',
          description: 'Dodaje 3 pancerza',
          image: 'assets/images/brown_helmet.png',
          statValue: 3,
          classItem: ItemTypeModel.helmet,
          price: 10),
      ItemModel(
          name: 'Kolczy Chełm',
          description: 'Dodaje 5 pancerza',
          image: 'assets/images/two_colors_helmet.png',
          statValue: 5,
          classItem: ItemTypeModel.helmet,
          price: 15),
      ItemModel(
          name: 'Żelazny Chełm',
          description: 'Dodaje 7 pancerza',
          image: 'assets/images/silver_helmet.png',
          statValue: 7,
          classItem: ItemTypeModel.helmet,
          price: 20),
      ItemModel(
          name: 'Diamentowy Chełm',
          description: 'Dodaje 9 pancerza',
          image: 'assets/images/blue_helmet.png',
          statValue: 9,
          classItem: ItemTypeModel.helmet,
          price: 25),
    ],
    [
      ItemModel(
          name: 'Skórzany Napierśnik',
          description: 'Dodaje 8 pancerza',
          image: 'assets/images/brown_chestplate.png',
          statValue: 8,
          classItem: ItemTypeModel.chestplate,
          price: 10),
          ItemModel(
          name: 'Kolczy Napierśnik',
          description: 'Dodaje 10 pancerza',
          image: 'assets/images/two_colors_chestplate.png',
          statValue: 10,
          classItem: ItemTypeModel.chestplate,
          price: 15),
          ItemModel(
          name: 'Żelazny Napierśnik',
          description: 'Dodaje 12 pancerza',
          image: 'assets/images/silver_chestplate.png',
          statValue: 12,
          classItem: ItemTypeModel.chestplate,
          price: 20),
          ItemModel(
          name: 'Diamentowy Napierśnik',
          description: 'Dodaje 14 pancerza',
          image: 'assets/images/blue_chestplate.png',
          statValue: 14,
          classItem: ItemTypeModel.chestplate,
          price: 25),
    ],
    [
      ItemModel(
          name: 'Skórzane Spodnie',
          description: 'Dodają 4 pancerza',
          image: 'assets/images/brown_pants.png',
          statValue: 4,
          classItem: ItemTypeModel.pants,
          price: 10),
       ItemModel(
          name: 'Kolcze Spodnie',
          description: 'Dodają 6 pancerza',
          image: 'assets/images/two_colors_pants.png',
          statValue: 6,
          classItem: ItemTypeModel.pants,
          price: 15),
       ItemModel(
          name: 'Żelazne Spodnie',
          description: 'Dodają 8 pancerza',
          image: 'assets/images/silver_pants.png',
          statValue: 8,
          classItem: ItemTypeModel.pants,
          price: 20),
       ItemModel(
          name: 'Diamentowe Spodnie',
          description: 'Dodają 10 pancerza',
          image: 'assets/images/blue_pants.png',
          statValue: 10,
          classItem: ItemTypeModel.pants,
          price: 25),
    ],
    [
      ItemModel(
          name: 'Skórzane Buty',
          description: 'Dodają 1 pancerza',
          image: 'assets/images/1024px_items/buty_3_na_3/Nowy_folder/b1.jpg',
          statValue: 1,
          classItem: ItemTypeModel.boots,
          price: 10),
      ItemModel(
          name: 'Kolcze Buty',
          description: 'Dodają 3 pancerza',
          image: 'assets/images/two_colors_boots.png',
          statValue: 3,
          classItem: ItemTypeModel.boots,
          price: 15),
      ItemModel(
          name: 'Żelazne Buty',
          description: 'Dodają 5 pancerza',
          image: 'assets/images/silver_boots.png',
          statValue: 5,
          classItem: ItemTypeModel.boots,
          price: 20),
      ItemModel(
          name: 'Diamentowe Buty',
          description: 'Dodają 7 pancerza',
          image: 'assets/images/blue_boots.png',
          statValue: 7,
          classItem: ItemTypeModel.boots,
          price: 25),
    ]
  ];

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
      List<Player> listPlayers, String name, List<ItemPlace> itemPlace) async {
    await _boxData
        .add(Save(list: listPlayers, name: name, itemPlace: itemPlace));
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

  ItemModel getItem(int listIndex,int itemIndex) {
    return _listItems.elementAt(listIndex).elementAt(itemIndex);
  }
}

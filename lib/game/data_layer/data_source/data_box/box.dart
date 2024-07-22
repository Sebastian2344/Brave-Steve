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
      Player('Steve', 200, 200, 14, 14, 10, 0, 0,0, 1, false,1), // My hero has got enemyIndex
      Player('Zombie', 150, 150, 17, 17, 10, 0, 0,0, 1, false,), //enemy hasnot enemy index
      Player('Spider', 160, 160, 16, 16, 10, 0, 0,0, 1, false,), //enemy
      Player('Skeleton', 170, 170, 15, 15, 10, 0, 0,0, 1, false,), //enemy
      Player('Creeper', 180, 180, 14, 14, 10, 0, 0,0, 1, false,), //enemy
      Player('Enderman', 190, 190, 13, 13, 10, 0, 0,0, 1, false,), //enemy
      Player('Pigman', 320, 320, 23, 23, 10, 0, 20,20, 5, false,), //enemy
      Player('Diamond Zombie', 450, 450, 35, 35, 10, 0, 40,40, 10, false,), //enemy
    ];
  }
    
  static const List<List<ItemModel>> _listItems = [
    [
      ItemModel(
          'Drewniany Miecz',
          'Dodaje 4 do ataku',
          'assets/images/wodden_sword.png',
          4,
          ItemTypeModel.sword),
      ItemModel(
          'Kamienny Miecz',
          'Dodaje 5 do ataku',
          'assets/images/stone_sword.png',
          5,
          ItemTypeModel.sword),
      ItemModel(
          'Żelazny miecz',
          'Dodaje 6 do ataku',
          'assets/images/iron_sword.png',
          6,
          ItemTypeModel.sword),
      ItemModel(
          'Diamentowy Miecz',
          'Dodaje 7 do ataku',
          'assets/images/diamond_sword.png',
          7,
          ItemTypeModel.sword),
    ],
    [
      ItemModel(
          'Skórzany Chełm',
          'Dodaje 3 pancerza',
          'assets/images/brown_helmet.png',
          3,
          ItemTypeModel.helmet),
      ItemModel(
          'Kolczy Chełm',
          'Dodaje 5 pancerza',
          'assets/images/two_colors_helmet.png',
          5,
          ItemTypeModel.helmet),
      ItemModel(
          'Żelazny Chełm',
          'Dodaje 7 pancerza',
          'assets/images/silver_helmet.png',
          7,
          ItemTypeModel.helmet),
      ItemModel(
          'Diamentowy Chełm',
          'Dodaje 9 pancerza',
          'assets/images/blue_helmet.png',
          9,
          ItemTypeModel.helmet),
    ],
    [
      ItemModel(
          'Skórzany Napierśnik',
          'Dodaje 8 pancerza',
          'assets/images/brown_chestplate.png',
          8,
          ItemTypeModel.chestplate),
          ItemModel(
          'Kolczy Napierśnik',
          'Dodaje 10 pancerza',
          'assets/images/two_colors_chestplate.png',
          10,
          ItemTypeModel.chestplate),
          ItemModel(
          'Żelazny Napierśnik',
          'Dodaje 12 pancerza',
          'assets/images/silver_chestplate.png',
          12,
          ItemTypeModel.chestplate),
          ItemModel(
          'Diamentowy Napierśnik',
          'Dodaje 14 pancerza',
          'assets/images/blue_chestplate.png',
          14,
          ItemTypeModel.chestplate),
    ],
    [
      ItemModel(
          'Skórzane Spodnie',
          'Dodają 4 pancerza',
          'assets/images/brown_pants.png',
          4,
          ItemTypeModel.pants),
       ItemModel(
          'Kolcze Spodnie',
          'Dodają 6 pancerza',
          'assets/images/two_colors_pants.png',
          6,
          ItemTypeModel.pants),
       ItemModel(
          'Żelazne Spodnie',
          'Dodają 8 pancerza',
          'assets/images/silver_pants.png',
          8,
          ItemTypeModel.pants),
       ItemModel(
          'Diamentowe Spodnie',
          'Dodają 10 pancerza',
          'assets/images/blue_pants.png',
          10,
          ItemTypeModel.pants),
    ],
    [
      ItemModel(
          'Skórzane Buty',
          'Dodają 1 pancerza',
          'assets/images/brown_boots.png',
          1,
          ItemTypeModel.boots),
      ItemModel(
          'Kolcze Buty',
          'Dodają 3 pancerza',
          'assets/images/two_colors_boots.png',
          3,
          ItemTypeModel.boots),
      ItemModel(
          'Żelazne Buty',
          'Dodają 5 pancerza',
          'assets/images/silver_boots.png',
          5,
          ItemTypeModel.boots),
      ItemModel(
          'Diamentowe Buty',
          'Dodają 7 pancerza',
          'assets/images/blue_boots.png',
          7,
          ItemTypeModel.boots),
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

import 'package:brave_steve/game/data_layer/repo/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data_layer/models/eq_model/eq_model.dart';

final providerEQ =
    StateNotifierProvider<EqStateMenagment, List<ItemPlaceModel>>((ref) {
      final myRepo = ref.watch(repoProvider);
      return EqStateMenagment(myRepo);});

class EqStateMenagment extends StateNotifier<List<ItemPlaceModel>> {
  EqStateMenagment(this.repositoryGame) : super([
    ItemPlaceModel(0, true, FieldTypeModel.helmet, const ItemModel('','','',0,ItemTypeModel.none)),
    ItemPlaceModel(1, true, FieldTypeModel.sword, const ItemModel('','','',0,ItemTypeModel.none)),
    ItemPlaceModel(2, true, FieldTypeModel.chestplate, const ItemModel('','','',0,ItemTypeModel.none)),
    ItemPlaceModel(3, true, FieldTypeModel.pants, const ItemModel('','','',0,ItemTypeModel.none)),
    ItemPlaceModel(4, true, FieldTypeModel.boots, const ItemModel('','','',0,ItemTypeModel.none)),
    ItemPlaceModel(5, true, FieldTypeModel.backpack, const ItemModel('','','',0,ItemTypeModel.none)),
    ItemPlaceModel(6, true, FieldTypeModel.backpack, const ItemModel('','','',0,ItemTypeModel.none)),
    ItemPlaceModel(7, true, FieldTypeModel.backpack, const ItemModel('','','',0,ItemTypeModel.none)),
    ItemPlaceModel(8, true, FieldTypeModel.backpack, const ItemModel('','','',0,ItemTypeModel.none)),
    ItemPlaceModel(9, true, FieldTypeModel.backpack, const ItemModel('','','',0,ItemTypeModel.none)),
    ItemPlaceModel(10, true, FieldTypeModel.backpack, const ItemModel('','','',0,ItemTypeModel.none)),
    ItemPlaceModel(11, true, FieldTypeModel.backpack, const ItemModel('','','',0,ItemTypeModel.none)),
    ItemPlaceModel(12, true, FieldTypeModel.backpack, const ItemModel('','','',0,ItemTypeModel.none)),
    ItemPlaceModel(13, true, FieldTypeModel.backpack, const ItemModel('','','',0,ItemTypeModel.none)),
    ItemPlaceModel(14, true, FieldTypeModel.backpack, const ItemModel('','','',0,ItemTypeModel.none)),
    ItemPlaceModel(15, true, FieldTypeModel.backpack, const ItemModel('','','',0,ItemTypeModel.none)),
    ItemPlaceModel(16, true, FieldTypeModel.backpack, const ItemModel('','','',0,ItemTypeModel.none)),
  ]);
  final RepositoryGame repositoryGame;

  void loadItemPlaceModels(int index){
    List<ItemPlaceModel> o = repositoryGame.getListFieldTypeModelFromDB(index);
    for(int i = 0;i<state.length;i++){
      state[i] = o[i];
    }
  }

  (double,double,bool) ubracsie(int id) {
    double armour = 0;
    double attack = 0;
    if (state[id].isEmpty == false &&
        state[id].classField == FieldTypeModel.backpack) {
          ItemModel itemBeforeWear = state[id].item;
      state = [
        for (final itemPlaceModel in state)
          if (itemPlaceModel.classField == FieldTypeModel.helmet &&
              state[id].item.classItem == ItemTypeModel.helmet &&
              state[0].item.classItem == ItemTypeModel.none)
            ItemPlaceModel(itemPlaceModel.id, false, itemPlaceModel.classField, state[id].item)
          else if (itemPlaceModel.classField == FieldTypeModel.chestplate &&
              state[id].item.classItem == ItemTypeModel.chestplate &&
              state[2].item.classItem == ItemTypeModel.none)
            ItemPlaceModel(itemPlaceModel.id, false, itemPlaceModel.classField, state[id].item)
          else if (itemPlaceModel.classField == FieldTypeModel.sword &&
              state[id].item.classItem == ItemTypeModel.sword &&
              state[1].item.classItem == ItemTypeModel.none)
            ItemPlaceModel(itemPlaceModel.id, false, itemPlaceModel.classField, state[id].item)
          else if (itemPlaceModel.classField == FieldTypeModel.pants &&
              state[id].item.classItem == ItemTypeModel.pants &&
              state[3].item.classItem == ItemTypeModel.none)
            ItemPlaceModel(itemPlaceModel.id, false, itemPlaceModel.classField, state[id].item)
          else if (itemPlaceModel.classField == FieldTypeModel.boots &&
              state[id].item.classItem == ItemTypeModel.boots &&
              state[4].item.classItem == ItemTypeModel.none)
            ItemPlaceModel(itemPlaceModel.id, false, itemPlaceModel.classField, state[id].item)
          else
            itemPlaceModel
      ];
      state = [
        for (final itemPlaceModel in state)
          if (itemPlaceModel.item != const ItemModel('','','',0,ItemTypeModel.none) && itemPlaceModel.id == id)
            ItemPlaceModel(itemPlaceModel.id, true, itemPlaceModel.classField, const ItemModel('','','',0,ItemTypeModel.none))
          else
            itemPlaceModel,
      ];
      if(state[0].item.classItem == ItemTypeModel.helmet){
        armour += state[0].item.statValue.toDouble();
      } if(state[1].item.classItem == ItemTypeModel.sword && itemBeforeWear.classItem == ItemTypeModel.sword){
        attack = state[1].item.statValue.toDouble();
      }if(state[2].item.classItem == ItemTypeModel.chestplate){
       armour += state[2].item.statValue.toDouble();
      } if(state[3].item.classItem == ItemTypeModel.pants){
       armour += state[3].item.statValue.toDouble();
      } if(state[4].item.classItem == ItemTypeModel.boots){
       armour += state[4].item.statValue.toDouble();
      }
    }
    return (armour,attack,true);
  }

  (String, {int value}) getRecord() {
  return ("example", value: 42);
  }

  bool czyPustePole(int id) {
    return state[id].item.classItem == ItemTypeModel.helmet
        ? state[0].isEmpty
        : state[id].item.classItem == ItemTypeModel.chestplate
            ? state[2].isEmpty
            : state[id].item.classItem == ItemTypeModel.sword
                ? state[1].isEmpty
                : state[id].item.classItem == ItemTypeModel.pants
                    ? state[3].isEmpty
                    : state[4].isEmpty;
  }

  (double,double,bool) rozebracsie(int id) {
    double armour = 0;
    double attack = 0;
    if (state[id].isEmpty == false &&
        state[id].classField != FieldTypeModel.backpack) {

      if(state[0].item.classItem == ItemTypeModel.helmet && state[0].id == id){
        armour = - state[0].item.statValue.toDouble();
      }else if(state[1].item.classItem == ItemTypeModel.sword && state[1].id == id){
        attack = -state[1].item.statValue.toDouble();
      }else if(state[2].item.classItem == ItemTypeModel.chestplate && state[2].id == id){
        armour = -state[2].item.statValue.toDouble();
      }else if(state[3].item.classItem == ItemTypeModel.pants && state[3].id == id){
        armour = -state[3].item.statValue.toDouble();
      }else if(state[4].item.classItem == ItemTypeModel.boots && state[4].id == id){
        armour = -state[4].item.statValue.toDouble();
      }

      ItemPlaceModel first = state
          .firstWhere((e) => e.isEmpty && e.classField == FieldTypeModel.backpack);
      state = [
        for (final itemPlaceModel in state)
          if (itemPlaceModel.classField == FieldTypeModel.backpack &&
              itemPlaceModel.isEmpty == true &&
              itemPlaceModel.id == first.id)
            ItemPlaceModel(itemPlaceModel.id, false, itemPlaceModel.classField, state[id].item)
          else
            itemPlaceModel
      ];
      state = [
        for (final itemPlaceModel in state)
          if (itemPlaceModel.classField == FieldTypeModel.helmet && itemPlaceModel.id == id)
            ItemPlaceModel(itemPlaceModel.id, true, itemPlaceModel.classField, const ItemModel('','','',0,ItemTypeModel.none))
          else if (itemPlaceModel.classField == FieldTypeModel.chestplate &&
              itemPlaceModel.id == id)
            ItemPlaceModel(itemPlaceModel.id, true, itemPlaceModel.classField, const ItemModel('','','',0,ItemTypeModel.none))
          else if (itemPlaceModel.classField == FieldTypeModel.sword &&
              itemPlaceModel.id == id)
            ItemPlaceModel(itemPlaceModel.id, true, itemPlaceModel.classField, const ItemModel('','','',0,ItemTypeModel.none))
          else if (itemPlaceModel.classField == FieldTypeModel.pants &&
              itemPlaceModel.id == id)
            ItemPlaceModel(itemPlaceModel.id, true, itemPlaceModel.classField, const ItemModel('','','',0,ItemTypeModel.none))
          else if (itemPlaceModel.classField == FieldTypeModel.boots &&
              itemPlaceModel.id == id)
            ItemPlaceModel(itemPlaceModel.id, true, itemPlaceModel.classField, const ItemModel('','','',0,ItemTypeModel.none))
          else
            itemPlaceModel
      ];
      
    }
    return (armour,attack,false);
  }

  void itemAdd(int listIndex,int itemIndex) {
    final item = repositoryGame.addItem(listIndex,itemIndex);
    final firstFreeItemPlaceModel = state.firstWhere((element) =>
        element.isEmpty == true && element.classField == FieldTypeModel.backpack);
    state = [
      for (final itemplaceModel in state)
        if (itemplaceModel.classField == FieldTypeModel.backpack &&
            itemplaceModel.isEmpty == true &&
            firstFreeItemPlaceModel.id == itemplaceModel.id)
          ItemPlaceModel(itemplaceModel.id, false, itemplaceModel.classField, item)
        else
          itemplaceModel
    ];
  }

  void deleteItem(int id){
    state = [ 
      for (final itemplaceModel in state)
        if (itemplaceModel.classField == FieldTypeModel.backpack &&
            itemplaceModel.isEmpty == false && itemplaceModel.id == id)
          ItemPlaceModel(itemplaceModel.id, true, itemplaceModel.classField, const ItemModel('','','',0,ItemTypeModel.none))
        else
          itemplaceModel
    ];
  }

  void deleteItems(){
    state = [ 
      for (final itemplaceModel in state)
        if (itemplaceModel.isEmpty == false)
          ItemPlaceModel(itemplaceModel.id, true, itemplaceModel.classField, const ItemModel('','','',0,ItemTypeModel.none))
        else
          itemplaceModel
    ];
  }

  String itemUrl(int id) {
    return state[id].item.image;
  }

  EqState isSpace(){
    int fullPlace = 0;int allPlace = 0;
    for (final itemplaceModel in state){
       if (itemplaceModel.classField == FieldTypeModel.backpack &&
            itemplaceModel.isEmpty == false){fullPlace++;} 
      if (itemplaceModel.classField == FieldTypeModel.backpack)allPlace++;
    }
    if(fullPlace == allPlace){
      return EqState.notEnoughtSpace;
    }   
    return EqState.haveFreeSpace; 
  }

  int eqLength(){
    int fullPlace = 0;
    for (final itemplaceModel in state){
       if (itemplaceModel.classField == FieldTypeModel.backpack &&
            itemplaceModel.isEmpty == false){fullPlace++;}}
    return fullPlace;
  }

  Widget showItemInfo(int id) {
    String itemName = state[id].item.name;
    String description = state[id].item.description;
    String image = state[id].item.image;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(itemName),
          Image.asset(image),
          Text(description),
        ],
      ),
    );
  }

  bool isEmpty(int id) {
    return state[id].isEmpty;
  }
}
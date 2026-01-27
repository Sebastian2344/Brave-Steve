import 'package:brave_steve/game/data_layer/repo/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data_layer/models/eq_model/eq_model.dart';

final providerEQ =
    StateNotifierProvider<EqStateMenagment, List<ItemPlaceModel>>((ref) {
      final myRepo = ref.watch(repoProvider);
      return EqStateMenagment(repositoryGame: myRepo);});

class EqStateMenagment extends StateNotifier<List<ItemPlaceModel>> {
  EqStateMenagment({required this.repositoryGame}) : super(const [
    ItemPlaceModel(id:0,isEmpty: true, classField: FieldTypeModel.helmet, item: ItemModel(name: '', description: '', image: '', attack: 0, armour: 0, classItem: ItemTypeModel.none, price: 0)),
    ItemPlaceModel(id:1, isEmpty: true, classField: FieldTypeModel.sword, item: ItemModel(name: '', description: '', image: '', attack: 0, armour: 0, classItem: ItemTypeModel.none, price: 0)),
    ItemPlaceModel(id:2, isEmpty: true, classField: FieldTypeModel.chestplate, item: ItemModel(name: '', description: '', image: '', attack: 0, armour: 0, classItem: ItemTypeModel.none, price: 0)),
    ItemPlaceModel(id:3, isEmpty: true, classField: FieldTypeModel.pants, item: ItemModel(name: '', description:'', image:'', attack: 0, armour: 0, classItem : ItemTypeModel.none ,price : 0)),
    ItemPlaceModel(id :4 ,isEmpty:true,classField : FieldTypeModel.boots,item : ItemModel(name:'',description:'',image:'',attack : 0 ,armour : 0,classItem : ItemTypeModel.none ,price : 0)),
    ItemPlaceModel(id :5 ,isEmpty:true,classField : FieldTypeModel.backpack,item : ItemModel(name:'',description:'',image:'',attack : 0 ,armour : 0,classItem : ItemTypeModel.none ,price : 0)),
    ItemPlaceModel(id:6, isEmpty: true, classField: FieldTypeModel.backpack, item: ItemModel(name: '', description: '', image: '', attack: 0, armour: 0, classItem: ItemTypeModel.none, price: 0)),
    ItemPlaceModel(id:7, isEmpty: true, classField: FieldTypeModel.backpack, item: ItemModel(name: '', description: '', image: '', attack : 0, armour : 0,classItem : ItemTypeModel.none ,price : 0)),
    ItemPlaceModel(id:8, isEmpty : true ,classField : FieldTypeModel.backpack,item : ItemModel(name:'',description:'',image:'',attack : 0 ,armour : 0,classItem : ItemTypeModel.none ,price : 0)),
    ItemPlaceModel(id :9 ,isEmpty:true,classField : FieldTypeModel.backpack,item : ItemModel(name:'',description:'',image:'',attack : 0 ,armour : 0,classItem : ItemTypeModel.none ,price : 0)),
    ItemPlaceModel(id :10 ,isEmpty:true,classField : FieldTypeModel.backpack,item : ItemModel(name:'',description:'',image:'',attack : 0 ,armour : 0,classItem : ItemTypeModel.none ,price : 0)),
    ItemPlaceModel(id:11, isEmpty:true, classField: FieldTypeModel.backpack, item: ItemModel(name:'',description:'',image:'',attack : 0 ,armour : 0,classItem : ItemTypeModel.none ,price: 0)),
    ItemPlaceModel(id:12, isEmpty:true, classField: FieldTypeModel.backpack, item: ItemModel(name:'',description:'',image:'',attack : 0 ,armour : 0,classItem : ItemTypeModel.none ,price: 0)),
    ItemPlaceModel(id:13, isEmpty:true, classField: FieldTypeModel.backpack, item: ItemModel(name:'',description:'',image:'',attack : 0 ,armour : 0,classItem : ItemTypeModel.none ,price: 0)),
    ItemPlaceModel(id:14, isEmpty:true, classField: FieldTypeModel.backpack, item:ItemModel(name:'',description:'',image:'',attack : 0 ,armour : 0,classItem : ItemTypeModel.none,price: 0)),
    ItemPlaceModel(id:15, isEmpty:true, classField: FieldTypeModel.backpack, item: ItemModel(name:'',description:'',image:'',attack : 0 ,armour : 0,classItem : ItemTypeModel.none ,price: 0)),
    ItemPlaceModel(id:16, isEmpty: true, classField: FieldTypeModel.backpack, item: ItemModel(name: '', description: '', image: '', attack: 0, armour: 0, classItem: ItemTypeModel.none, price: 0)),
  ]);
  final RepositoryGame repositoryGame;

  void loadItemPlaceModels(int index){
    List<ItemPlaceModel> o = repositoryGame.getListFieldTypeModelFromDB(index);
    state = [
      for (final itemPlaceModel in o)
        itemPlaceModel
    ];
  }

  (double,double) ubracsie(int id) {
    double attack = 0;
    double armour = 0;
    if (state[id].isEmpty == false &&
        state[id].classField == FieldTypeModel.backpack) {
          ItemModel itemBeforeWear = state[id].item;
      state = [
        for (final itemPlaceModel in state)
          if (itemPlaceModel.classField == FieldTypeModel.helmet &&
              state[id].item.classItem == ItemTypeModel.helmet &&
              state[0].item.classItem == ItemTypeModel.none)
            ItemPlaceModel(id:itemPlaceModel.id,isEmpty: false,classField: itemPlaceModel.classField, item: state[id].item)
          else if (itemPlaceModel.classField == FieldTypeModel.chestplate &&
              state[id].item.classItem == ItemTypeModel.chestplate &&
              state[2].item.classItem == ItemTypeModel.none)
            ItemPlaceModel(id:itemPlaceModel.id,isEmpty: false,classField: itemPlaceModel.classField, item: state[id].item)
          else if (itemPlaceModel.classField == FieldTypeModel.sword &&
              state[id].item.classItem == ItemTypeModel.sword &&
              state[1].item.classItem == ItemTypeModel.none)
            ItemPlaceModel(id:itemPlaceModel.id,isEmpty: false,classField: itemPlaceModel.classField, item: state[id].item)
          else if (itemPlaceModel.classField == FieldTypeModel.pants &&
              state[id].item.classItem == ItemTypeModel.pants &&
              state[3].item.classItem == ItemTypeModel.none)
            ItemPlaceModel(id:itemPlaceModel.id,isEmpty: false,classField: itemPlaceModel.classField, item: state[id].item)
          else if (itemPlaceModel.classField == FieldTypeModel.boots &&
              state[id].item.classItem == ItemTypeModel.boots &&
              state[4].item.classItem == ItemTypeModel.none)
            ItemPlaceModel(id:itemPlaceModel.id,isEmpty: false,classField: itemPlaceModel.classField, item: state[id].item)
          else
            itemPlaceModel
      ];
      state = [
        for (final itemPlaceModel in state)
          if (itemPlaceModel.item != const ItemModel(name: '', description: '', image: '', attack: 0, armour: 0, classItem: ItemTypeModel.none, price: 0) && itemPlaceModel.id == id)
            ItemPlaceModel(id:itemPlaceModel.id,isEmpty: true,classField: itemPlaceModel.classField, item: const ItemModel(name: '', description: '', image: '', attack: 0, armour: 0, classItem: ItemTypeModel.none, price: 0))
          else
            itemPlaceModel,
      ];
      
        armour = itemBeforeWear.armour.toDouble();
        attack = itemBeforeWear.attack.toDouble();
    }
    return (armour,attack);
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

  (double,double) rozebracsie(int id) {
    double armour = 0;
    double attack = 0;
    
    if (state[id].isEmpty == false &&
        state[id].classField != FieldTypeModel.backpack) {

      armour -= state[id].item.armour.toDouble();
      attack -= state[id].item.attack.toDouble();
      
      //if(state[0].item.classItem == ItemTypeModel.helmet && state[0].id == id){
      //  armour = - state[0].item.armour.toDouble();
      //}else if(state[1].item.classItem == ItemTypeModel.sword && state[1].id == id){
      //  attack = -state[1].item.attack.toDouble();
      //}else if(state[2].item.classItem == ItemTypeModel.chestplate && state[2].id == id){
      //  armour = -state[2].item.armour.toDouble();
      //}else if(state[3].item.classItem == ItemTypeModel.pants && state[3].id == id){
      //  armour = -state[3].item.armour.toDouble();
      //}else if(state[4].item.classItem == ItemTypeModel.boots && state[4].id == id){
      //  armour = -state[4].item.armour.toDouble();
      //}

      ItemPlaceModel first = state
          .firstWhere((e) => e.isEmpty && e.classField == FieldTypeModel.backpack);
      state = [
        for (final itemPlaceModel in state)
          if (itemPlaceModel.classField == FieldTypeModel.backpack &&
              itemPlaceModel.isEmpty == true &&
              itemPlaceModel.id == first.id)
            ItemPlaceModel(id: itemPlaceModel.id, isEmpty: false, classField: itemPlaceModel.classField, item: state[id].item)
          else
            itemPlaceModel
      ];
      state = [
        for (final itemPlaceModel in state)
          if (itemPlaceModel.classField == FieldTypeModel.helmet && itemPlaceModel.id == id)
            ItemPlaceModel(id: itemPlaceModel.id, isEmpty: true, classField: itemPlaceModel.classField, item: const ItemModel(name: '', description: '', image: '', attack: 0, armour: 0, classItem: ItemTypeModel.none, price: 0))
          else if (itemPlaceModel.classField == FieldTypeModel.chestplate &&
              itemPlaceModel.id == id)
            ItemPlaceModel(id: itemPlaceModel.id, isEmpty: true, classField: itemPlaceModel.classField, item: const ItemModel(name: '', description: '', image: '', attack: 0, armour: 0, classItem: ItemTypeModel.none, price: 0))
          else if (itemPlaceModel.classField == FieldTypeModel.sword &&
              itemPlaceModel.id == id)
            ItemPlaceModel(id: itemPlaceModel.id, isEmpty: true, classField: itemPlaceModel.classField, item: const ItemModel(name: '', description: '', image: '', attack: 0, armour: 0, classItem: ItemTypeModel.none, price: 0))
          else if (itemPlaceModel.classField == FieldTypeModel.pants &&
              itemPlaceModel.id == id)
            ItemPlaceModel(id: itemPlaceModel.id, isEmpty: true, classField: itemPlaceModel.classField, item: const ItemModel(name: '', description: '', image: '', attack: 0, armour: 0, classItem: ItemTypeModel.none, price: 0))
          else if (itemPlaceModel.classField == FieldTypeModel.boots &&
              itemPlaceModel.id == id)
            ItemPlaceModel(id: itemPlaceModel.id, isEmpty: true, classField: itemPlaceModel.classField, item: const ItemModel(name: '', description: '', image: '', attack: 0, armour: 0, classItem: ItemTypeModel.none, price: 0))
          else
            itemPlaceModel
      ];
      
    }
    return (armour,attack);
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
          ItemPlaceModel(id: itemplaceModel.id, isEmpty: false, classField: itemplaceModel.classField, item: item)
        else
          itemplaceModel
    ];
  }

  (double,double) deleteItem(int id){
    double armour = 0;
    double attack = 0;

    if (state[id].isEmpty == false &&
        state[id].classField != FieldTypeModel.backpack) {
      armour -= state[id].item.armour.toDouble();
      attack -= state[id].item.attack.toDouble();
    }

    state = [ 
      for (final itemplaceModel in state)
        if (itemplaceModel.isEmpty == false && itemplaceModel.id == id)
          ItemPlaceModel(id: itemplaceModel.id, isEmpty: true, classField: itemplaceModel.classField, item: const ItemModel(name: '', description: '', image: '', attack: 0, armour: 0, classItem: ItemTypeModel.none, price: 0))
        else
          itemplaceModel
    ];
    
    return (armour,attack);
  }

  void deleteItems(){
    state = [ 
      for (final itemplaceModel in state)
        if (itemplaceModel.isEmpty == false)
          ItemPlaceModel(id: itemplaceModel.id, isEmpty: true, classField: itemplaceModel.classField, item: const ItemModel(name: '', description: '', image: '', attack: 0, armour: 0, classItem: ItemTypeModel.none, price: 0))
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
          Image.asset(image, cacheWidth: 256, cacheHeight: 256),
          Text(description),
        ],
      ),
    );
  }

  bool isEmpty(int id) {
    return state[id].isEmpty;
  }
}
import 'dart:math';

import 'package:brave_steve/game/data_layer/data_source/data_box/box.dart';
import 'package:brave_steve/game/data_layer/data_source/items/items.dart';
import 'package:brave_steve/game/data_layer/models/eq_model/eq_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EqRepo {
  final Items items;
  final DataBox dataSource;
  const EqRepo({required this.items, required this.dataSource});

  ItemModel? getDrawnItem(int dropRate){
    Rarity rarity = Rarity.common;
    int chance = Random().nextInt(100);
    if(chance >= dropRate){
      return null;
    }
    ItemSet itemSet = ItemSet.values[Random().nextInt(ItemSet.values.length)];
    ItemTypeModel itemType = ItemTypeModel.values[Random().nextInt(ItemTypeModel.values.length-1)];
    return items.getItem(itemSet, itemType, rarity);
  }

  List<ItemPlaceModel> getListFieldTypeModelFromDB(int index){
    return dataSource.getItemPlacesFromDB(index).map((e) => e.toItemPlaceModel()).toList();
  }
}

Provider<EqRepo> eqRepoProvider = Provider((ref) => EqRepo(items: Items(), dataSource: ref.watch(dataBoxProvider)));
import 'dart:math';

import 'package:brave_steve/core/modules/data_source/box.dart';
import 'package:brave_steve/core/modules/items/items.dart';
import 'package:brave_steve/core/modules/models/enums.dart';
import 'package:brave_steve/modules/eq/model/eq_model.dart';

class EqRepo {
  final Items items;
  final DataBox dataSource;
  const EqRepo({required this.items, required this.dataSource});

  ItemModel? getDrawnItem(int dropRate) {
    Rarity rarity = Rarity.common;
    int chance = Random().nextInt(100);
    if (chance >= dropRate) {
      return null;
    }
    ItemSet itemSet = ItemSet.values[Random().nextInt(ItemSet.values.length - 1)];
    ItemTypeModel itemType =
        ItemTypeModel.values[Random().nextInt(ItemTypeModel.values.length - 1)];
    return items.getItem(itemSet, itemType, rarity);
  }

  List<ItemPlaceModel> getListFieldTypeModelFromDB(int index) {
    return dataSource
        .getItemPlacesFromDB(index)
        .map((e) => e.toItemPlaceModel())
        .toList();
  }

  bool isItemMaxLevel(int level, String rarity) {
    late Rarity rarityEnum;
    if(rarity == 'common'){
      rarityEnum = Rarity.common;
    } else if(rarity == 'uncommon'){
      rarityEnum = Rarity.uncommon;
    } else if(rarity == 'rare'){
      rarityEnum = Rarity.rare;
    } else if(rarity == 'epic'){
      rarityEnum = Rarity.epic;
    } else if(rarity == 'legendary'){
      rarityEnum = Rarity.legendary;
    } else {
      rarityEnum = Rarity.mithic;
    }
    return items.isItemMaxLevel(level, rarityEnum);
  }

  String getMaxLevel(String rarity) {
    late Rarity rarityEnum;
    if(rarity == 'common'){
      rarityEnum = Rarity.common;
    } else if(rarity == 'uncommon'){
      rarityEnum = Rarity.uncommon;
    } else if(rarity == 'rare'){
      rarityEnum = Rarity.rare;
    } else if(rarity == 'epic'){
      rarityEnum = Rarity.epic;
    } else if(rarity == 'legendary'){
      rarityEnum = Rarity.legendary;
    } else {
      rarityEnum = Rarity.mithic;
    }
    return items.getMaxLevel(rarityEnum);
  }
}
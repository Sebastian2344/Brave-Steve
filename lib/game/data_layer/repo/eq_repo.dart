import 'dart:math';

import 'package:brave_steve/game/data_layer/data_source/data_box/box.dart';
import 'package:brave_steve/game/data_layer/data_source/items/items.dart';
import 'package:brave_steve/game/data_layer/models/eq_model/eq_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

Provider<EqRepo> eqRepoProvider = Provider(
    (ref) => EqRepo(items: ref.watch(itemsProvider), dataSource: ref.watch(dataBoxProvider)));

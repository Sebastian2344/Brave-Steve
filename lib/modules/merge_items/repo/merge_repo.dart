import 'package:brave_steve/core/modules/items/items.dart';
import 'package:brave_steve/core/modules/models/enums.dart';
import 'package:brave_steve/modules/merge_items/menagment/merge_item_state.dart';

class MergeRepo {
  final Items items;
  const MergeRepo({required this.items});

  MergeItemModel takeBetterItem(String rarity, ItemTypeModel classItem,int? numerZestawu) {
    if(rarity == 'legendary') {
      rarity = 'mithic';
    } else if(rarity == 'epic') {
      rarity = 'legendary';
    } else if(rarity == 'rare') {
      rarity = 'epic';
    } else if(rarity == 'uncommon') {
      rarity = 'rare';
    } else if(rarity == 'common') {
      rarity = 'uncommon';
    }
    Rarity rarityEnum = Rarity.values.firstWhere((r) => r.toString().split('.').last == rarity);
    ItemSet itemSet = ItemSet.values[numerZestawu == null? 4 : numerZestawu - 1];
    final i = items.getItem(itemSet, classItem, rarityEnum);
    MergeItemModel mergeItem = MergeItemModel(
      fromEQId: 0,
      name: i.name,
      description: i.description,
      image: i.image,
      attack: i.attack,
      armour: i.armour,
      classItem: i.classItem,
      price: i.price,
      itemLevel: i.itemLevel,
      upgradePrice: i.upgradePrice,
      itemRarity: i.itemRarity,
      numerZestawu: i.numerZestawu
    );
    return mergeItem;
  }
  
}
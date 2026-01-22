import 'package:hive_flutter/hive_flutter.dart';

import '../../models/eq_model/eq_model.dart';
part 'eq.g.dart';

@HiveType(typeId: 2)
class ItemPlace extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final bool isEmpty;
  @HiveField(2)
  final FieldType classField;
  @HiveField(3)
  final Item item;
  ItemPlace({required this.id,required  this.isEmpty,required  this.classField,required  this.item});

  ItemPlaceModel toItemPlaceModel() {
    return ItemPlaceModel(id: id, isEmpty: isEmpty, classField: classField.toFieldTypeModel(classField), item: item.toItemModel());
  }

  static List<ItemPlace> toItemPlace(List<ItemPlaceModel> model) {
    List<ItemPlace> itemPlaceList = [];
    int i = 0;
    while (itemPlaceList.length < model.length) {
      itemPlaceList.add(ItemPlace(
          id:model[i].id,
          isEmpty: model[i].isEmpty,
          classField: FieldType.toFieldType(model[i].classField),
          item: Item.toItem(model[i].item)));
      i++;
    }
    return itemPlaceList;
  }
}

@HiveType(typeId: 3)
class Item {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String description;
  @HiveField(2)
  final String image;
  @HiveField(3)
  final ItemType classItem;
  @HiveField(4)
  final int price;
  @HiveField(5)
  final int attack;
  @HiveField(6)
  final int armour;

  const Item({
    required this.name,
    required this.description,
    required this.image,
    required this.classItem,
    required this.price,
    required this.attack,
    required this.armour,
  });

  ItemModel toItemModel() {
    return ItemModel(name: name, description: description, image: image, attack: attack, armour: armour, classItem: classItem.toItemTypeModel(classItem), price: price);
  }

  static Item toItem(ItemModel model) {
    return Item(
        name: model.name,
        description: model.description,
        image: model.image,
        classItem: ItemType.toItemType(model),
        price: model.price,
        attack: model.attack,
        armour: model.armour);
  }
}

@HiveType(typeId: 4)
enum FieldType {
  @HiveField(0)
  helmet,
  @HiveField(1)
  chestplate,
  @HiveField(2)
  sword,
  @HiveField(3)
  pants,
  @HiveField(4)
  boots,
  @HiveField(5)
  backpack;

  static FieldType toFieldType(FieldTypeModel model) {
    if (model == FieldTypeModel.boots) {
      return FieldType.boots;
    } else if (model == FieldTypeModel.chestplate) {
      return FieldType.chestplate;
    } else if (model == FieldTypeModel.pants) {
      return FieldType.pants;
    } else if (model == FieldTypeModel.helmet) {
      return FieldType.helmet;
    } else if (model == FieldTypeModel.sword) {
      return FieldType.sword;
    } else {
      return FieldType.backpack;
    }
  }

  FieldTypeModel toFieldTypeModel(FieldType type){
    FieldTypeModel w;
    switch(type){
      case FieldType.backpack: w = FieldTypeModel.backpack; break;
      case FieldType.helmet: w = FieldTypeModel.helmet; break;
      case FieldType.chestplate: w = FieldTypeModel.chestplate; break;
      case FieldType.pants: w = FieldTypeModel.pants; break;
      case FieldType.boots: w = FieldTypeModel.boots; break;
      case FieldType.sword: w = FieldTypeModel.sword; break;}
    return w;
  }
}

@HiveType(typeId: 5)
enum ItemType {
  @HiveField(0)
  helmet,
  @HiveField(1)
  chestplate,
  @HiveField(2)
  sword,
  @HiveField(3)
  pants,
  @HiveField(4)
  boots,
  @HiveField(5)
  none;

  static ItemType toItemType(ItemModel model) {
    if (model.classItem == ItemTypeModel.boots) {
      return ItemType.boots;
    } else if (model.classItem == ItemTypeModel.chestplate) {
      return ItemType.chestplate;
    } else if (model.classItem == ItemTypeModel.pants) {
      return ItemType.pants;
    } else if (model.classItem == ItemTypeModel.helmet) {
      return ItemType.helmet;
    } else if (model.classItem == ItemTypeModel.sword) {
      return ItemType.sword;
    }else {
      return ItemType.none;
    }
  }

   ItemTypeModel toItemTypeModel(ItemType type){
    ItemTypeModel w;
    switch(type){
      case ItemType.helmet: w = ItemTypeModel.helmet; break;
      case ItemType.chestplate: w = ItemTypeModel.chestplate; break;
      case ItemType.pants: w = ItemTypeModel.pants; break;
      case ItemType.boots: w = ItemTypeModel.boots; break;
      case ItemType.sword: w = ItemTypeModel.sword; break;
      case ItemType.none: w = ItemTypeModel.none; break;}
    return w;
  }
}
